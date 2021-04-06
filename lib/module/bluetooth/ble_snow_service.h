#ifndef BLE_SNOW_SERVICE_H
#define BLE_SNOW_SERVICE_H

#include "ble.h"
#include "ble_srv_common.h"


#include "ble_defs.h"
#include "snow_gps.h"
#include "snow_bme680.h"


// Service UUID
//
#define BLE_UUID_SNOW_BASE_UUID      { 0x23, 0xD1, 0x13, 0xEF, 0x5F, 0x78, 0x23, 0x15, 0xDE, 0xEF, 0x12, 0x15, 0x00, 0x00, 0x00, 0x00 } 
#define BLE_UUID_SNOW_SERVICE        0x0BEE


// Characteristic UUIDs
//
// TODO Note to future self: change the IDs before turning in the thesis
#define BLE_UUID_GPS_CHAR_POSITION        0xBABE;
#define BLE_UUID_GPS_CHAR_TIME            0xF00D;
#define BLE_UUID_GPS_CHAR_DATE            0xFACE;
#define BLE_UUID_AIR_CHAR_HUMIDITY        0xD00D;
#define BLE_UUID_AIR_CHAR_TEMPERATURE     0xAFFE;
#define BLE_UUID_AIR_CHAR_PRESSURE        0x0F0E;


// Structure holding the BLE service information
//
typedef struct ble_snow_t {
    uint16_t conn_handle;
    uint16_t service_handle;
    
    ble_gatts_char_handles_t chs_position;
    ble_gatts_char_handles_t chs_time;
    ble_gatts_char_handles_t chs_date;
    ble_gatts_char_handles_t chs_humidity;
    ble_gatts_char_handles_t chs_temperature;
    ble_gatts_char_handles_t chs_pressure;
} ble_snow_t;


uint32_t ble_snow_service_init(ble_snow_t* sh);
void ble_snow_service_on_ble_evt(ble_evt_t const * ble_evt, void* context);
void ble_snow_service_position_update(ble_snow_t* sh, struct snow_gps_position_information* gps_info);
void ble_snow_service_time_update(ble_snow_t* sh, struct snow_gps_position_information* gps_info);
void ble_snow_service_date_update(ble_snow_t* sh, struct snow_gps_position_information* gps_info);
void ble_snow_service_humidity_update(ble_snow_t* sh, struct bme680_field_data* bme_data);
void ble_snow_service_temperature_update(ble_snow_t* sh, struct bme680_field_data* bme_data);
void ble_snow_service_pressure_update(ble_snow_t* sh, struct bme680_field_data* bme_data);

#endif