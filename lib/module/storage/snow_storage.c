#include "snow_storage.h"
#include "nrf_log.h"
#include "nrf_log_ctrl.h"
#include "nrf_log_default_backends.h"

fds_stat_t m_fds_stat = {0};
m_fds_intialized = false;
m_flag_gc = false;


// This function creates or updates a measurement series file 
// Update if => file id exists
// Create if => file id doesn't exist OR file id is zero
// If file id zero => the next free file id will be selected by the file system manager and "returned" in the pointer of the parameter pointer's file id field
//
ret_code_t snow_slave_fds_save_measurement_series(snow_slave_measurement_series_t* mss) {
    snow_slave_measurement_series_info_t* info = &mss->info;
    snow_slave_measurement_t* ms = mss->measurements;

    fds_record_t record = {
        .file_id = FDS_ID_MEASUREMENT,
        .key = mss->meas_id + FDS_KEY_OFFSET
    };

    ret_code_t rc;
    fds_record_desc_t desc = {0};
    fds_find_token_t tok = {0};

    if (record.key == FDS_KEY_OFFSET) {
        // Create new record with the first free key available      
        record.key = snow_slave_fds_get_first_free_key(FDS_ID_MEASUREMENT);
        if (record.key == 0) 
            return FDS_ERR_NOT_FOUND;
           
        rc = fds_record_find(FDS_ID_MEASUREMENT, record.key, &desc, &tok);
        if (rc == FDS_ERR_NOT_FOUND) {
            //printf("Created new record\n");
            record.data.p_data = info;
            record.data.length_words = sizeof(snow_slave_measurement_series_info_t) / sizeof(uint32_t) + (sizeof(snow_slave_measurement_series_info_t) % sizeof(uint8_t) ? 1 : 0);
            
            // Write measurement series info record
            do {
                rc = fds_record_write(&desc, &record);
            } while (rc == FDS_ERR_NO_SPACE_IN_QUEUES); 

            // Write measurements
            for (int i = 0; i < info->num_measurements; i++) {
                record.data.p_data = &ms[i];
                record.data.length_words = sizeof(snow_slave_measurement_t) / sizeof(uint32_t) + (sizeof(snow_slave_measurement_t) % sizeof(uint8_t) ? 1 : 0);
                
                do {
                    rc = fds_record_write(&desc, &record);
                } while (rc == FDS_ERR_NO_SPACE_IN_QUEUES); 
            }
        } else {
            return FDS_ERR_NOT_FOUND;
        }

        fds_gc();
        fds_update_stat();
        return NRF_SUCCESS;
    } else {     
        rc = fds_record_find(FDS_ID_MEASUREMENT, record.key, &desc, &tok);
        if (rc == NRF_SUCCESS) {
            //printf("Updating existing record\n");
            // Existing record found. Update.
            record.data.p_data = info;
            record.data.length_words = sizeof(snow_slave_measurement_series_info_t) / sizeof(uint32_t) + (sizeof(snow_slave_measurement_series_info_t) % sizeof(uint8_t) ? 1 : 0);
            do {
                rc = fds_record_update(&desc, &record);
            } while (rc == FDS_ERR_NO_SPACE_IN_QUEUES); 

            for (int i = 0; i < info->num_measurements; i++) {
                record.data.p_data = &ms[i];
                record.data.length_words = sizeof(snow_slave_measurement_t) / sizeof(uint32_t) + (sizeof(snow_slave_measurement_t) % sizeof(uint8_t) ? 1 : 0);
                
                rc = fds_record_find(FDS_ID_MEASUREMENT, record.key, &desc, &tok);
                if (rc == FDS_ERR_NOT_FOUND) 
                    return FDS_ERR_NOT_FOUND;
                
                do {
                    rc = fds_record_update(&desc, &record);
                } while (rc == FDS_ERR_NO_SPACE_IN_QUEUES); 
            }
            
            fds_gc();
            fds_update_stat();
            return NRF_SUCCESS;
        } else {
            return rc;
        }
    }   
}


uint16_t snow_slave_fds_get_first_free_key(uint16_t file_id) {
    uint16_t key_counter = FDS_KEY_OFFSET + 1;
    fds_record_desc_t desc = {0};
    fds_find_token_t tok = {0};
    
    ret_code_t rc = fds_record_find(FDS_ID_MEASUREMENT, key_counter, &desc, &tok);
    while (rc == NRF_SUCCESS)  {
        key_counter++;
        if (key_counter > 100) 
            return 0;

        rc = fds_record_find(FDS_ID_MEASUREMENT, key_counter, &desc, &tok);
    }

    //printf("Found free record key: %d\n", key_counter);
    
    return key_counter;
}



ret_code_t snow_slave_fds_load_measurement_series_by_meas_id(uint16_t meas_id, snow_slave_measurement_series_t* mss) {
    snow_slave_measurement_series_info_t* info = &mss->info;
    snow_slave_measurement_t* ms = mss->measurements;

    fds_record_t record;

    ret_code_t rc;
    fds_record_desc_t desc = {0};
    fds_find_token_t tok = {0};
    uint16_t key = meas_id + FDS_KEY_OFFSET;

    rc = fds_record_find(FDS_ID_MEASUREMENT, key, &desc, &tok);
    if (rc == NRF_SUCCESS) {
        printf("Loading existent record\n");
        fds_record_open(&desc, &record);
        memcpy(info, record.data.p_data, sizeof(snow_slave_measurement_series_info_t));
        fds_record_close(&desc);

        uint8_t i = 0;
        while (fds_record_find(FDS_ID_MEASUREMENT, key, &desc, &tok) == NRF_SUCCESS) {
            fds_record_open(&desc, &record);
            memcpy(&ms[i], record.data.p_data, sizeof(snow_slave_measurement_t));
            fds_record_close(&desc);
            i++;
        }

        return rc;
    } else {
        return rc;
    }
}


ret_code_t snow_slave_fds_load_measurement_series_by_name(uint8_t* name, uint8_t len, snow_slave_measurement_series_t* mss) {
    fds_record_t record;

    ret_code_t rc;
    fds_record_desc_t desc = {0};
    fds_find_token_t tok = {0};
    uint16_t key = FDS_KEY_OFFSET + 1;

    snow_slave_measurement_series_info_t info;

    // Check first record
    rc = fds_record_find(FDS_ID_MEASUREMENT, key, &desc, &tok);
    while (rc == NRF_SUCCESS) {
        // Record exists. Extract info
        fds_record_open(&desc, &record);
        memcpy(&info, record.data.p_data, sizeof(snow_slave_measurement_series_info_t));
        fds_record_close(&desc);
   
        if (memcmp(info.name, name, len) == 0) {
            // Search name and measurement series name match. Load.
            //printf("Record found by name\n");
            snow_slave_fds_load_measurement_series_by_meas_id(key - FDS_KEY_OFFSET, mss);
            return NRF_SUCCESS;
        }
        
        // Not found yet. Keep looking.
        key++;
        fds_find_token_t tok2 = {0};
        rc = fds_record_find(FDS_ID_MEASUREMENT, key, &desc, &tok2);
    } 
}


ret_code_t snow_slave_fds_delete_measurement_series_by_meas_id(uint16_t meas_id, snow_slave_measurement_series_t* mss) {

}


ret_code_t snow_slave_fds_delete_measurement_series_by_name(uint8_t* name, uint8_t len, snow_slave_measurement_series_t* mss) {

}



void fds_update_stat() {
    ret_code_t err_code;
    err_code = fds_stat(&m_fds_stat);
}


void fds_evt_handler(fds_evt_t const * ev) {
    switch (ev->id) {
        case FDS_EVT_INIT: {
            m_fds_intialized = ev->result == NRF_SUCCESS;
        } break;
        case FDS_EVT_WRITE: {
            if (ev->result == NRF_SUCCESS) {
                NRF_LOG_INFO("Record ID:\t0x%04x",  ev->write.record_id);
                NRF_LOG_INFO("File ID:\t0x%04x",    ev->write.file_id);
                NRF_LOG_INFO("Record key:\t0x%04x", ev->write.record_key);              
            }
        } break;

        case FDS_EVT_DEL_RECORD: {
            if (ev->result == NRF_SUCCESS) {
                NRF_LOG_INFO("Record ID:\t0x%04x",  ev->del.record_id);
                NRF_LOG_INFO("File ID:\t0x%04x",    ev->del.file_id);
                NRF_LOG_INFO("Record key:\t0x%04x", ev->del.record_key);
            }
        } break;

        case FDS_EVT_GC : { 
            if (ev->result == NRF_SUCCESS) {
                m_flag_gc = true;
                NRF_LOG_INFO("GC_Fertig",  ev->del.record_id);
            }
        } break;
    }
}


fds_stat_t* get_fds_stat() {
    return &m_fds_stat;
}