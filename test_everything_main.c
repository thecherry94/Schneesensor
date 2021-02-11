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
void test_adxl362();
void test_everything();
    



snow_adxl362_ret_code_t nrf_spi_transfer(uint8_t* tx_buf, uint8_t tx_len, uint8_t* rx_buf, uint8_t rx_len, uint8_t cs_pin);


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

    //test_bme();
    //test_adxl362();
    test_everything();
    
}

void test_bme() {
    twi_init();

    struct bme680_dev bme;

    uint16_t meas_period = 0;

    snow_bme680_init(&bme, &m_twi, 10);
    snow_bme680_configure(&bme, &meas_period);

    struct bme680_field_data data;

    for (;;) {
        snow_bme680_measure(&bme, &data, true);
        

        printf("T: %.2f degC, P: %.2f hPa, H: %.2f %%rH\n", data.temperature / 100.0f,
            data.pressure / 100.0f, data.humidity / 1000.0f);

        nrf_delay_ms(100);

    }
}


void test_adxl362() {

    spi_init();

    nrf_delay_ms(10);

    snow_adxl362_device device = snow_adxl362_create_device(23, NULL);

    snow_adxl362_init(&device, &m_spi, nrf_spi_transfer);
    snow_adxl362_soft_reset(&device, true);
    snow_adxl362_configure(&device, true);


    snow_adxl362_device device2 = snow_adxl362_create_device(38, NULL);

    snow_adxl362_init(&device2, &m_spi, nrf_spi_transfer);
    snow_adxl362_soft_reset(&device2, true);
    snow_adxl362_configure(&device2, true);

    snow_accl_xyz_t accl = {0};
    float temp = 0;
    for (;;) {
        snow_adxl362_read_accl(&device, &accl);
        snow_adxl362_read_temp(&device, &temp);
        printf("ADXL362_1: X: %.2f | Y:%.2f | Z: %.2f | T: %.2f\n", accl.x, accl.y, accl.z, temp);

        snow_adxl362_read_accl(&device2, &accl);
        snow_adxl362_read_temp(&device2, &temp);
        printf("ADXL362_2: X: %.2f | Y:%.2f | Z: %.2f | T: %.2f\n\n", accl.x, accl.y, accl.z, temp);
        
        //snow_adxl362_self_test_t test = 0;
        //snow_adxl362_perform_self_test(&device, &test, 16);

        nrf_delay_ms(100);
    }
}


void test_everything() {
    // Init interfaces 
    //
    spi_init();
    twi_init();

    // Init both ADXL362
    //
    snow_adxl362_device device = snow_adxl362_create_device(23, NULL);

    snow_adxl362_init(&device, &m_spi, nrf_spi_transfer);
    snow_adxl362_soft_reset(&device, true);
    snow_adxl362_configure(&device, true);


    snow_adxl362_device device2 = snow_adxl362_create_device(38, NULL);

    snow_adxl362_init(&device2, &m_spi, nrf_spi_transfer);
    snow_adxl362_soft_reset(&device2, true);
    snow_adxl362_configure(&device2, true);

    // Init BME680
    struct bme680_dev bme;

    uint16_t meas_period = 0;

    snow_bme680_init(&bme, &m_twi, 10);
    snow_bme680_configure(&bme, &meas_period);

    struct bme680_field_data data;
    snow_accl_xyz_t accl = {0};
    float temp = 0;
    for (;;) {
        snow_adxl362_read_accl(&device, &accl);
        snow_adxl362_read_temp(&device, &temp);
        printf("ADXL362_1\t=> X: %.2f | Y:%.2f | Z: %.2f | T: %.2f\n", accl.x, accl.y, accl.z, temp);

        snow_adxl362_read_accl(&device2, &accl);
        snow_adxl362_read_temp(&device2, &temp);
        printf("ADXL362_2\t=> X: %.2f | Y:%.2f | Z: %.2f | T: %.2f\n", accl.x, accl.y, accl.z, temp);
        
        //snow_adxl362_self_test_t test = 0;
        //snow_adxl362_perform_self_test(&device, &test, 16);

        snow_bme680_measure(&bme, &data, false);
        
        printf("BME680   \t=> T: %.2f degC, P: %.2f hPa, H: %.2f %%rH\n\n", data.temperature / 100.0f,
            data.pressure / 100.0f, data.humidity / 1000.0f);
        
        nrf_delay_ms(100);
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


snow_adxl362_ret_code_t nrf_spi_transfer(uint8_t* tx_buf, uint8_t tx_len, uint8_t* rx_buf, uint8_t rx_len, uint8_t cs_pin) {
    nrf_gpio_pin_clear(cs_pin);
    ret_code_t err_code = nrf_drv_spi_transfer(&m_spi, tx_buf, tx_len, rx_buf, rx_len);
    nrf_gpio_pin_set(cs_pin);

    return err_code == NRF_SUCCESS ? SNOW_ADXL362_OK : SNOW_ADXL362_SPI_ERROR;
}

