#include "ble_gps_service.h"


void ble_gps_service_on_ble_evt(ble_evt_t* const * ble_evt, void* context) {
    ble_gps_t* sh = (ble_gps_t*)context;

    switch (ble_evt->header.evt_id) {
        case BLE_GAP_EVT_CONNECTED: {
            sh->conn_handle = ble_evt->evt.gap_evt.conn_handle;
        } break;
        case BLE_GAP_EVT_DISCONNECTED: {
            sh->conn_handle = BLE_CONN_HANDLE_INVALID;
        } break;
    } 
}




void ble_gps_service_init(ble_gps_t* sh) {

}



void ble_gps_service_position_update(ble_gps_t* sh, snow_gps_position_information* gps_info) {

}