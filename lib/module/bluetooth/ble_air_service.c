#include "ble_air_service.h"


#define AIR_CHAR_HUMIDITY_DATA_LEN        4
#define AIR_CHAR_TEMPERATURE_DATA_LEN     2
#define AIR_CHAR_PRESSURE_DATA_LEN        4


void ble_air_service_on_ble_evt(ble_evt_t const * ble_evt, void* context) {
    ble_air_t* sh = (ble_air_t*)context;

    switch (ble_evt->header.evt_id) {
        case BLE_GAP_EVT_CONNECTED: {
            sh->conn_handle = ble_evt->evt.gap_evt.conn_handle;
        } break;
        case BLE_GAP_EVT_DISCONNECTED: {
            sh->conn_handle = BLE_CONN_HANDLE_INVALID;
        } break;
    } 
}


//
// Helper function to add the humidity characteristic to the BLE AIR service
//
static uint32_t add_humidity_characteristic(ble_air_t* sh) {
    uint32_t err_code;

    // Add characteristic UUID
    //
    ble_uuid_t char_uuid;
    ble_uuid128_t base_uuid = BLE_UUID_AIR_BASE_UUID;
    char_uuid.uuid = BLE_UUID_AIR_CHAR_HUMIDITY;
    err_code = sd_ble_uuid_vs_add(&base_uuid, &char_uuid.type);



    // Specifiy characteristic general metadata for read/write access
    //
    ble_gatts_char_md_t char_md;
    memset(&char_md, 0, sizeof(char_md));
    char_md.char_props.read = 1;
    char_md.char_props.write = 0;
    

    // Specifiy characteristic CCCD metadata for read/write access
    //
    ble_gatts_attr_md_t cccd_md;
    memset(&cccd_md, 0, sizeof(cccd_md));
    cccd_md.vloc = BLE_GATTS_VLOC_STACK;
    char_md.p_cccd_md = &cccd_md;
    char_md.char_props.notify = 1;


    BLE_GAP_CONN_SEC_MODE_SET_OPEN(&cccd_md.read_perm);
    BLE_GAP_CONN_SEC_MODE_SET_OPEN(&cccd_md.write_perm);

    // Specifiy the value options of the characteristic
    //
    ble_gatts_attr_t attr_char_val;
    memset(&attr_char_val, 0, sizeof(attr_char_val));
    attr_char_val.p_uuid = &char_uuid;
    attr_char_val.p_attr_md = &char_md;
    attr_char_val.max_len = AIR_CHAR_HUMIDITY_DATA_LEN;                 // longitude and latitude are bundled together (2x4 bytes)
    attr_char_val.init_len = AIR_CHAR_HUMIDITY_DATA_LEN;
    uint8_t data[AIR_CHAR_HUMIDITY_DATA_LEN] = {0};
    attr_char_val.p_value = data;


    // Add the characteristic to the service
    //
    err_code = sd_ble_gatts_characteristic_add(sh, &char_md, &attr_char_val, &sh->chs_humidity);

    return NRF_SUCCESS;
}



//
// Helper function to add the temperature characteristic to the BLE AIR service
//
static uint32_t add_temperature_characteristic(ble_air_t* sh) {
    uint32_t err_code;

    // Add characteristic UUID
    //
    ble_uuid_t char_uuid;
    ble_uuid128_t base_uuid = BLE_UUID_AIR_BASE_UUID;
    char_uuid.uuid = BLE_UUID_AIR_CHAR_TEMPERATURE;
    err_code = sd_ble_uuid_vs_add(&base_uuid, &char_uuid.type);



    // Specifiy characteristic general metadata for read/write access
    //
    ble_gatts_char_md_t char_md;
    memset(&char_md, 0, sizeof(char_md));
    char_md.char_props.read = 1;
    char_md.char_props.write = 0;
    

    // Specifiy characteristic CCCD metadata for read/write access
    //
    ble_gatts_attr_md_t cccd_md;
    memset(&cccd_md, 0, sizeof(cccd_md));   
    cccd_md.vloc = BLE_GATTS_VLOC_STACK;
    char_md.p_cccd_md = &cccd_md;
    char_md.char_props.notify = 1;


    BLE_GAP_CONN_SEC_MODE_SET_OPEN(&cccd_md.read_perm);
    BLE_GAP_CONN_SEC_MODE_SET_OPEN(&cccd_md.write_perm);

    // Specifiy the value options of the characteristic
    //
    ble_gatts_attr_t attr_char_val;
    memset(&attr_char_val, 0, sizeof(attr_char_val));
    attr_char_val.p_uuid = &char_uuid;
    attr_char_val.p_attr_md = &char_md;
    attr_char_val.max_len = AIR_CHAR_TEMPERATURE_DATA_LEN;                            // hours, minutes, seconds (3 bytes)
    attr_char_val.init_len = AIR_CHAR_TEMPERATURE_DATA_LEN;
    uint8_t data[AIR_CHAR_TEMPERATURE_DATA_LEN] = {0};
    attr_char_val.p_value = data;


    // Add the characteristic to the service
    //
    err_code = sd_ble_gatts_characteristic_add(sh, &char_md, &attr_char_val, &sh->chs_temperature);

    return NRF_SUCCESS;
}



//
// Helper function to add the pressure characteristic to the BLE AIR service
//
static uint32_t add_pressure_characteristic(ble_air_t* sh) {
    uint32_t err_code;

    // Add characteristic UUID
    //
    ble_uuid_t char_uuid;
    ble_uuid128_t base_uuid = BLE_UUID_AIR_BASE_UUID;
    char_uuid.uuid = BLE_UUID_AIR_CHAR_PRESSURE;
    err_code = sd_ble_uuid_vs_add(&base_uuid, &char_uuid.type);



    // Specifiy characteristic general metadata for read/write access
    //
    ble_gatts_char_md_t char_md;
    memset(&char_md, 0, sizeof(char_md));
    char_md.char_props.read = 1;
    char_md.char_props.write = 0;
    

    // Specifiy characteristic CCCD metadata for read/write access
    //
    ble_gatts_attr_md_t cccd_md;
    memset(&cccd_md, 0, sizeof(cccd_md));    
    cccd_md.vloc = BLE_GATTS_VLOC_STACK;
    char_md.p_cccd_md = &cccd_md;
    char_md.char_props.notify = 1;  


    BLE_GAP_CONN_SEC_MODE_SET_OPEN(&cccd_md.read_perm);
    BLE_GAP_CONN_SEC_MODE_SET_OPEN(&cccd_md.write_perm);

    // Specifiy the value options of the characteristic
    //
    ble_gatts_attr_t attr_char_val;
    memset(&attr_char_val, 0, sizeof(attr_char_val));
    attr_char_val.p_uuid = &char_uuid;
    attr_char_val.p_attr_md = &char_md;
    attr_char_val.max_len = AIR_CHAR_PRESSURE_DATA_LEN;                            // hours, minutes, seconds (3 bytes)
    attr_char_val.init_len = AIR_CHAR_PRESSURE_DATA_LEN;
    uint8_t data[AIR_CHAR_PRESSURE_DATA_LEN] = {0};
    attr_char_val.p_value = data;


    // Add the characteristic to the service
    //
    err_code = sd_ble_gatts_characteristic_add(sh, &char_md, &attr_char_val, &sh->chs_pressure);

    return NRF_SUCCESS;
}



uint32_t ble_air_service_init(ble_air_t* sh) {
    uint32_t err_code;

    // Set UUID for service
    ble_uuid_t service_uuid;
    ble_uuid128_t base_uuid = BLE_UUID_AIR_BASE_UUID;
    service_uuid.uuid = BLE_UUID_AIR_SERVICE;

    // Add service UUID
    err_code = sd_ble_uuid_vs_add(&base_uuid, &service_uuid.type);

    // Add service
    err_code = sd_ble_gatts_service_add(BLE_GATTS_SRVC_TYPE_PRIMARY, &service_uuid, &sh->service_handle);

    // Add service characteristics
    err_code = add_humidity_characteristic(sh);
    err_code = add_temperature_characteristic(sh);
    err_code = add_pressure_characteristic(sh);

    return err_code;
}


void ble_air_service_humidity_update(ble_air_t* sh, struct bme680_field_data* bme_data) {
    if (sh->conn_handle != BLE_CONN_HANDLE_INVALID) {
        uint16_t len = AIR_CHAR_HUMIDITY_DATA_LEN;
        ble_gatts_hvx_params_t hvx_params;
        memset(&hvx_params, 0, sizeof(hvx_params));

        uint8_t data[AIR_CHAR_HUMIDITY_DATA_LEN] = {0};

        // prepare data
        for (int i = 0; i < AIR_CHAR_HUMIDITY_DATA_LEN; i++) 
            data[i] = (uint8_t)(bme_data->humidity >> (i * 8));

        hvx_params.handle = sh->chs_humidity.value_handle;
        hvx_params.type = BLE_GATT_HVX_NOTIFICATION;
        hvx_params.offset = 0;
        hvx_params.p_len = &len;
        hvx_params.p_data = data;

        sd_ble_gatts_hvx(sh->conn_handle, &hvx_params);
    }
}


void ble_air_service_temperature_update(ble_air_t* sh, struct bme680_field_data* bme_data) {
    if (sh->conn_handle != BLE_CONN_HANDLE_INVALID) {
        const uint16_t len = AIR_CHAR_TEMPERATURE_DATA_LEN;
        ble_gatts_hvx_params_t hvx_params;
        memset(&hvx_params, 0, sizeof(hvx_params));

        uint8_t data[AIR_CHAR_TEMPERATURE_DATA_LEN] = {0};

        // prepare data
        for (int i = 0; i < AIR_CHAR_TEMPERATURE_DATA_LEN; i++) 
            data[i] = (uint8_t)(bme_data->temperature >> (i * 8));

        hvx_params.handle = sh->chs_temperature.value_handle;
        hvx_params.type = BLE_GATT_HVX_NOTIFICATION;
        hvx_params.offset = 0;
        hvx_params.p_len = &len;
        hvx_params.p_data = data;

        sd_ble_gatts_hvx(sh->conn_handle, &hvx_params);
    }
}



void ble_air_service_pressure_update(ble_air_t* sh, struct bme680_field_data* bme_data) {
    if (sh->conn_handle != BLE_CONN_HANDLE_INVALID) {
        const uint16_t len = AIR_CHAR_PRESSURE_DATA_LEN;
        ble_gatts_hvx_params_t hvx_params;
        memset(&hvx_params, 0, sizeof(hvx_params));

        uint8_t data[AIR_CHAR_PRESSURE_DATA_LEN] = {0};

        // prepare data
        for (int i = 0; i < AIR_CHAR_PRESSURE_DATA_LEN; i++) 
            data[i] = (uint8_t)(bme_data->pressure >> (i * 8));

        hvx_params.handle = sh->chs_pressure.value_handle;
        hvx_params.type = BLE_GATT_HVX_NOTIFICATION;
        hvx_params.offset = 0;
        hvx_params.p_len = &len;
        hvx_params.p_data = data;

        sd_ble_gatts_hvx(sh->conn_handle, &hvx_params);
    }
}