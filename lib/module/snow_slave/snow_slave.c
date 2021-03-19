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

#include "app_timer.h"


#include "snow_slave.h"
#include "ble_module.h"
#include "ble_snow_service.h"


#include <math.h>


// Member variables
//
static const nrf_drv_twi_t m_twi = NRF_DRV_TWI_INSTANCE(TWI_INSTANCE_ID);
static const nrf_drv_spi_t m_spi = NRF_DRV_SPI_INSTANCE(SPI_INSTANCE_ID);

ble_snow_t* ble_snow_sh = NULL;


struct snow_adxl362_device   adxl_dev1;
struct snow_adxl362_device   adxl_dev2;
struct snow_bme680_device    bme_dev;


struct bme680_field_data data;
struct snow_accl_xyz_t accl = {0};
float temp = 0;


#define ACCL_TIMER_INTERVAL       APP_TIMER_TICKS(1000)
#define BME_TIMER_INTERVAL        APP_TIMER_TICKS(1000)
#define GPS_TIMER_INTERVAL        APP_TIMER_TICKS(5000)



APP_TIMER_DEF(m_accl_timer_id);
APP_TIMER_DEF(m_bme_timer_id);
APP_TIMER_DEF(m_gps_timer_id);


static void ble_connected() {
    app_timer_start(m_accl_timer_id, ACCL_TIMER_INTERVAL, NULL);
    app_timer_start(m_bme_timer_id, BME_TIMER_INTERVAL, NULL);
    app_timer_start(m_gps_timer_id, GPS_TIMER_INTERVAL, NULL);
}

static void ble_disconnected() {
    app_timer_stop(m_accl_timer_id);
    app_timer_stop(m_bme_timer_id);
    app_timer_stop(m_gps_timer_id);
}


static void timer_accl_timer_timeout_handler(void* context) {
    snow_adxl362_read_accl(&adxl_dev1, &accl);
    snow_adxl362_read_temp(&adxl_dev1, &temp);
    //printf("ADXL362_1\t=> X: %.2f | Y:%.2f | Z: %.2f | T: %.2f\n", accl.x, accl.y, accl.z, temp);

    //snow_adxl362_read_accl(&device2, &accl);
    //snow_adxl362_read_temp(&device2, &temp);
    //printf("ADXL362_2\t=> X: %.2f | Y:%.2f | Z: %.2f | T: %.2f\n", accl.x, accl.y, accl.z, temp);
}

static void timer_bme_timer_timeout_handler(void* context) {
    snow_bme680_measure(&bme_dev, &data);
    //printf("BME680   \t=> T: %.2f degC, P: %.2f hPa, H: %.2f %%rH\n\n", data.temperature / 100.0f,
    //        data.pressure / 100.0f, data.humidity / 1000.0f);

    ble_snow_service_pressure_update(ble_snow_sh, &data);
    ble_snow_service_temperature_update(ble_snow_sh, &data);
    ble_snow_service_humidity_update(ble_snow_sh, &data);
}

static void timer_gps_timer_timeout_handler(void* context) {
    snow_gps_read_data();
    snow_gps_position_information gps_info;
    snow_gps_get_position(&gps_info);

    ble_snow_service_position_update(ble_snow_sh, &gps_info);
    ble_snow_service_time_update(ble_snow_sh, &gps_info);
    ble_snow_service_date_update(ble_snow_sh, &gps_info);
}



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
    test_ble();
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



void test_gps() {  
    snow_gps_init(SNOW_GPS_I2C_ADDR, &m_twi);
    snow_gps_position_information gps_pos;

    for (;;) {
        /*
        ubx_packet p = {
            .cls = 0x06,
            .id = 0x24,
            .len = 0
        };

        calculate_checksum(&p);
        snow_gps_send_command(&p);
        */

        snow_gps_read_data();
        snow_gps_get_position(&gps_pos);      

        
        printf("Data valid: %s\nLongitude: %f°; Latitude: %f°\nTime: %02d:%02d:%02d\n\n", gps_pos.valid ? "yes" : "no", gps_pos.longitude, gps_pos.latitude, gps_pos.time.hours, gps_pos.time.minutes, gps_pos.time.seconds);

        nrf_delay_ms(1000);
    }
}



void test_ble() {
    uint32_t err_code = snow_ble_init();
    ble_snow_sh = ble_snow_service_get();

    set_on_ble_connected(ble_connected);
    set_on_ble_disconnected(ble_disconnected);

    adxl_dev1 = snow_adxl362_create_device(23, NULL);

    snow_adxl362_init(&adxl_dev1, &m_spi, nrf_spi_transfer);
    snow_adxl362_soft_reset(&adxl_dev1, true);
    if (snow_adxl362_configure(&adxl_dev1, true) == SNOW_ADXL362_CONFIGURATION_ERROR) {
        printf("ADXL362 config error (cs_pin=%d)\n", adxl_dev1.cs_pin);
    }

    snow_adxl362_device adxl_dev2 = snow_adxl362_create_device(38, NULL);

    snow_adxl362_init(&adxl_dev2, &m_spi, &nrf_spi_transfer);
    snow_adxl362_soft_reset(&adxl_dev2, true);
    if (snow_adxl362_configure(&adxl_dev2, true) == SNOW_ADXL362_CONFIGURATION_ERROR) {
        printf("ADXL362 config error (cs_pin=%d)\n", adxl_dev2.cs_pin);
    }

    // Init BME680
    bme_dev;

    uint16_t meas_period = 0;

    snow_bme680_init(&bme_dev, &m_twi, 20);
    snow_bme680_configure(&bme_dev, &meas_period);

    // Init GPS
    snow_gps_init(SNOW_GPS_I2C_ADDR, &m_twi);


    app_timer_create(&m_accl_timer_id, APP_TIMER_MODE_REPEATED, timer_accl_timer_timeout_handler);
    app_timer_create(&m_bme_timer_id, APP_TIMER_MODE_REPEATED, timer_bme_timer_timeout_handler);
    app_timer_create(&m_gps_timer_id, APP_TIMER_MODE_REPEATED, timer_gps_timer_timeout_handler);

    //app_timer_start(m_accl_timer_id, ACCL_TIMER_INTERVAL, NULL);
    //app_timer_start(m_bme_timer_id, BME_TIMER_INTERVAL, NULL);
    //app_timer_start(m_gps_timer_id, GPS_TIMER_INTERVAL, NULL);

    for (;;) {
        
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

    // Init GPS
    snow_gps_init(SNOW_GPS_I2C_ADDR, &m_twi);
    snow_gps_position_information gps_pos;


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
        snow_gps_read_data();
        snow_gps_get_position(&gps_pos);
        
        printf("BME680   \t=> T: %.2f degC, P: %.2f hPa, H: %.2f %%rH\n\n", data.temperature / 100.0f,
            data.pressure / 100.0f, data.humidity / 1000.0f);
        
              
    
        printf("GPS\nData valid: %s\nLongitude: %f°; Latitude: %f°\nTime: %02d:%02d:%02d\n\n", gps_pos.valid ? "yes" : "no", gps_pos.longitude, gps_pos.latitude, gps_pos.time.hours, gps_pos.time.minutes, gps_pos.time.seconds);

        nrf_delay_ms(1000);
    }
}

#endif


