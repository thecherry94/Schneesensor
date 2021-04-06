#ifndef BLE_CONTINUOUS_SERVICE_H
#define BLE_CONTINUOUS_SERVICE_H


#include "ble.h"
#include "ble_srv_common.h"


#include "ble_defs.h"
#include "lib/module/snow_slave/snow_slave.h"


// Service UUID
//
#define BLE_UUID_CONT_BASE_UUID      { 0x23, 0xD1, 0x13, 0xEF, 0x5F, 0x78, 0x23, 0x15, 0xDE, 0xEF, 0x12, 0x10, 0x00, 0x00, 0x00, 0x00 } 
#define BLE_UUID_CONT_SERVICE        0xCE00

#define BLE_UUID_CONT_CHAR_BULK     0xF00D


// Structure holding the BLE service information
//
typedef struct ble_continuous_t {
    uint16_t conn_handle;
    uint16_t service_handle;
    
    ble_gatts_char_handles_t chs_bulk_data;
} ble_continuous_t_t;


uint32_t ble_continuous_service_init(ble_continuous_t* sh);
void ble_continuous_service_on_ble_evt(ble_evt_t* const* ble_evt, void* context);
void ble_continuous_measurement_update(ble_continuous_t* sh, snow_slave_measurement_t* meas_info);


#endif