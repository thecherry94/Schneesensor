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
#include "snow_adxl362.h"


/* FUNCTION DECLARATIONS */
void twi_init();

void test_bme();


snow_adxl362_ret_code_t nrf_spi_transfer(uint8_t* tx_buf, uint8_t tx_len, uint8_t* rx_buf, uint8_t rx_len);


ret_code_t spi_init();


/* GLOBAL VARIABLES */
static const nrf_drv_twi_t m_twi = NRF_DRV_TWI_INSTANCE(TWI_INSTANCE_ID);
static const nrf_drv_spi_t m_spi = NRF_DRV_SPI_INSTANCE(SPI_INSTANCE_ID);



/*
void spi_event_handler(nrf_drv_spi_evt_t const * p_event,
                       void *                    p_context)
{
    nrf_gpio_pin_set(23);
    spi_xfer_done = true;
}
*/


//========= MAIN ====================
int main(void) { // renamed to mainThread() on CCxxyy

    ret_code_t err_code;

    twi_init();

    //test_bme();

    nrf_gpio_cfg_output(23);
    nrf_gpio_pin_set(23);

    nrf_delay_ms(10);
    
    
    spi_init();

    snow_adxl362_init(&m_spi, nrf_spi_transfer);
    snow_adxl362_soft_reset(true);

    // ADXL362 Sensor configuration
    //
    snow_adxl362_config_t adxl362_cfg = {
        .filter_control = 
        SNOW_ADXL362_VAL_FILTER_ODR_100 | 
        SNOW_ADXL362_VAL_FILTER_EXT_SAMPLE_OFF | 
        SNOW_ADXL362_VAL_FILTER_BW_HALF | 
        SNOW_ADXL362_VAL_FILTER_SENS_2G,

        .power_control = 
        SNOW_ADXL362_VAL_PWR_MEASURE |
        SNOW_ADXL362_VAL_PWR_AUTOSLEEP_OFF |
        SNOW_ADXL362_VAL_PWR_WAKEUP_OFF | 
        SNOW_ADXL362_VAL_PWR_NOISE_NORMAL | 
        SNOW_ADXL362_VAL_PWR_EXT_CLOCK_OFF,

        .activity_control = 
        SNOW_ADXL362_VAL_ACT_ACT_EN_OFF |
        SNOW_ADXL362_VAL_ACT_REF_OFF | 
        SNOW_ADXL362_VAL_ACT_INACT_OFF |
        SNOW_ADXL362_VAL_ACT_INACT_REF_OFF | 
        SNOW_ADXL362_VAL_ACT_LL_DEFAULT,

        .fifo_control = 
        SNOW_ADXL362_VAL_FIFO_DISABLED |
        SNOW_ADXL362_VAL_FIFO_TEMP_OFF | 
        SNOW_ADXL362_VAL_FIFO_ABOVE_HALF_OFF,

        .intmap1 = 
        SNOW_ADXL362_VAL_INTMAP_DATA_READY_OFF |
        SNOW_ADXL362_VAL_INTMAP_FIFO_READY_OFF |
        SNOW_ADXL362_VAL_INTMAP_FIFO_WM_OFF |
        SNOW_ADXL362_VAL_INTMAP_FIFO_OV_OFF |
        SNOW_ADXL362_VAL_INTMAP_ACTIVITY_OFF |
        SNOW_ADXL362_VAL_INTMAP_INACTIVITY_OFF |
        SNOW_ADXL362_VAL_INTMAP_AWAKE_OFF |
        SNOW_ADXL362_VAL_INTMAP_ACTIVE_LOW_OFF,

        .intmap2 = 
        SNOW_ADXL362_VAL_INTMAP_DATA_READY_OFF |
        SNOW_ADXL362_VAL_INTMAP_FIFO_READY_OFF |
        SNOW_ADXL362_VAL_INTMAP_FIFO_WM_OFF |
        SNOW_ADXL362_VAL_INTMAP_FIFO_OV_OFF |
        SNOW_ADXL362_VAL_INTMAP_ACTIVITY_OFF |
        SNOW_ADXL362_VAL_INTMAP_INACTIVITY_OFF |
        SNOW_ADXL362_VAL_INTMAP_AWAKE_OFF |
        SNOW_ADXL362_VAL_INTMAP_ACTIVE_LOW_OFF,
        
        .threshold_active = 0x6D,

        .time_active = 0x00,

        .threshold_inactive = 0x6D,

        .time_inactive = 0x00
    };

    float temp = 0;
    
    

    snow_adxl362_configure(&adxl362_cfg, true);
    


    snow_adxl362_config_t cfg2 = {0};
    snow_adxl362_read_config(&cfg2);

    snow_accl_xyz_t accl = {0};
    for (;;) {
        snow_adxl362_read_accl(&accl);
        snow_adxl362_read_temp(&temp);
        printf("X: %.2f | Y:%.2f | Z: %.2f | T: %.2f\n", accl.x, accl.y, accl.z, temp);
        
        snow_adxl362_self_test_t test = 0;

        snow_adxl362_perform_self_test(&test, 16);

        nrf_delay_ms(100);
    }
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


ret_code_t spi_init() {
    nrf_drv_spi_config_t spi_config = NRF_DRV_SPI_DEFAULT_CONFIG;
    spi_config.ss_pin = SPI_SS_PIN;
    spi_config.miso_pin = SPI_MISO_PIN;
    spi_config.mosi_pin = SPI_MOSI_PIN;
    spi_config.sck_pin = SPI_SCK_PIN;
    spi_config.frequency = NRF_DRV_SPI_FREQ_125K;
    spi_config.mode = NRF_DRV_SPI_MODE_0;
    ret_code_t err_code = nrf_drv_spi_init(&m_spi, &spi_config, NULL, NULL);
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


snow_adxl362_ret_code_t nrf_spi_transfer(uint8_t* tx_buf, uint8_t tx_len, uint8_t* rx_buf, uint8_t rx_len) {
    nrf_gpio_pin_clear(SNOW_ADXL362_CS_PIN);
    ret_code_t err_code = nrf_drv_spi_transfer(&m_spi, tx_buf, tx_len, rx_buf, rx_len);
    nrf_gpio_pin_set(SNOW_ADXL362_CS_PIN);

    return err_code == NRF_SUCCESS ? SNOW_ADXL362_OK : SNOW_ADXL362_SPI_ERROR;
}

