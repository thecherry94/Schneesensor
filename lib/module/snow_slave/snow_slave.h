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




// Bluetooth
//
#define DEVICE_NAME                       "Schneesensor"                          // Device name visible to other bluetooth devices
#define MANUFACTURER_NAME                 "NordicSemiconductor"                   // Manufacturer name visible to other bluetooth devices
#define APP_ADV_INTERVAL                  300                                     // Advertising interval in units of 0.625 ms (100 = 62.5ms)

#define APP_ADV_DURATION                  18000                                   // Advertising duration in units of 10 ms 
#define APP_BLE_OBSERVER_PRIO             3                         
#define APP_BLE_CONN_CFG_TAG              1                                       // SoftDevice BLE config identifier

#define MIN_CONN_INTERVAL                 MSEC_TO_UNITS(100, UNIT_1_25_MS)        // Minimum acceptable connection interval (100ms)
#define MAX_CONN_INTERVAL                 MSEC_TO_UNITS(200, UNIT_1_25_MS)        // Maximum acceptable connection interval (100ms)
#define SLAVE_LATENCY                     0                                       
#define CONN_SUP_TIMEOUT                  MSEC_TO_UNITS(4000, UNIT_10_MS)         // Connection supervisory timeout (4 seconds)

#define FIRST_CONN_PARAMS_UPDATE_DELAY    APP_TIMER_TICKS(5000)                   // Time from initiating event (connect or start of notification) to first time sd_ble_gap_conn_param_update is called (5 seconds). */
#define NEXT_CONN_PARAMS_UPDATE_DELAY     APP_TIMER_TICKS(30000)                  // Time between each call to sd_ble_gap_conn_param_update after the first call (30 seconds). */
#define MAX_CONN_PARAMS_UPDATE_COUNT      3                                       // Number of attempts before giving up the connection parameter negotiation. */

//#define SEC_PARAM_BOND                  1                                       // Perform bonding
#define SEC_PARAM_MITM                    0                                       // Man In The Middle protection not required
#define SEC_PARAM_LESC                    0                                       // LE Secure Connections not enabled
#define SEC_PARAM_KEYPRESS                0                                       // Keypress notifications not enabled
#define SEC_PARAM_IO_CAPABILITIES         BLE_GAP_IO_CAPS_NONE                    // No I/O capabilities
#define SEC_PARAM_OOB                     0                                       // Out Of Band data not available
#define SEC_PARAM_MIN_KEY_SIZE            7                                       // Minimum encryption key size
#define SEC_PARAM_MAX_KEY_SIZE            16                                      // Maximum encryption key size

#define DEAD_BEEF                         0xDEADBEEF                              // Value used as error code on stack dump, can be used to identify stack location on stack unwind



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