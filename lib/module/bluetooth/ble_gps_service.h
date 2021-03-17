#ifndef BLE_GPS_SERVICE_H
#define BLE_GPS_SERVICE_H

#include "ble.h"
#include "ble_srv_common.h"


#include "ble_defs.h"
#include "lib/sensor/snow_gps/snow_gps.h"


// Service UUID
//
#define BLE_UUID_GPS_BASE_UUID      { 0x23, 0xD1, 0x13, 0xEF, 0x5F, 0x78, 0x23, 0x15, 0xDE, 0xEF, 0x12, 0x12, 0x00, 0x00, 0x00, 0x00 } 
#define BLE_UUID_GPS_SERVICE        0xB00B


// Characteristic UUIDs
//
// TODO Note to future self: change the IDs before turning in the thesis
#define BLE_UUID_GPS_CHAR_POSITION        0xBABE;
#define BLE_UUID_GPS_CHAR_TIME            0xF00D;
#define BLE_UUID_GPS_CHAR_DATE            0xFACE;


// Structure holding the BLE service information
//
typedef struct ble_gps_t {
    uint16_t conn_handle;
    uint16_t service_handle;
    
    ble_gatts_char_handles_t chs_position;
    ble_gatts_char_handles_t chs_time;
    ble_gatts_char_handles_t chs_date;
} ble_gps_t;


uint32_t ble_gps_service_init(ble_gps_t* sh);
void ble_gps_service_on_ble_evt(ble_evt_t const * ble_evt, void* context);
void ble_gps_service_position_update(ble_gps_t* sh, struct snow_gps_position_information* gps_info);
void ble_gps_service_time_update(ble_gps_t* sh, struct snow_gps_position_information* gps_info);
void ble_gps_service_date_update(ble_gps_t* sh, struct snow_gps_position_information* gps_info);

#endif