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

#include "ble_nus.h"


#include "snow_slave.h"
#include "ble_module.h"
#include "ble_snow_service.h"

#include <math.h>


// Member variables
//
static const nrf_drv_twi_t m_twi = NRF_DRV_TWI_INSTANCE(TWI_INSTANCE_ID);
static const nrf_drv_spi_t m_spi = NRF_DRV_SPI_INSTANCE(SPI_INSTANCE_ID);

ble_snow_t* ble_snow_sh = NULL;


#define GPS_TIMER_INTERVAL    APP_TIMER_TICKS(10000)
#define BME_TIMER_INTERVAL    APP_TIMER_TICKS(150)
#define ACCL_TIMER_INTERVAL   APP_TIMER_TICKS(150)
#define CONT_TIMER_INTERVAL   APP_TIMER_TICKS(1000)


struct snow_adxl362_device   m_adxl_dev1;
struct snow_adxl362_device   m_adxl_dev2;
struct snow_bme680_device    m_bme_dev;

struct bme680_field_data              m_bme_data = {0};
struct snow_gps_position_information  m_gps_pos = {0};
struct snow_accl_xyz_raw_t            m_accl = {0};



APP_TIMER_DEF(m_gps_timer_id);
APP_TIMER_DEF(m_bme_timer_id);
APP_TIMER_DEF(m_accl_timer_id);
APP_TIMER_DEF(m_cont_timer_id);


uint16_t m_meas_period = 0;

volatile bool m_tx_ready = false;
volatile bool m_ble_connected = false;


volatile bool m_measure_bme = false;
volatile bool m_get_position = false;
volatile bool m_measure_accl = false;
volatile bool m_measure_hardness = false;
volatile bool m_measure_moisture = false;
volatile bool m_measure_temperature = false;


volatile bool m_ble_send_flag = false;
volatile uint8_t m_ble_tx_buf[SNOW_SLAVE_BLE_BUFFER_SIZE];

volatile uint8_t m_new_measurements = 0; // 1 = accl, 2 = bme, 4 = gps, 8 = moisture

uint16_t m_single_meas_interval = 200;
uint8_t m_single_meas_amount = 10;
uint8_t m_single_meas_done = 0;


volatile enum snow_slave_main_state_t m_main_state = SNOW_SLAVE_MAIN_IDLE;
volatile enum snow_slave_singlemeas_state_t m_singlemeas_state = SNOW_SLAVE_SINGLEMEAS_IDLE;
volatile enum snow_slave_contmeas_state_t m_contmeas_state = SNOW_SLAVE_CONTMEAS_IDLE;

static bool ble_send_ready() {
    return m_tx_ready && m_ble_connected;
}

static void timer_accl_timer_timeout_handler(void* context) {
    

    //snow_adxl362_read_accl(&device2, &accl);
    //snow_adxl362_read_temp(&device2, &temp);
    //printf("ADXL362_2\t=> X: %.2f | Y:%.2f | Z: %.2f | T: %.2f\n", accl.x, accl.y, accl.z, temp);

    m_measure_accl = true;
}

static void timer_bme_timer_timeout_handler(void* context) {
    //snow_bme680_measure(&m_bme_dev, &m_bme_data);
    //printf("BME680   \t=> T: %.2f degC, P: %.2f hPa, H: %.2f %%rH\n\n", m_bme_data.temperature / 100.0f,
    //       m_bme_data.pressure / 100.0f, m_bme_data.humidity / 1000.0f);

    m_measure_bme = true;
}


static void timer_gps_timer_timeout_handler(void* context) {
    //snow_gps_read_data();
    //snow_gps_get_position(&m_gps_pos);
    //printf("Data valid: %s\nLongitude: %f°; Latitude: %f°\nTime: %02d:%02d:%02d\n\n", m_gps_pos.valid ? "yes" : "no", m_gps_pos.longitude, m_gps_pos.latitude, m_gps_pos.time.hours, m_gps_pos.time.minutes, m_gps_pos.time.seconds);
    m_get_position = true;
}


static void timer_cont_timer_timeout_handler(void* context) {
    
    if (m_contmeas_state != SNOW_SLAVE_CONTMEAS_SEND)
        m_contmeas_state = SNOW_SLAVE_CONTMEAS_BUFFER;
}


static void timer_single_measurement_timer_timeout_handler(void* context) {
    
}

void snow_slave_single_measurement(uint16_t meas_interval, uint8_t meas_amount) {
    if (m_main_state == SNOW_SLAVE_MAIN_CONTINUOUS) {
        const uint8_t err_msg[] = "Action blocked. Continuous measurement already running.";
        snow_slave_ble_send_error('m', SNOW_BLE_ERROR_ACTION_BLOCKED, err_msg, strlen(err_msg));
        return;
    }

    if (m_main_state == SNOW_SLAVE_MAIN_SINGLE) {
        const uint8_t err_msg[] = "Action blocked. Measurement already started.";
        snow_slave_ble_send_error('m', SNOW_BLE_ERROR_ACTION_BLOCKED, err_msg, strlen(err_msg));
        return;
    }
    
    m_main_state = SNOW_SLAVE_MAIN_SINGLE;
    m_singlemeas_state = SNOW_SLAVE_SINGLEMEAS_ACCL;

    m_single_meas_interval = meas_interval;
    m_single_meas_amount = meas_amount;

    app_timer_start(m_accl_timer_id, m_single_meas_interval, NULL);
}

void snow_slave_ble_send_device_info() {
    uint8_t buf[3];
    buf[0] = 'i';
    buf[1] = SNOW_SLAVE_VERSION;
    buf[2] = SNOW_SLAVE_REVISION;

    snow_ble_data_send(buf, 3);
}

void snow_slave_ble_send_error(uint8_t cmd, uint8_t err_code, uint8_t* err_desc, uint8_t err_desc_len) {
    uint8_t* buf = (uint8_t*)malloc(4 + err_desc_len);

    buf[0] = cmd;
    buf[1] = err_code;

    uint8_t offset = 0;
    if (err_desc != NULL && err_desc_len != 0) {
        memcpy(buf+2, err_desc, err_desc_len);
        offset = 1;
    }
    
    buf[err_desc_len + 2 + offset] = '\r';
    buf[err_desc_len + 3 + offset] = '\n';

    snow_ble_data_send(buf, 4 + err_desc_len);
}


// Exectued whenever a device connects
void snow_slave_ble_on_connected() {
    m_tx_ready = true;
    m_ble_connected = true;
}


// Executed whenever a device disconnects 
void snow_slave_ble_on_disconnected() {
    m_tx_ready = false;
    m_ble_connected = false;
}


// Executed whenever a transmission is finished
void snow_slave_ble_on_tx_done() {
    m_tx_ready = true;
}

// Executed whenever a transmission is about to start
void snow_slave_ble_on_tx_start() {
    m_tx_ready = false;
}


void snow_slave_toggle_continuous_measurement() {
    if (m_main_state == SNOW_SLAVE_MAIN_SINGLE) {
        const uint8_t err_msg[] = "Action blocked. Measurement already started.";
        snow_slave_ble_send_error('c', SNOW_BLE_ERROR_ACTION_BLOCKED, err_msg, strlen(err_msg));
        return;
    }

    m_main_state = m_main_state == SNOW_SLAVE_MAIN_CONTINUOUS ? SNOW_SLAVE_MAIN_IDLE : SNOW_SLAVE_MAIN_CONTINUOUS;

    if (m_main_state == SNOW_SLAVE_MAIN_CONTINUOUS) {
        app_timer_start(m_gps_timer_id, GPS_TIMER_INTERVAL, NULL);
        app_timer_start(m_bme_timer_id, BME_TIMER_INTERVAL, NULL);
        app_timer_start(m_accl_timer_id, ACCL_TIMER_INTERVAL, NULL);
        app_timer_start(m_cont_timer_id, CONT_TIMER_INTERVAL, NULL);
    } else {
        app_timer_stop(m_gps_timer_id);
        app_timer_stop(m_bme_timer_id);
        app_timer_stop(m_accl_timer_id);
        app_timer_stop(m_cont_timer_id);
    }
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

    sensors_init();

    return err_code;
}

uint8_t snow_slave_run() {
    #ifdef __DEBUG__
    test_ble();
    //test_adxl362();
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



ret_code_t sensors_init() {
    snow_bme680_init(&m_bme_dev, &m_twi, 28);
    snow_bme680_configure(&m_bme_dev, &m_meas_period);

    //m_adxl_dev1 = snow_adxl362_create_device(38, NULL);
    //snow_adxl362_init(&m_adxl_dev1, &m_spi, nrf_spi_transfer);
    //snow_adxl362_soft_reset(&m_adxl_dev1, true);
    //snow_adxl362_configure(&m_adxl_dev1, true);

    m_adxl_dev1 = snow_adxl362_create_device(38, NULL); // 23
    snow_adxl362_init(&m_adxl_dev1, &m_spi, nrf_spi_transfer);
    snow_adxl362_soft_reset(&m_adxl_dev1, true);
    snow_adxl362_configure(&m_adxl_dev1, true);

    snow_gps_init(SNOW_GPS_I2C_ADDR, &m_twi);
}



void test_ble() {
    ret_code_t err_code = app_timer_init();
    err_code = snow_ble_init();  

    app_timer_create(&m_accl_timer_id, APP_TIMER_MODE_REPEATED, timer_accl_timer_timeout_handler);
    app_timer_create(&m_bme_timer_id, APP_TIMER_MODE_REPEATED, timer_bme_timer_timeout_handler);
    app_timer_create(&m_gps_timer_id, APP_TIMER_MODE_REPEATED, timer_gps_timer_timeout_handler);
    app_timer_create(&m_cont_timer_id, APP_TIMER_MODE_REPEATED, timer_cont_timer_timeout_handler);
    
    snow_gps_read_data();

    // Main program loop
    for (;;) {

        // Taking measurements of the sensors is done independently from the main state machine
        //

        // Measure acceleration
        if (m_measure_accl) {
            snow_adxl362_read_accl_raw(&m_adxl_dev1, &m_accl);

            snow_accl_xyz_t accl;
            snow_adxl362_raw_to_accl(&m_adxl_dev1, &m_accl, &accl);
            //snow_adxl362_read_temp(&m_adxl_dev1, &temp);
            printf("ADXL362_1\t=> X: %.2f | Y:%.2f | Z: %.2f\n", accl.x, accl.y, accl.z);

            m_measure_accl = false;
            m_new_measurements |= 1;
        }

        // Measure BME device. air (pressure, temperature, humidity)
        if (m_measure_bme) {
            snow_bme680_measure(&m_bme_dev, &m_bme_data);
            printf("BME680   \t=> T: %.2f degC, P: %.2f hPa, H: %.2f %%rH\n\n", m_bme_data.temperature / 100.0f,
                m_bme_data.pressure / 100.0f, m_bme_data.humidity / 1000.0f);

            m_measure_bme = false;
            m_new_measurements |= 2;
        }

        // Get current gps position
        if (m_get_position) {
            snow_gps_read_data();
            snow_gps_get_position(&m_gps_pos);
            printf("Data valid: %s\nLongitude: %f°; Latitude: %f°\nTime: %02d:%02d:%02d\n\n", m_gps_pos.valid ? "yes" : "no", m_gps_pos.longitude, m_gps_pos.latitude, m_gps_pos.time.hours, m_gps_pos.time.minutes, m_gps_pos.time.seconds);
    
            m_get_position = false;
            m_new_measurements |= 4;
        }

        // Measure the snow temperature
        if (m_measure_temperature) {
            // Not implemented yet

            m_measure_temperature = false;
        }

        // Measure snow hardness
        if (m_measure_hardness) {
            // Not implemented yet

            m_measure_hardness = false;
        }
        
        // Measure snow moisture
        if (m_measure_moisture) {
            // Not implemented yet

            m_measure_moisture = false;
        }


        //
        // Main program state machine
        //
        switch (m_main_state) {
            case SNOW_SLAVE_MAIN_IDLE: {

            } break;

            // Single measurement procedure
            //
            case SNOW_SLAVE_MAIN_SINGLE: {
                // Sub states for single measurement procedure
                switch (m_singlemeas_state) {
                    // First measure the acceleration over a peroid of time and calculate the average.
                    // If the acceleration is within a set margin the device didn't move and we have found our measurement location
                    // TODO save gps coordinate
                    //
                    case SNOW_SLAVE_SINGLEMEAS_ACCL:  {
                        if (m_new_measurements & 1) {
                            struct snow_accl_xyz_t accl_buf;      // Struct to hold the acceleration value in g
                            static struct snow_accl_xyz_t avg;    // Struct to hold the average acceleration value in g
                            snow_adxl362_raw_to_accl(&m_adxl_dev1, &m_accl, &accl_buf);
                            m_new_measurements &= ~1;

                            avg.x += accl_buf.x; 
                            avg.y += accl_buf.y; 
                            avg.z += accl_buf.z; 

                            m_single_meas_done++;
                          
                            if (m_single_meas_done == m_single_meas_amount) {
                                // Maxmimum amount of measurement samples reached
                                // Calculate average here
                                //

                                avg.x /= (float)m_single_meas_done;
                                avg.y /= (float)m_single_meas_done;
                                avg.z /= (float)m_single_meas_done;

                                m_single_meas_done = 0;
                                float abs_accl = snow_adxl362_get_absolute_acceleration(&avg);                               
                                if (abs_accl >= 0.8f && abs_accl <= 1.2f) {
                                    // Acceleration within margin i.e. device didn't move
                                    // Switch to measurement state now
                                    // TODO save GPS coordinate
                                    m_singlemeas_state = SNOW_SLAVE_SINGLEMEAS_MEAS;
                                    app_timer_stop(m_accl_timer_id);
                                    app_timer_start(m_bme_timer_id, m_meas_period, NULL);
                                }
                                
                                // Reset static struct for averaging
                                avg.x = 0;
                                avg.y = 0;
                                avg.z = 0;
                            }
                        }
                    } break; 
                
                    case SNOW_SLAVE_SINGLEMEAS_MEAS:  {
                        
                    } break;
                }
            } break;

            // Continuous measurement procedure
            //
            case SNOW_SLAVE_MAIN_CONTINUOUS: {
                switch (m_contmeas_state) {  
                    case SNOW_SLAVE_CONTMEAS_BUFFER: {
                        // Buffer current measurements
                        //
                        memset(m_ble_tx_buf, 0, SNOW_SLAVE_BLE_BUFFER_SIZE);

                        m_ble_tx_buf[0] = 'c';

                        m_ble_tx_buf[1] = (uint8_t)(m_bme_data.temperature);
                        m_ble_tx_buf[2] = (uint8_t)((m_bme_data.temperature >> 8));

                        m_ble_tx_buf[3] = (uint8_t)(m_bme_data.pressure);
                        m_ble_tx_buf[4] = (uint8_t)((m_bme_data.pressure >> 8));
                        m_ble_tx_buf[5] = (uint8_t)((m_bme_data.pressure >> 16));
                        m_ble_tx_buf[6] = (uint8_t)((m_bme_data.pressure >> 24));

                        m_ble_tx_buf[7] = (uint8_t)(m_bme_data.humidity);
                        m_ble_tx_buf[8] = (uint8_t)((m_bme_data.humidity >> 8));
                        m_ble_tx_buf[9] = (uint8_t)((m_bme_data.humidity >> 16));
                        m_ble_tx_buf[10] = (uint8_t)((m_bme_data.humidity >> 24) );



                        m_ble_tx_buf[11] = (uint8_t)(m_accl.x);
                        m_ble_tx_buf[12] = (uint8_t)((m_accl.x >> 8));

                        m_ble_tx_buf[13] = (uint8_t)(m_accl.y);
                        m_ble_tx_buf[14] = (uint8_t)((m_accl.y >> 8));

                        m_ble_tx_buf[15] = (uint8_t)(m_accl.z);
                        m_ble_tx_buf[16] = (uint8_t)((m_accl.z >> 8));

                        m_ble_tx_buf[17] = '\r';
                        m_ble_tx_buf[18] = '\n';

                        m_contmeas_state = SNOW_SLAVE_CONTMEAS_SEND;
                    } break;

                    case SNOW_SLAVE_CONTMEAS_SEND: {
                        // Send the data to device
                        if (ble_send_ready()) {                                                      
                            err_code = snow_ble_data_send(m_ble_tx_buf, 19);                                             
                        }

                        if (err_code == NRF_SUCCESS)
                            // Go idle until next buffer state is set
                            m_contmeas_state = SNOW_SLAVE_CONTMEAS_IDLE;
                    } break;
                }
            } break;
        }
    }
}


#ifdef __DEBUG__


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


void test_bme() {
    //twi_init();

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


#endif


