
#include <stdint.h>
#include <stdbool.h>
#include <stddef.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>


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

#include "snow_slave.h"


#include <math.h>


// Member variables
//
static const nrf_drv_twi_t m_twi = NRF_DRV_TWI_INSTANCE(TWI_INSTANCE_ID);
static const nrf_drv_spi_t m_spi = NRF_DRV_SPI_INSTANCE(SPI_INSTANCE_ID);







uint8_t snow_slave_init() {
    ret_code_t err_code;

    err_code = spi_init();


    #ifdef __DEBUG__
    printf ("[DEBUG] SPI initialization %s\n", err_code == NRF_SUCCESS ? "successful" : "failed");
    #endif

    err_code = twi_init();

    #ifdef __DEBUG__
    printf ("[DEBUG] TWI initialization %s\n", err_code == NRF_SUCCESS ? "successful" : "failed");
    #endif

    #ifdef __DEBUG__
    printf ("[DEBUG] Snow sensor slave initialization %s\n", err_code == NRF_SUCCESS ? "successful" : "failed");
    #endif

    return err_code;
}

uint8_t snow_slave_run() {
    #ifdef __DEBUG__
    test_everything();
    #endif
}



uint8_t snow_slave_measure(uint8_t meas_params, uint8_t num_samples) {
    
}



uint8_t snow_slave_check_components(uint8_t components) {
    
}





ret_code_t spi_init() {
    nrf_drv_spi_config_t spi_config = NRF_DRV_SPI_DEFAULT_CONFIG;
    spi_config.ss_pin = SPI_SS_PIN;
    spi_config.miso_pin = SPI_MISO_PIN;
    spi_config.mosi_pin = SPI_MOSI_PIN;
    spi_config.sck_pin = SPI_SCK_PIN;
    spi_config.frequency = NRF_DRV_SPI_FREQ_1M;
    spi_config.mode = NRF_DRV_SPI_MODE_0;
    ret_code_t err_code = nrf_drv_spi_init(&m_spi, &spi_config, NULL, NULL);

    return err_code;
}


ret_code_t twi_init() {
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

    return err_code;
}





#ifdef __DEBUG__

void test_bme() {
    twi_init();

    struct bme680_dev bme;

    uint16_t meas_period = 0;

    snow_bme680_init(&bme, &m_twi, 10);
    snow_bme680_configure(&bme, &meas_period);

    struct bme680_field_data data;

    for (;;) {
        snow_bme680_measure(&bme, &data);
        

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


    //spi_init();
    //twi_init();

    // Init both ADXL362
    //
    snow_adxl362_device device = snow_adxl362_create_device(23, NULL);

    snow_adxl362_init(&device, &m_spi, nrf_spi_transfer);
    snow_adxl362_soft_reset(&device, true);
    if (snow_adxl362_configure(&device, true) == SNOW_ADXL362_CONFIGURATION_ERROR) {
        printf("ADXL362 config error (cs_pin=%d)\n", device.cs_pin);
    }

    snow_adxl362_device device2 = snow_adxl362_create_device(38, NULL);

    snow_adxl362_init(&device2, &m_spi, &nrf_spi_transfer);
    snow_adxl362_soft_reset(&device2, true);
    if (snow_adxl362_configure(&device2, true) == SNOW_ADXL362_CONFIGURATION_ERROR) {
        printf("ADXL362 config error (cs_pin=%d)\n", device2.cs_pin);
    }

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
        
        snow_adxl362_self_test_t test = 0;
        //snow_adxl362_perform_self_test(&device, &test, 16);

        snow_bme680_measure(&bme, &data);
        
        printf("BME680   \t=> T: %.2f degC, P: %.2f hPa, H: %.2f %%rH\n\n", data.temperature / 100.0f,
            data.pressure / 100.0f, data.humidity / 1000.0f);
        
        nrf_delay_ms(100);
    }
}

#endif


