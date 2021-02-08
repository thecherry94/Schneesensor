#include <stdint.h>
#include <stdbool.h>
#include <stddef.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

/* DEFINES */
#define TWI_INSTANCE_ID 0
#define SPI_INSTANCE_ID 1


/* INCLUDES */

#include "boards.h"

#include "nrf_drv_twi.h"
#include "nrf_drv_spi.h"
#include "app_error.h"
#include "app_util_platform.h"
#include "nrf_delay.h"

#include "nrf_log.h"
#include "nrf_log_ctrl.h"
#include "nrf_log_default_backends.h"


#include <math.h>

#include "snow_bme680.h"


/* FUNCTION DECLARATIONS */
void twi_init();

void test_bme();


typedef struct accl_xyz_t {
    int8_t x;
    int8_t y;
    int8_t z;
} accl_xyz_t;


typedef struct accl_xyz_sx_t {
    uint8_t x_msb;
    uint8_t x_lsb;
    uint8_t y_msb;
    uint8_t y_lsb;
    uint8_t z_msb;
    uint8_t z_lsb;
} accl_xyz_sx_t;


ret_code_t adxl362_read_accl(accl_xyz_t* accl);


/* GLOBAL VARIABLES */
static const nrf_drv_twi_t m_twi = NRF_DRV_TWI_INSTANCE(TWI_INSTANCE_ID);
static const nrf_drv_spi_t m_spi = NRF_DRV_SPI_INSTANCE(SPI_INSTANCE_ID);

static volatile bool spi_xfer_done;

static uint8_t last_spi_cmd = 0;

#define ADXL362_INIT 1
#define ADXL362_READ_X 2
#define ADXL362_READ_Y 3
#define ADXL362_READ_Z 4
#define ADXL362_READ_STATUS 5


static uint8_t m_rx_buf[8];





void spi_event_handler(nrf_drv_spi_evt_t const * p_event,
                       void *                    p_context)
{
    nrf_gpio_pin_set(23);
    spi_xfer_done = true;
}



//========= MAIN ====================
int main(void) { // renamed to mainThread() on CCxxyy

    twi_init();

    //test_bme();

    nrf_gpio_cfg_output(23);
    nrf_gpio_pin_set(23);

    nrf_delay_ms(100);
    
    
    nrf_drv_spi_config_t spi_config = NRF_DRV_SPI_DEFAULT_CONFIG;
    spi_config.ss_pin = SPI_SS_PIN;
    spi_config.miso_pin = SPI_MISO_PIN;
    spi_config.mosi_pin = SPI_MOSI_PIN;
    spi_config.sck_pin = SPI_SCK_PIN;
    spi_config.frequency = NRF_DRV_SPI_FREQ_1M;
    spi_config.mode = NRF_DRV_SPI_MODE_0;
    ret_code_t err_code = nrf_drv_spi_init(&m_spi, &spi_config, NULL, NULL);

    nrf_delay_ms(10);

    uint8_t init_buf[] = 
        { 0x0A, //write
          0x20, //THRESH_ACT_L Startadresse
          0x6D, //THRESH_ACT_L Wert
          0x00, //TREHS_ACT_H Wert
          0x00, //TIME_ACT Wert
          0x6D, //THRESH_INACT_L Wert
          0x00, //THRESH_INACT_H Wert
          0x00, //TIME_INACT_L Wert
          0x00, //TIME_INACT_H Wert
          0x03, //ACT_INACT_CTL Wert
          0x00, //FIFO_CONTROL Wert
          0x00, //FIFO_SAMPLES Wert
          0x90, //INTMAP1 Wert
          0x00, //INTMAP2 Wert
          0x00, //FILTER_CTL Wert 0x00 <=> 2g; 0x40 <=> 4g; 0x80 <=> 8g
          0x0E  //POWER_CTL Wert
     };
    
    
    nrf_gpio_pin_clear(23);
    nrf_drv_spi_transfer(&m_spi, init_buf, sizeof(init_buf), NULL, 0);
    nrf_gpio_pin_set(23);

    nrf_delay_ms(10);

    // Read device ID
    const uint8_t tx_buf[] = { 0x0B, 0x02, 0 };
    
    //const uint8_t reset[] = { 0x0A, 0x1F, 0x52 };
    //APP_ERROR_CHECK(nrf_drv_spi_transfer(&m_spi, reset, 3, NULL, 0));

    accl_xyz_t accl = {0};
    
    for (;;) {
        adxl362_read_accl(&accl);

        nrf_delay_ms(500);
    }
}



ret_code_t adxl362_read_accl(accl_xyz_t* accl) {

    accl_xyz_sx_t xyz_sx = {0};

    uint8_t tx_buf[] = {
        0x0B,   // Command read
        0x0E,   // Read X-Axis LSB Register
        0x00,
        0x00,
        0x00,
        0x00,
        0x00,   // Burst Read all data registers up to Z-Axis MSB Register
        0x00
    };
    
    // rx_buf[0] <=> 0
    // rx_buf[1] <=> 0
    // rx_buf[2] <=> X LSB
    // rx_buf[3] <=> X MSB
    // rx_buf[4] <=> Y LSB
    // rx_buf[5] <=> Y MSB
    // rx_buf[6] <=> Z LSB
    // rx_buf[7] <=> Z MSB
    uint8_t rx_buf[8] = {0};
    uint8_t len = 8;

    nrf_gpio_pin_clear(23);
    ret_code_t err_code = nrf_drv_spi_transfer(&m_spi, tx_buf, len, rx_buf, len);
    nrf_gpio_pin_set(23);

    uint16_t x;
    uint16_t y;
    uint16_t z;
    
    
    // ADXL362 Datasheet page 26
    x = rx_buf[3] & 0x0F;
    x <<= 8;
    x |= rx_buf[2];

    y = rx_buf[5] & 0x0F;
    y <<= 8;
    y |= rx_buf[4];

    z = rx_buf[7] & 0x0F;
    z <<= 8;
    z |= rx_buf[6];
    

    if (x & 0x800) {
        // negative
        x &= 0x07FF;
        x ^= 0xFFFF;
        //x--;       
    }

    if (y & 0x800) {
        // negative
        y &= 0x07FF;
        y ^= 0xFFFF;
        //y--;       
    }

    if (z & 0x800) {
        // negative
        z &= 0x07FF;
        z ^= 0xFFFF;
        //z--;       
    }

    float x_retval = *((int16_t*)&x) / 1000.0f;
    float y_retval = *((int16_t*)&y) / 1000.0f;
    float z_retval = *((int16_t*)&z) / 1000.0f;

    printf("X: %.2f; Y: %.2f; Z: %.2f;\n", x_retval, y_retval, z_retval);

    volatile int i = 0;
}




void test_bme() {
    snow_bme680_init(&m_twi, 10);
    snow_bme680_conf();

    struct bme680_field_data data;

    for (;;) {
        snow_bme680_measure(&data, true);
        

        printf("T: %.2f degC, P: %.2f hPa, H %.2f %%rH\n", data.temperature / 100.0f,
            data.pressure / 100.0f, data.humidity / 1000.0f);
    }
}


void twi_init() {
    ret_code_t err_code;

    const nrf_drv_twi_config_t twi_conf = {
        .scl = ARDUINO_SCL_PIN,
        .sda = ARDUINO_SDA_PIN,
        .frequency = NRF_DRV_TWI_FREQ_100K,
        .interrupt_priority = APP_IRQ_PRIORITY_LOW,
        .clear_bus_init = true
    };

    err_code = nrf_drv_twi_init(&m_twi, &twi_conf, NULL, NULL);
    APP_ERROR_CHECK(err_code);

    nrf_drv_twi_enable(&m_twi);
}

