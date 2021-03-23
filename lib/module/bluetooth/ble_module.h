#ifndef BLE_MODULE_H
#define BLE_MODULE_H

#include "nordic_common.h"
#include "nrf.h"
#include "app_error.h"
#include "ble.h"
#include "ble_hci.h"
#include "ble_srv_common.h"
#include "ble_advdata.h"
#include "ble_advertising.h"
#include "ble_conn_params.h"
#include "nrf_sdh.h"
#include "nrf_sdh_soc.h"
#include "nrf_sdh_ble.h"
#include "app_timer.h"

#include "ble_snow_service.h"



#define DEVICE_NAME                       "Schneesensor"                          // Device name visible to other bluetooth devices
#define MANUFACTURER_NAME                 "HsKa"                                  // Manufacturer name visible to other bluetooth devices
#define APP_ADV_INTERVAL                  300                                     // Advertising interval in units of 0.625 ms (100 = 62.5ms)

#define APP_ADV_DURATION                  18000                                   // Advertising duration in units of 10 ms 
#define APP_BLE_OBSERVER_PRIO             3                         
#define APP_BLE_CONN_CFG_TAG              1                                       // SoftDevice BLE config identifier

#define MIN_CONN_INTERVAL                 MSEC_TO_UNITS(10, UNIT_1_25_MS)        // Minimum acceptable connection interval (100ms)
#define MAX_CONN_INTERVAL                 MSEC_TO_UNITS(400, UNIT_1_25_MS)        // Maximum acceptable connection interval (100ms)
#define SLAVE_LATENCY                     0                                       
#define CONN_SUP_TIMEOUT                  MSEC_TO_UNITS(4000, UNIT_10_MS)         // Connection supervisory timeout (4 seconds)

#define FIRST_CONN_PARAMS_UPDATE_DELAY    APP_TIMER_TICKS(5000)                   // Time from initiating event (connect or start of notification) to first time sd_ble_gap_conn_param_update is called (5 seconds). */
#define NEXT_CONN_PARAMS_UPDATE_DELAY     APP_TIMER_TICKS(30000)                  // Time between each call to sd_ble_gap_conn_param_update after the first call (30 seconds). */
#define MAX_CONN_PARAMS_UPDATE_COUNT      3                                       // Number of attempts before giving up the connection parameter negotiation. */

#define SEC_PARAM_BOND                    1                                       // Perform bonding
#define SEC_PARAM_MITM                    0                                       // Man In The Middle protection not required
#define SEC_PARAM_LESC                    0                                       // LE Secure Connections not enabled
#define SEC_PARAM_KEYPRESS                0                                       // Keypress notifications not enabled
#define SEC_PARAM_IO_CAPABILITIES         BLE_GAP_IO_CAPS_NONE                    // No I/O capabilities
#define SEC_PARAM_OOB                     0                                       // Out Of Band data not available
#define SEC_PARAM_MIN_KEY_SIZE            7                                       // Minimum encryption key size
#define SEC_PARAM_MAX_KEY_SIZE            16                                      // Maximum encryption key size

#define DEAD_BEEF                         0xDEADBEEF                              // Value used as error code on stack dump, can be used to identify stack location on stack unwind


typedef void (*ble_callback_t)(void);


uint32_t snow_ble_init();
uint32_t snow_ble_data_send(uint8_t* data, uint16_t len);




#endif