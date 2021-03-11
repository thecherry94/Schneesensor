#ifndef BLE_GPS_SERVICE_H
#define BLE_GPS_SERVICE_H

#include "ble.h"
#include "ble_srv_common.h"

#include "ble_defs.h"
#include "lib/sensor/snow_gps/snow_gps.h"


// Service UUID
#define BLE_UUID_GPS_SERVICE        0xB00B


// Characteristic UUIDs
//
#define BLE_UUID_GPS_POSITION       0xBABE;
#define BLE_UUID_GPS_TIME           0xF00D;


typedef struct ble_gps_t {
    uint16_t conn_handle;
    uint16_t service_handle;
    
    ble_gatts_char_handles_t chs_position;
    ble_gatts_char_handles_t chs_time;
} ble_gps_t;


void ble_gps_service_init(ble_gps_t* sh);

void ble_gps_service_on_ble_evt(ble_evt_t* const * ble_evt, void* context);

void ble_gps_service_position_update(ble_gps_t* sh, snow_gps_position_information* gps_info);

#endif