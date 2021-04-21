/*
TODO: 
- Implement watchdog

 */ 

#include "ble.h"
#include "ble_hci.h"
#include "ble_srv_common.h"
#include "ble_advdata.h"
#include "ble_advertising.h"
#include "ble_conn_params.h"

#include "ble_module.h"
#include "snow_adxl362.h"
#include "snow_bme680.h"
#include "snow_gps.h"
#include "minmea.h"


#ifndef SNOW_SLAVE_H
#define SNOW_SLAVE_H

// Defines
//
#define __DEBUG__

#define TWI_INSTANCE_ID 0
#define SPI_INSTANCE_ID 1


// Codes
#define SNOW_OK 0
#define SNOW_FAILED 1

// Bit flags for snow_slave_measure
#define SNOW_MEASURE_TEMPERATURE          0x01
#define SNOW_MEASURE_AIR_HUMIDITY         0x02
#define SNOW_MEASURE_AIR_PRESSURE         0x04
#define SNOW_MEASURE_ACCELERATION         0x08
#define SNOW_MEASURE_GPS                  0x10
#define SNOW_MEASURE_SNOW_MOISTURE        0x20


// Bit flags for component checking
#define SNOW_ADXL362_1                    0x01
#define SNOW_ADXL362_2                    0x02
#define SNOW_BME680_1                     0x04


#define SNOW_SLAVE_VERSION                0x01
#define SNOW_SLAVE_REVISION               0x01



#define SNOW_SLAVE_BLE_BUFFER_SIZE        128

#define FDS_KEY_OFFSET                    0x0010
#define FDS_ID_MEASUREMENT                0x0020


// Structs
//

// Struct for holding measurement series information
typedef struct snow_slave_measurement_series_info_t {
    struct minmea_date date_created;
    struct minmea_time time_created;
    struct minmea_date date_modified;
    struct minmea_time time_modified;
    uint8_t name[32];
    uint8_t num_measurements;
} snow_slave_measurement_series_info_t;


// Struct for holding measurement values
typedef struct snow_slave_measurement_t {
    struct bme680_field_data bme_data;
    struct snow_gps_position_information gps_data;
    uint16_t snow_moisture;
    uint16_t snow_hardness;
} snow_slave_measurement_t;


// Struct to hold all information related to a measurement series
typedef struct snow_slave_measurement_series_t {
    uint16_t meas_id;
    struct snow_slave_measurement_series_info_t info;
    struct snow_slave_measurement_t* measurements[150];
} snow_slave_measurement_series_t;


typedef struct bme_data_buffer {
    int64_t   temperature;
    uint64_t  pressure;
    uint64_t  humidity;
} bme_data_buffer;

// Enums
//

// Enum for main program flow control
typedef enum snow_slave_main_state_t {
    SNOW_SLAVE_MAIN_IDLE,
    SNOW_SLAVE_MAIN_CONTINUOUS,
    SNOW_SLAVE_MAIN_SINGLE
} snow_slave_state_t;


// Enum for single measurement flow control
typedef enum snow_slave_singlemeas_state_t {
    SNOW_SLAVE_SINGLEMEAS_IDLE,
    SNOW_SLAVE_SINGLEMEAS_ACCL,
    SNOW_SLAVE_SINGLEMEAS_MEAS,
    SNOW_SLAVE_SINGLE_MEAS_DONE
} snow_slave_singlemeas_state_t;

// Enum for continuous measurement flow control
typedef enum snow_slave_contmeas_state_t {
    SNOW_SLAVE_CONTMEAS_IDLE,
    SNOW_SLAVE_CONTMEAS_BUFFER,
    SNOW_SLAVE_CONTMEAS_SEND
} snow_slave_contmeas_state_t;



//
// Functions
//

// Main functions
//

// Initialize entire system
uint8_t snow_slave_init();

// Run system
uint8_t snow_slave_run();

// Conduct a measurement
uint8_t snow_slave_measure(uint8_t meas_params, uint8_t num_samples);

// Check if component(s) are OK
uint8_t snow_slave_check_components(uint8_t components);

// Restart component(s)
uint8_t snow_slave_reset_components(uint8_t components);


void snow_slave_toggle_continuous_measurement(uint16_t interval);
void snow_slave_single_measurement(uint16_t meas_interval, uint8_t meas_amount);
void snow_slave_ble_send_device_info();
void snow_slave_ble_send_error(uint8_t cmd, uint8_t err_code, uint8_t* err_desc, uint8_t err_desc_len);



// File system management
//
ret_code_t snow_slave_fds_save_measurement_series(snow_slave_measurement_series_t* mss);
ret_code_t snow_slave_fds_load_measurement_series_by_meas_id(uint16_t meas_id, snow_slave_measurement_series_t* mss);
ret_code_t snow_slave_fds_load_measurement_series_by_name(uint8_t* name, uint8_t len, snow_slave_measurement_series_t* mss);
uint16_t snow_slave_fds_get_first_free_key(uint16_t file_id);




// General init functions
//

// Init I²C
ret_code_t twi_init();

// Init SPI
ret_code_t spi_init();

ret_code_t sensors_init();


// Test functions
//
#ifdef __DEBUG__
void test_bme();
void test_adxl362();
void test_gps();
void test_ble();
void test_everything();
#endif 

// SPI transfer function for the adxl362
snow_adxl362_ret_code_t nrf_spi_transfer(uint8_t* tx_buf, uint8_t tx_len, uint8_t* rx_buf, uint8_t rx_len, uint8_t cs_pin);




// 
// Bluetooth functions
//

void snow_slave_ble_on_connected();
void snow_slave_ble_on_disconnected();
void snow_slave_ble_on_tx_done();
void snow_slave_ble_on_tx_start();



#endif