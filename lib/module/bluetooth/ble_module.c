#include "ble_module.h"

#include "nordic_common.h"
#include "nrf.h"
#include "app_error.h"
#include "ble.h"
#include "ble_hci.h"
#include "ble_srv_common.h"
#include "ble_advdata.h"
#include "ble_advertising.h"
#include "ble_conn_params.h"
#include "nrf_ble_gatt.h"
#include "nrf_sdh.h"
#include "nrf_sdh_soc.h"
#include "nrf_sdh_ble.h"
#include "app_timer.h"
#include "peer_manager.h"
#include "peer_manager_handler.h"
#include "bsp_btn_ble.h"
#include "ble_conn_state.h"
#include "nrf_ble_gatt.h"
#include "nrf_ble_qwr.h"
#include "nrf_pwr_mgmt.h"
#include "ble_nus.h"

#include "nrf_log.h"
#include "nrf_log_ctrl.h"
#include "nrf_log_default_backends.h"

#include "ble_snow_service.h"

#include "snow_slave.h"
#include "snow_gps.h"
#include "bme680.h"

// TODO
// - Define app timers for service updates


NRF_BLE_GATT_DEF(m_gatt);
NRF_BLE_QWR_DEF(m_qwr);
BLE_ADVERTISING_DEF(m_adv);

BLE_NUS_DEF(m_nus, NRF_SDH_BLE_TOTAL_LINK_COUNT);

static uint16_t m_conn_handle = BLE_CONN_HANDLE_INVALID;
static uint16_t m_ble_nus_max_data_len = BLE_GATT_ATT_MTU_DEFAULT - 3;

static uint8_t m_nus_data_rx_buf[SNOW_BLE_NUS_RX_MAX_LEN] = {0};
static uint16_t m_nus_rx_cnt = 0;



static void timer_snow_timeout_handler(void* context) {
}

// Add services to advertising here
//
static ble_uuid_t m_adv_uuids[] = {
    { BLE_UUID_NUS_SERVICE, BLE_UUID_TYPE_VENDOR_BEGIN }
    //{ BLE_UUID_SNOW_SERVICE, BLE_UUID_TYPE_VENDOR_BEGIN }
};

static void advertising_start(bool erase_bonds);



static void parse_ble_command(uint8_t* cmd, uint8_t len) {
    switch (cmd[0]) {
        case 'c': {
            if (len != 4) {
                snow_slave_ble_send_error(cmd[0], SNOW_BLE_ERROR_UNEXPECTED_COMMAND_LENGTH, NULL, 0);
                return;
            }

            uint16_t interval = ((uint16_t)cmd[1] << 8) | cmd[2];
            bool timestamp = cmd[3] == 1;

            snow_slave_toggle_continuous_measurement(interval);
        } break;

        case 'm': {
            uint16_t interval = ((uint16_t)cmd[1] << 8) | cmd[2];
            uint8_t amount = cmd[3];
            snow_slave_single_measurement(interval, amount);
        } break;

        case 'd': {
            
        } break;

        case 'r': {
            NVIC_SystemReset();
        } break;

        case 's': {

        } break;

        case 'i': {
            snow_slave_ble_send_device_info();
        } break;

        default: {
            // Unknown command ID
            snow_slave_ble_send_error(cmd[0], SNOW_BLE_ERROR_UNKNOWN_COMMAND, NULL, 0);
        } break;
    }
}



// 
// command structure 
// first byte indicates command type
// following bytes contain command parameters
// A command is terminated by a ;
// Sending multiple commands in one message is (will be) supported
//
// [] = obligatory parameter
// {} = optional parameter
//
// commands:
// c => toggle a continuous measurement
// parameters: [measurement interval; 2 bytes][include timestamp; 1 byte]
//
// m => measure once
// r => reset device
// s => retrieve status of all modules
// i => retrieve device information such as version number etc.
// d => send the entire dataset of measurements
//
// Notifications: 
// (sent by the device on its own)
// e => error
// parameters: [command type; 1 byte][error type; 1 byte]{error description; x bytes} 
//
static void parse_ble_query(uint8_t* cmd, uint16_t len) {
    uint16_t start = 0;
    for (uint8_t i = 0; i < len; i++) {
        if (cmd[i] == ';') {                       
            parse_ble_command(cmd + start, i - start);
            start = i + 1;
        }
    }
}





static void nus_data_handler(ble_nus_evt_t * p_evt)
{   
    switch (p_evt->type) {
        case BLE_NUS_EVT_RX_DATA: {
            //NRF_LOG_DEBUG("Received data from BLE NUS. Writing data on UART.");
            //NRF_LOG_HEXDUMP_DEBUG(p_evt->params.rx_data.p_data, len);
            
            uint8_t* rx_buf;
            uint32_t err_code;
            uint16_t len = p_evt->params.rx_data.length;
            rx_buf = p_evt->params.rx_data.p_data;            
            
            uint8_t i = 0;
            for (i; i < len; i++) {
                m_nus_data_rx_buf[i + m_nus_rx_cnt] = rx_buf[i];
            }
            m_nus_rx_cnt += i;

            if (rx_buf[len-1] == '\n' && rx_buf[len-2] == '\r') {             
                parse_ble_query(m_nus_data_rx_buf, m_nus_rx_cnt - 2);                 
                printf(m_nus_data_rx_buf);
                m_nus_rx_cnt = 0;
            }
            
        } break;

        case BLE_NUS_EVT_TX_RDY: {
            
        } break;
    }
}


//
// Send a data package of variable size in BLE_NUS_MAX_DATA_LEN sized chunks
//
uint32_t snow_ble_data_send(uint8_t* data, uint16_t len) {
    uint32_t err_code;

    // Data packet has to end with \r\n
    if (data[len-1] != '\n' && data[len-2] != '\r')
        return NRF_ERROR_INVALID_DATA;
    
    uint16_t max_len = 0;
    uint8_t current_pos = 0;

    // Notify main module that a transmission is about to start
    snow_slave_ble_on_tx_start();

    while (len - current_pos - max_len != 0) {
        max_len = BLE_NUS_MAX_DATA_LEN;
        // If the remaining length is smaller than a data chunk
        if (len - current_pos < BLE_NUS_MAX_DATA_LEN) 
            // set the chunk length for the final one accordingly
            max_len = len - current_pos;

        // Send a chunk of data
        do {
            err_code = ble_nus_data_send(&m_nus, data + current_pos, &max_len, m_conn_handle);
        } while (err_code == NRF_ERROR_RESOURCES);

        printf("send");
        printf("%d", len - current_pos - max_len);

        // Increase position pointer
        current_pos += max_len;       
    }

    return err_code;
}




/**@brief Callback function for asserts in the SoftDevice.
 *
 * @details This function will be called in case of an assert in the SoftDevice.
 *
 * @warning This handler is an example only and does not fit a final product. You need to analyze
 *          how your product is supposed to react in case of Assert.
 * @warning On assert from the SoftDevice, the system can only recover on reset.
 *
 * @param[in] line_num   Line number of the failing ASSERT call.
 * @param[in] file_name  File name of the failing ASSERT call.
 */
void assert_nrf_callback(uint16_t line_num, const uint8_t * p_file_name)
{
    app_error_handler(DEAD_BEEF, line_num, p_file_name);
}



static void pm_evt_handler(pm_evt_t const * p_evt) {
    ret_code_t err_code;

    switch (p_evt->evt_id) {
    
        case PM_EVT_BONDED_PEER_CONNECTED: {
            NRF_LOG_INFO("Connected to a previously bonded device.");
        } break;

        case PM_EVT_CONN_SEC_SUCCEEDED: {
            NRF_LOG_INFO("Connection secured: role: %d, conn_handle: 0x%x, procedure: %d.",
                         ble_conn_state_role(p_evt->conn_handle),
                         p_evt->conn_handle,
                         p_evt->params.conn_sec_succeeded.procedure);
        } break;

        case PM_EVT_CONN_SEC_FAILED:  {
            /* Often, when securing fails, it shouldn't be restarted, for security reasons.
             * Other times, it can be restarted directly.
             * Sometimes it can be restarted, but only after changing some Security Parameters.
             * Sometimes, it cannot be restarted until the link is disconnected and reconnected.
             * Sometimes it is impossible, to secure the link, or the peer device does not support it.
             * How to handle this error is highly application dependent. */
        } break;

        case PM_EVT_CONN_SEC_CONFIG_REQ: {
            // Reject pairing request from an already bonded peer.
            pm_conn_sec_config_t conn_sec_config = {.allow_repairing = false};
            pm_conn_sec_config_reply(p_evt->conn_handle, &conn_sec_config);
        } break;

        case PM_EVT_PEERS_DELETE_SUCCEEDED: {
            advertising_start(false);
        } break;

        case PM_EVT_PEER_DATA_UPDATE_FAILED: {
            // Assert.
            APP_ERROR_CHECK(p_evt->params.peer_data_update_failed.error);
        } break;

        case PM_EVT_PEER_DELETE_FAILED: {
            // Assert.
            APP_ERROR_CHECK(p_evt->params.peer_delete_failed.error);
        } break;

        case PM_EVT_PEERS_DELETE_FAILED: {
            // Assert.
            APP_ERROR_CHECK(p_evt->params.peers_delete_failed_evt.error);
        } break;

        case PM_EVT_ERROR_UNEXPECTED: {
            // Assert.
            APP_ERROR_CHECK(p_evt->params.error_unexpected.error);
        } break;

        case PM_EVT_CONN_SEC_START:
        case PM_EVT_PEER_DATA_UPDATE_SUCCEEDED:
        case PM_EVT_PEER_DELETE_SUCCEEDED:
        case PM_EVT_LOCAL_DB_CACHE_APPLIED:
        case PM_EVT_LOCAL_DB_CACHE_APPLY_FAILED:
            // This can happen when the local DB has changed.
        case PM_EVT_SERVICE_CHANGED_IND_SENT:
        case PM_EVT_SERVICE_CHANGED_IND_CONFIRMED:
        default:
            break;
    }
}


/**@brief Function for the Timer initialization.
 *
 * @details Initializes the timer module. This creates and starts application timers.
 */
static void timers_init(void) {
    // Initialize timer module.
    

    // Add timers
    //
    //app_timer_create(&m_snow_timer_id, APP_TIMER_MODE_REPEATED, timer_snow_timeout_handler);

}



/**@brief Function for the GAP initialization.
 *
 * @details This function sets up all the necessary GAP (Generic Access Profile) parameters of the
 *          device including the device name, appearance, and the preferred connection parameters.
 */
static void gap_params_init(void) {
    ret_code_t              err_code;
    ble_gap_conn_params_t   gap_conn_params;
    ble_gap_conn_sec_mode_t sec_mode;

    BLE_GAP_CONN_SEC_MODE_SET_OPEN(&sec_mode);

    err_code = sd_ble_gap_device_name_set(&sec_mode,
                                          (const uint8_t *)DEVICE_NAME,
                                          strlen(DEVICE_NAME));
    APP_ERROR_CHECK(err_code);

    memset(&gap_conn_params, 0, sizeof(gap_conn_params));

    gap_conn_params.min_conn_interval = MIN_CONN_INTERVAL;
    gap_conn_params.max_conn_interval = MAX_CONN_INTERVAL;
    gap_conn_params.slave_latency     = SLAVE_LATENCY;
    gap_conn_params.conn_sup_timeout  = CONN_SUP_TIMEOUT;

    err_code = sd_ble_gap_ppcp_set(&gap_conn_params);
    APP_ERROR_CHECK(err_code);
}


/**@brief Function for handling events from the GATT library. */
void gatt_evt_handler(nrf_ble_gatt_t * p_gatt, nrf_ble_gatt_evt_t const * p_evt)
{
    if ((m_conn_handle == p_evt->conn_handle) && (p_evt->evt_id == NRF_BLE_GATT_EVT_ATT_MTU_UPDATED))
    {
        m_ble_nus_max_data_len = p_evt->params.att_mtu_effective - OPCODE_LENGTH - HANDLE_LENGTH;
        NRF_LOG_INFO("Data len is set to 0x%X(%d)", m_ble_nus_max_data_len, m_ble_nus_max_data_len);
    }
    NRF_LOG_DEBUG("ATT MTU exchange completed. central 0x%x peripheral 0x%x",
                  p_gatt->att_mtu_desired_central,
                  p_gatt->att_mtu_desired_periph);
}



/**@brief Function for initializing the GATT module.
 */
static void gatt_init(void)
{
    ret_code_t err_code = nrf_ble_gatt_init(&m_gatt, gatt_evt_handler);
    APP_ERROR_CHECK(err_code);

    err_code = nrf_ble_gatt_att_mtu_periph_set(&m_gatt, NRF_SDH_BLE_GATT_MAX_MTU_SIZE);
    APP_ERROR_CHECK(err_code);
}


/**@brief Function for handling Queued Write Module errors.
 *
 * @details A pointer to this function will be passed to each service which may need to inform the
 *          application about an error.
 *
 * @param[in]   nrf_error   Error code containing information about what went wrong.
 */
static void nrf_qwr_error_handler(uint32_t nrf_error) {
    APP_ERROR_HANDLER(nrf_error);
}



/**@brief Function for initializing services that will be used by the application.
 */
static void services_init(void) {
    uint32_t         err_code;
    nrf_ble_qwr_init_t qwr_init = {0};

    ble_nus_init_t  nus_init;

    // Initialize Queued Write Module.
    qwr_init.error_handler = nrf_qwr_error_handler;

    err_code = nrf_ble_qwr_init(&m_qwr, &qwr_init);
    APP_ERROR_CHECK(err_code);

    // Init services here
    //
    //err_code = ble_snow_service_init(&m_snow_service);

    memset(&nus_init, 0, sizeof(nus_init));
    nus_init.data_handler = nus_data_handler;

    err_code = ble_nus_init(&m_nus, &nus_init);
}



/**@brief Function for handling the Connection Parameters Module.
 *
 * @details This function will be called for all events in the Connection Parameters Module which
 *          are passed to the application.
 *          @note All this function does is to disconnect. This could have been done by simply
 *                setting the disconnect_on_fail config parameter, but instead we use the event
 *                handler mechanism to demonstrate its use.
 *
 * @param[in] p_evt  Event received from the Connection Parameters Module.
 */
static void on_conn_params_evt(ble_conn_params_evt_t * p_evt) {
    ret_code_t err_code;

    if (p_evt->evt_type == BLE_CONN_PARAMS_EVT_FAILED) {
        err_code = sd_ble_gap_disconnect(m_conn_handle, BLE_HCI_CONN_INTERVAL_UNACCEPTABLE);
        APP_ERROR_CHECK(err_code);
    }
}



/**@brief Function for handling a Connection Parameters error.
 *
 * @param[in] nrf_error  Error code containing information about what went wrong.
 */
static void conn_params_error_handler(uint32_t nrf_error) {
    APP_ERROR_HANDLER(nrf_error);
}



/**@brief Function for initializing the Connection Parameters module.
 */
static void conn_params_init(void) {
    ret_code_t             err_code;
    ble_conn_params_init_t cp_init;

    memset(&cp_init, 0, sizeof(cp_init));

    cp_init.p_conn_params                  = NULL;
    cp_init.first_conn_params_update_delay = FIRST_CONN_PARAMS_UPDATE_DELAY;
    cp_init.next_conn_params_update_delay  = NEXT_CONN_PARAMS_UPDATE_DELAY;
    cp_init.max_conn_params_update_count   = MAX_CONN_PARAMS_UPDATE_COUNT;
    cp_init.start_on_notify_cccd_handle    = BLE_GATT_HANDLE_INVALID;
    cp_init.disconnect_on_fail             = false;
    cp_init.evt_handler                    = on_conn_params_evt;
    cp_init.error_handler                  = conn_params_error_handler;

    err_code = ble_conn_params_init(&cp_init);
    APP_ERROR_CHECK(err_code);
}



/**@brief Function for starting timers.
 */
static void application_timers_start(void) {
    //app_timer_start(m_snow_timer_id, SNOW_TIMER_INTERVAL, NULL); 
}



// TODO Re-implement sleep mode
/**@brief Function for putting the chip into sleep mode.
 *
 * @note This function will not return.
 */
/*static void sleep_mode_enter(void) {
    ret_code_t err_code;

    err_code = bsp_indication_set(BSP_INDICATE_IDLE);
    APP_ERROR_CHECK(err_code);

    // Prepare wakeup buttons.
    err_code = bsp_btn_ble_sleep_mode_prepare();
    APP_ERROR_CHECK(err_code);

    // Go to system-off mode (this function will not return; wakeup will cause a reset).
    err_code = sd_power_system_off();
    APP_ERROR_CHECK(err_code);
}*/



/**@brief Function for handling advertising events.
 *
 * @details This function will be called for advertising events which are passed to the application.
 *
 * @param[in] ble_adv_evt  Advertising event.
 */
static void on_adv_evt(ble_adv_evt_t ble_adv_evt) {
    ret_code_t err_code;

    switch (ble_adv_evt) {
        case BLE_ADV_EVT_FAST:
            NRF_LOG_INFO("Fast advertising.");
            err_code = bsp_indication_set(BSP_INDICATE_ADVERTISING);
            APP_ERROR_CHECK(err_code);
            break;

        case BLE_ADV_EVT_IDLE:
            //sleep_mode_enter();
            break;

        default:
            break;
    }
}



/**@brief Function for handling BLE events.
 *
 * @param[in]   p_ble_evt   Bluetooth stack event.
 * @param[in]   p_context   Unused.
 */
static void ble_evt_handler(ble_evt_t const * p_ble_evt, void * p_context) {
    ret_code_t err_code = NRF_SUCCESS;
		

    switch (p_ble_evt->header.evt_id) {
        case BLE_GAP_EVT_DISCONNECTED:
            NRF_LOG_INFO("Disconnected.");
            // LED indication will be changed when advertising starts.
 
            snow_slave_ble_on_disconnected();
            m_conn_handle = BLE_CONN_HANDLE_INVALID;

            break;

        case BLE_GAP_EVT_CONNECTED:
            NRF_LOG_INFO("Connected.");
            err_code = bsp_indication_set(BSP_INDICATE_CONNECTED);
            APP_ERROR_CHECK(err_code);
            m_conn_handle = p_ble_evt->evt.gap_evt.conn_handle;
            err_code = nrf_ble_qwr_conn_handle_assign(&m_qwr, m_conn_handle);
            APP_ERROR_CHECK(err_code);

            //TODO When connected; start our timer to start regular temperature measurements
            //app_timer_start(m_our_char_timer_id, OUR_CHAR_TIMER_INTERVAL, NULL);
            
            snow_slave_ble_on_connected();

        case BLE_GAP_EVT_PHY_UPDATE_REQUEST:
        {
            NRF_LOG_DEBUG("PHY update request.");
            ble_gap_phys_t const phys =
            {
                .rx_phys = BLE_GAP_PHY_AUTO,
                .tx_phys = BLE_GAP_PHY_AUTO,
            };
            err_code = sd_ble_gap_phy_update(p_ble_evt->evt.gap_evt.conn_handle, &phys);
            APP_ERROR_CHECK(err_code);
        } break;

        case BLE_GATTC_EVT_TIMEOUT:
            // Disconnect on GATT Client timeout event.
            NRF_LOG_DEBUG("GATT Client Timeout.");
            err_code = sd_ble_gap_disconnect(p_ble_evt->evt.gattc_evt.conn_handle,
                                             BLE_HCI_REMOTE_USER_TERMINATED_CONNECTION);
            APP_ERROR_CHECK(err_code);
            break;

        case BLE_GATTS_EVT_TIMEOUT:
            // Disconnect on GATT Server timeout event.
            NRF_LOG_DEBUG("GATT Server Timeout.");
            err_code = sd_ble_gap_disconnect(p_ble_evt->evt.gatts_evt.conn_handle,
                                             BLE_HCI_REMOTE_USER_TERMINATED_CONNECTION);
            APP_ERROR_CHECK(err_code);
            break;

        case BLE_GATTS_EVT_HVN_TX_COMPLETE:
            snow_slave_ble_on_tx_done();
            break;

        default:
            // No implementation needed.
            break;
    }	
}


/**@brief Function for initializing the BLE stack.
 *
 * @details Initializes the SoftDevice and the BLE event interrupt.
 */
static void ble_stack_init(void) {
    ret_code_t err_code;

    err_code = nrf_sdh_enable_request();
    APP_ERROR_CHECK(err_code);

    // Configure the BLE stack using the default settings.
    // Fetch the start address of the application RAM.
    uint32_t ram_start = 0;
    err_code = nrf_sdh_ble_default_cfg_set(APP_BLE_CONN_CFG_TAG, &ram_start);
    APP_ERROR_CHECK(err_code);

    // Enable BLE stack.
    err_code = nrf_sdh_ble_enable(&ram_start);
    APP_ERROR_CHECK(err_code);

    // Register a handler for BLE events.
    NRF_SDH_BLE_OBSERVER(m_ble_observer, 2, ble_evt_handler, NULL);

    //TODO OUR_JOB: Step 3.C Set up a BLE event observer to call ble_our_service_on_ble_evt() to do housekeeping of ble connections related to our service and characteristics.
    //NRF_SDH_BLE_OBSERVER(m_snow_service_observer, APP_BLE_OBSERVER_PRIO, ble_snow_service_on_ble_evt, (void*) &m_snow_service);
}



/**@brief Function for the Peer Manager initialization.
 */
static void peer_manager_init(void) {
    ble_gap_sec_params_t sec_param;
    ret_code_t           err_code;

    err_code = pm_init();
    APP_ERROR_CHECK(err_code);

    memset(&sec_param, 0, sizeof(ble_gap_sec_params_t));

    // Security parameters to be used for all security procedures.
    sec_param.bond           = SEC_PARAM_BOND;
    sec_param.mitm           = SEC_PARAM_MITM;
    sec_param.lesc           = SEC_PARAM_LESC;
    sec_param.keypress       = SEC_PARAM_KEYPRESS;
    sec_param.io_caps        = SEC_PARAM_IO_CAPABILITIES;
    sec_param.oob            = SEC_PARAM_OOB;
    sec_param.min_key_size   = SEC_PARAM_MIN_KEY_SIZE;
    sec_param.max_key_size   = SEC_PARAM_MAX_KEY_SIZE;
    sec_param.kdist_own.enc  = 1;
    sec_param.kdist_own.id   = 1;
    sec_param.kdist_peer.enc = 1;
    sec_param.kdist_peer.id  = 1;

    err_code = pm_sec_params_set(&sec_param);
    APP_ERROR_CHECK(err_code);

    err_code = pm_register(pm_evt_handler);
    APP_ERROR_CHECK(err_code);
}



/**@brief Clear bond information from persistent storage.
 */
static void delete_bonds(void)
{
    ret_code_t err_code;

    NRF_LOG_INFO("Erase bonds!");

    err_code = pm_peers_delete();
    APP_ERROR_CHECK(err_code);
}



/**@brief Function for handling events from the BSP module.
 *
 * @param[in]   event   Event generated when button is pressed.
 */
/*static void bsp_event_handler(bsp_event_t event) {
    ret_code_t err_code;

    switch (event) {
        case BSP_EVENT_SLEEP:
            //sleep_mode_enter();
            break; // BSP_EVENT_SLEEP

        case BSP_EVENT_DISCONNECT:
            err_code = sd_ble_gap_disconnect(m_conn_handle,
                                             BLE_HCI_REMOTE_USER_TERMINATED_CONNECTION);
            if (err_code != NRF_ERROR_INVALID_STATE) {
                APP_ERROR_CHECK(err_code);
            }
            break; // BSP_EVENT_DISCONNECT

        case BSP_EVENT_WHITELIST_OFF:
            if (m_conn_handle == BLE_CONN_HANDLE_INVALID) {
                err_code = ble_advertising_restart_without_whitelist(&m_adv);
                if (err_code != NRF_ERROR_INVALID_STATE) {
                    APP_ERROR_CHECK(err_code);
                }
            }
            break; // BSP_EVENT_KEY_0

        default:
            break;
    }
}    */



/**@brief Function for initializing the Advertising functionality.
 */
static void advertising_init(void) {
    ret_code_t             err_code;
    ble_advertising_init_t init;

    memset(&init, 0, sizeof(init));

    init.advdata.name_type               = BLE_ADVDATA_FULL_NAME;
    init.advdata.include_appearance      = true;
    init.advdata.flags                   = BLE_GAP_ADV_FLAGS_LE_ONLY_GENERAL_DISC_MODE;

    init.srdata.uuids_complete.uuid_cnt = sizeof(m_adv_uuids) / sizeof(m_adv_uuids[0]);
    init.srdata.uuids_complete.p_uuids = m_adv_uuids;	
	
    init.config.ble_adv_fast_enabled  = true;
    init.config.ble_adv_fast_interval = APP_ADV_INTERVAL;
    init.config.ble_adv_fast_timeout  = APP_ADV_DURATION;

    init.evt_handler = on_adv_evt;

    err_code = ble_advertising_init(&m_adv, &init);
    APP_ERROR_CHECK(err_code);

    ble_advertising_conn_cfg_tag_set(&m_adv, APP_BLE_CONN_CFG_TAG);
}



/**@brief Function for initializing buttons and leds.
 *
 * @param[out] p_erase_bonds  Will be true if the clear bonding button was pressed to wake the application up.
 */
 /*
static void buttons_leds_init(bool * p_erase_bonds) {
    ret_code_t err_code;
    bsp_event_t startup_event;

    err_code = bsp_init(BSP_INIT_LEDS | BSP_INIT_BUTTONS, bsp_event_handler);
    APP_ERROR_CHECK(err_code);

    err_code = bsp_btn_ble_init(NULL, &startup_event);
    APP_ERROR_CHECK(err_code);

    *p_erase_bonds = (startup_event == BSP_EVENT_CLEAR_BONDING_DATA);
}
*/


/**@brief Function for initializing the nrf log module.
 */
static void log_init(void) {
    ret_code_t err_code = NRF_LOG_INIT(NULL);
    APP_ERROR_CHECK(err_code);

    NRF_LOG_DEFAULT_BACKENDS_INIT();
}



/**@brief Function for initializing power management.
 */
/*static void power_management_init(void) {
    ret_code_t err_code;
    err_code = nrf_pwr_mgmt_init();
    APP_ERROR_CHECK(err_code);
}*/


/**@brief Function for handling the idle state (main loop).
 *
 * @details If there is no pending log operation, then sleep until next the next event occurs.
 */
static void idle_state_handle(void) {
    if (NRF_LOG_PROCESS() == false) {
        nrf_pwr_mgmt_run();
    }
}


/**@brief Function for starting advertising.
 */
static void advertising_start(bool erase_bonds) {
    if (erase_bonds == true) {
        delete_bonds();
        // Advertising is started by PM_EVT_PEERS_DELETED_SUCEEDED event
    } else {
        ret_code_t err_code = ble_advertising_start(&m_adv, BLE_ADV_MODE_FAST);

        APP_ERROR_CHECK(err_code);
    }
}



uint32_t snow_ble_init() {
    bool erase_bonds;

     // Initialize.
    log_init();
    timers_init();
    //buttons_leds_init(&erase_bonds);
    //power_management_init();
    ble_stack_init();
    gap_params_init();
    gatt_init();
    services_init();
    advertising_init();
    conn_params_init();
    peer_manager_init();

    // Start execution.
    application_timers_start();
    advertising_start(erase_bonds);
    
    return NRF_SUCCESS;
}






