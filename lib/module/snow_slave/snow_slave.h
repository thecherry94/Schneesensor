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

#include "lib/sensor/snow_adxl362/snow_adxl362.h"
#include "lib/sensor/snow_bme680/snow_bme680.h"
#include "lib/sensor/snow_gps/snow_gps.h"


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





// Structs
//

// Struct for holding measurement values
typedef struct snow_slave_measurement_t {
    uint8_t measurements;
    struct snow_accl_xyz_t acceleration;
    struct bme680_field_data bme_data;
    // Add field for GPS data
    // Add field for snow moisture
} snow_slave_measurement_t;


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




// General init functions
//

// Init I²C
ret_code_t twi_init();

// Init SPI
ret_code_t spi_init();


// Test functions
//
#ifdef __DEBUG__
void test_bme();
void test_adxl362();
void test_gps();
void test_everything();
#endif 

// SPI transfer function for the adxl362
snow_adxl362_ret_code_t nrf_spi_transfer(uint8_t* tx_buf, uint8_t tx_len, uint8_t* rx_buf, uint8_t rx_len, uint8_t cs_pin);




// 
// Bluetooth functions
//



#endif