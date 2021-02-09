#ifndef SNOW_ADXL362_H
#define SNOW_ADXL362_H


#include "nrf_drv_spi.h"
#include "app_error.h"
#include "app_util_platform.h"
#include "nrf_delay.h"

#include "snow_adxl362_defs.h"


typedef uint8_t snow_adxl362_ret_code_t
typedef snow_adxl362_ret_code_t (*snow_adxl362_spi_transfer_t)(uint8_t* tx_buf, uint8_t tx_len, uint8_t* rx_buf, uint8_t rx_len);


// STRUCTS
//

// Struct holding the measurement values in g
//
typedef struct snow_accl_xyz_t {
    float x;
    float y;
    float z;
} accl_xyz_t;


// Struct using to write/read sensor configuration
//
typedef struct snow_adxl362_config_t {
    
} snow_adxl362_config_t;





// FUNCTIONS
//



snow_adxl362_ret_code_t snow_adxl362_init(nrf_drv_spi_t* spi_instance, snow_adxl362_spi_transfer_t spi_transfer_func_ptr);
snow_adxl362_ret_code_t snow_adxl362_configure(snow_adxl362_config_t* cfg);
snow_adxl362_ret_code_t snow_adxl362_read_accl(accl_xyz_t* accl);
snow_adxl362_ret_code_t snow_adxl362_soft_reset(bool wait_recommended);




#endif