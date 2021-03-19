#ifndef BLE_AIR_SERVICE_H
#define BLE_AIR_SERVICE_H

#include "ble.h"
#include "ble_srv_common.h"

#include "bme680_defs.h"

#include "ble_defs.h"



// Service UUID
//
#define BLE_UUID_AIR_BASE_UUID      { 0x23, 0xD1, 0x13, 0xEF, 0x5F, 0x78, 0x23, 0x15, 0xDE, 0xEF, 0x12, 0x13, 0x00, 0x00, 0x00, 0x00 } 
#define BLE_UUID_AIR_SERVICE        0xB000


// Characteristic UUIDs
//
// TODO Note to future self: change the IDs before turning in the thesis
#define BLE_UUID_AIR_CHAR_HUMIDITY        0xAEF0
#define BLE_UUID_AIR_CHAR_TEMPERATURE     0xAFFE
#define BLE_UUID_AIR_CHAR_PRESSURE        0xAEEA


// Structure holding the BLE service information
//
typedef struct ble_air_t {
    uint16_t conn_handle;
    uint16_t service_handle;
    
    ble_gatts_char_handles_t chs_humidity;
    ble_gatts_char_handles_t chs_temperature;
    ble_gatts_char_handles_t chs_pressure;
} ble_air_t;


uint32_t ble_air_service_init(ble_air_t* sh);
void ble_air_service_on_ble_evt(ble_evt_t const * ble_evt, void* context);
void ble_air_service_humidity_update(ble_air_t* sh, struct bme680_field_data* bme_data);
void ble_air_service_temperature_update(ble_air_t* sh, struct bme680_field_data* bme_data);
void ble_air_service_pressure_update(ble_air_t* sh, struct bme680_field_data* bme_data);


#endif