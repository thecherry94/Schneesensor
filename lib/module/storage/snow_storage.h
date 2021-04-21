#ifndef SNOW_STORAGE_H
#define SNOW_STORAGE_H

#include "nrf_fstorage_sd.h"
#include "fds.h"
#include "snow_slave.h"


void fds_evt_handler(fds_evt_t const * ev);
void fds_update_stat();
fds_stat_t* get_fds_stat();

ret_code_t snow_slave_fds_save_measurement_series(snow_slave_measurement_series_t* mss);
ret_code_t snow_slave_fds_load_measurement_series_by_meas_id(uint16_t meas_id, snow_slave_measurement_series_t* mss);
ret_code_t snow_slave_fds_load_measurement_series_by_name(uint8_t* name, uint8_t len, snow_slave_measurement_series_t* mss);
uint16_t snow_slave_fds_get_first_free_key(uint16_t file_id);




#endif