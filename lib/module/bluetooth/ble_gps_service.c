#include "ble_gps_service.h"


#define GPS_CHAR_POS_DATA_LEN     8
#define GPS_CHAR_TIME_DATA_LEN    3
#define GPS_CHAR_DATE_DATA_LEN    3


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


//
// Helper function to add the position characteristic to the BLE GPS service
//
static uint32_t add_position_characteristic(ble_gps_t* sh) {
    uint32_t err_code;

    // Add characteristic UUID
    //
    ble_uuid_t char_uuid;
    ble_uuid128_t base_uuid = BLE_UUID_GPS_BASE_UUID;
    char_uuid.uuid = BLE_UUID_GPS_CHAR_POSITION;
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
    cccd_md.char_props.notify = 1;   
    cccd_md.vloc = BLE_GATTS_VLOC_STACK;
    char_md.p_cccd_md = &cccd_md;


    BLE_GAP_COON_SEC_MODE_SET_OPEN(&cccd_md.read_perm);
    BLE_GAP_COON_SEC_MODE_SET_OPEN(&cccd_md.write_perm);

    // Specifiy the value options of the characteristic
    //
    ble_gatts_attr_t attr_char_val;
    memset(&attr_char_val, 0, sizeof(attr_char_val));
    attr_char_val.p_uuid = &char_uuid;
    attr_char_val.p_attr_md = &char_md;
    attr_char_val.max_len = GPS_CHAR_POS_DATA_LEN                 // longitude and latitude are bundled together (2x4 bytes)
    attr_char_val.init_len = GPS_CHAR_POS_DATA_LEN;
    uint8_t[GPS_CHAR_POS_DATA_LEN] data = {0};
    attr_char_val.p_value = data;


    // Add the characteristic to the service
    //
    err_code = sd_ble_gatts_characteristic_add(sh, &char_md, &attr_char_val, &sh->chs_position);

    return NRF_SUCCESS;
}


//
// Helper function to add the time characteristic to the BLE GPS service
//
static uint32_t add_time_characteristic(ble_gps_t* sh) {
    uint32_t err_code;

    // Add characteristic UUID
    //
    ble_uuid_t char_uuid;
    ble_uuid128_t base_uuid = BLE_UUID_GPS_BASE_UUID;
    char_uuid.uuid = BLE_UUID_GPS_CHAR_TIME;
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
    cccd_md.char_props.notify = 1;   
    cccd_md.vloc = BLE_GATTS_VLOC_STACK;
    char_md.p_cccd_md = &cccd_md;


    BLE_GAP_COON_SEC_MODE_SET_OPEN(&cccd_md.read_perm);
    BLE_GAP_COON_SEC_MODE_SET_OPEN(&cccd_md.write_perm);

    // Specifiy the value options of the characteristic
    //
    ble_gatts_attr_t attr_char_val;
    memset(&attr_char_val, 0, sizeof(attr_char_val));
    attr_char_val.p_uuid = &char_uuid;
    attr_char_val.p_attr_md = &char_md;
    attr_char_val.max_len = GPS_CHAR_TIME_DATA_LEN;                            // hours, minutes, seconds (3 bytes)
    attr_char_val.init_len = GPS_CHAR_TIME_DATA_LEN;
    uint8_t[GPS_CHAR_TIME_DATA_LEN] data = {0};
    attr_char_val.p_value = data;


    // Add the characteristic to the service
    //
    err_code = sd_ble_gatts_characteristic_add(sh, &char_md, &attr_char_val, &sh->chs_position);

    return NRF_SUCCESS;
}


//
// Helper function to add the date characteristic to the BLE GPS service
//
static uint32_t add_date_characteristic(ble_gps_t* sh) {
    uint32_t err_code;

    // Add characteristic UUID
    //
    ble_uuid_t char_uuid;
    ble_uuid128_t base_uuid = BLE_UUID_GPS_BASE_UUID;
    char_uuid.uuid = BLE_UUID_GPS_CHAR_DATE;
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
    cccd_md.char_props.notify = 1;   
    cccd_md.vloc = BLE_GATTS_VLOC_STACK;
    char_md.p_cccd_md = &cccd_md;


    BLE_GAP_COON_SEC_MODE_SET_OPEN(&cccd_md.read_perm);
    BLE_GAP_COON_SEC_MODE_SET_OPEN(&cccd_md.write_perm);

    // Specifiy the value options of the characteristic
    //
    ble_gatts_attr_t attr_char_val;
    memset(&attr_char_val, 0, sizeof(attr_char_val));
    attr_char_val.p_uuid = &char_uuid;
    attr_char_val.p_attr_md = &char_md;
    attr_char_val.max_len = GPS_CHAR_DATE_DATA_LEN;                             // year, month, day (3 bytes)
    attr_char_val.init_len = GPS_CHAR_DATE_DATA_LEN;
    uint8_t[GPS_CHAR_DATE_DATA_LEN] data = {0};
    attr_char_val.p_value = data;


    // Add the characteristic to the service
    //
    err_code = sd_ble_gatts_characteristic_add(sh, &char_md, &attr_char_val, &sh->chs_position);

    return NRF_SUCCESS;
}




uint32_t ble_gps_service_init(ble_gps_t* sh) {
    uint32_t err_code;

    // Set UUID for service
    ble_uuid_t service_uuid;
    ble_uuid128_t base_uid = BLE_UUID_GPS_BASE_UUID;
    service_uuid.uuid = BLE_UUID_GPS_SERVICE;

    // Add service UUID
    err_code = sd_ble_uuid_vs_add(&base_uuid, &service_uuid.type);

    // Add service
    err_code = sd_ble_gatts_service_add(BLE_GATTS_SRVC_TYPE_PRIMARY, &service_uuid, &sh->service_handle);

    // Add service characteristics
    err_code = add_position_characteristic(sh);
    err_code = add_time_characteristic(sh);
    err_code = add_date_characteristic(sh);

    return err_code;
}





void ble_gps_service_position_update(ble_gps_t* sh, snow_gps_position_information* gps_info) {
    if (sh->conn_handle != BLE_CONN_HANDLE_INVALID) {
        uint16_t len = GPS_CHAR_POS_DATA_LEN;
        ble_gatts_hvx_params_t hvx_params;
        memset(&hvx_params, 0, sizeof(hvx_params));

        uint8_t data[len] = {0};

        // Prepare data
        // TODO Leon's protip -> uint8_t* benutzen und pointer hochzählen
        //uint8_t* test =  (uint8_t*)(&gps_info->longitude);
        //for (int i = 0; i < len / 2; i++) 
        //    *(data++) = *(test++);

        // Copy the bits of the floats one-to-one into integers to preserve the information without converting
        uint32_t longitude = *(uint32_t*)(&gps_info->longitude);
        uint32_t latitude = *(uint32_t*)(&gps_info->latitude);

        // Put longitude into the send buffer
        for (int i = 0; i < len / 2; i++) 
            data[i] = (uint8_t)(longitude >> (i * 8));
        
        // Put latitude into the send buffer
        for (int i = 0; i < len / 2; i++) 
            data[i+len/2] = (uint8_t)(latitude >> (i * 8));

        hvx_params.handle = sh->chs_position.value_handle;
        hvx_params.type = BLE_GATT_HVX_NOTIFICATION;
        hvx_params.offset = 0;
        hvx_params.p_len = &len;
        hvx_params.p_data = data;

        sd_ble_gatts_hvx(sh->conn_handle, &hvx_params);
    }
}


void ble_gps_service_time_update(ble_gps_t* sh, snow_gps_position_information* gps_info) {
    if (sh->conn_handle != BLE_CONN_HANDLE_INVALID) {
        uint16_t len = GPS_CHAR_TIME_DATA_LEN;
        ble_gatts_hvx_params_t hvx_params;
        memset(&hvx_params, 0, sizeof(hvx_params));

        uint8_t data[len] = {0};

        // prepare data
        data[0] = (uint8_t)gps_info->time.hours;
        data[1] = (uint8_t)gps_info->time.minutes;
        data[2] = (uint8_t)gps_info->time.seconds;

        hvx_params.handle = sh->chs_position.value_handle;
        hvx_params.type = BLE_GATT_HVX_NOTIFICATION;
        hvx_params.offset = 0;
        hvx_params.p_len = &len;
        hvx_params.p_data = data;

        sd_ble_gatts_hvx(sh->conn_handle, &hvx_params);
    }
}


void ble_gps_service_date_update(ble_gps_t* sh, snow_gps_position_information* gps_info) {
    if (sh->conn_handle != BLE_CONN_HANDLE_INVALID) {
        uint16_t len = GPS_CHAR_DATE_DATA_LEN;
        ble_gatts_hvx_params_t hvx_params;
        memset(&hvx_params, 0, sizeof(hvx_params));

        uint8_t data[len] = {0};

        // prepare data
        data[0] = (uint8_t)gps_info->date.year;
        data[1] = (uint8_t)gps_info->date.month;
        data[2] = (uint8_t)gps_info->date.day;

        hvx_params.handle = sh->chs_position.value_handle;
        hvx_params.type = BLE_GATT_HVX_NOTIFICATION;
        hvx_params.offset = 0;
        hvx_params.p_len = &len;
        hvx_params.p_data = data;

        sd_ble_gatts_hvx(sh->conn_handle, &hvx_params);
    }
}