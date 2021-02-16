/*
 * Driver library for the adxl362 accelerometer 
 * Snowstorm project
 * Author: Philipp Kirsch
 *
 */ 




#ifndef SNOW_ADXL362_H
#define SNOW_ADXL362_H


#include "nrf_drv_spi.h"
#include "app_error.h"
#include "app_util_platform.h"
#include "nrf_delay.h"

#include "snow_adxl362_defs.h"


typedef uint8_t snow_adxl362_ret_code_t;
typedef uint8_t snow_adxl362_self_test_t;
typedef snow_adxl362_ret_code_t (*snow_adxl362_spi_transfer_t)(uint8_t* tx_buf, uint8_t tx_len, uint8_t* rx_buf, uint8_t rx_len, uint8_t cs_pin);


// STRUCTS
//

// Struct using to write/read sensor configuration
//
typedef struct snow_adxl362_config_t {

    // Control registers
    uint8_t filter_control;
    uint8_t power_control;
    uint8_t activity_control;
    uint8_t fifo_control;
    uint8_t intmap1;
    uint8_t intmap2;

    // Motion threshold registers
    uint16_t threshold_active;
    uint16_t threshold_inactive;
    
    // Timing registers
    uint8_t  time_active;
    uint16_t time_inactive;
    
} snow_adxl362_config_t;



typedef struct snow_adxl362_device {
    uint8_t cs_pin;
    struct snow_adxl362_config_t cfg;
    float scale_factor;
    bool initialized;
} snow_adxl362_device;


// Struct holding the measurement values in g
//
typedef struct snow_accl_xyz_t {
    float x;
    float y;
    float z;
} snow_accl_xyz_t;








// FUNCTIONS
//


// Transfer function
snow_adxl362_ret_code_t nrf_spi_transfer(uint8_t* tx_buf, uint8_t tx_len, uint8_t* rx_buf, uint8_t rx_len, uint8_t cs_pin);


snow_adxl362_ret_code_t snow_adxl362_init(snow_adxl362_device* adxl_device, nrf_drv_spi_t* spi_instance, snow_adxl362_spi_transfer_t spi_transfer_func_ptr);
snow_adxl362_ret_code_t snow_adxl362_configure(snow_adxl362_device* adxl_device, bool check_config);
snow_adxl362_ret_code_t snow_adxl362_read_accl(snow_adxl362_device* adxl_device, snow_accl_xyz_t* accl);
snow_adxl362_ret_code_t snow_adxl362_read_temp(snow_adxl362_device* adxl_device, float* temp);
snow_adxl362_ret_code_t snow_adxl362_read_config(snow_adxl362_device* adxl_device, snow_adxl362_config_t* cfg);
snow_adxl362_ret_code_t snow_adxl362_soft_reset(snow_adxl362_device* adxl_device, bool wait_recommended);
snow_adxl362_ret_code_t snow_adxl362_perform_self_test(snow_adxl362_device* adxl_device, snow_adxl362_self_test_t* result, uint8_t samples);
snow_adxl362_ret_code_t snow_adxl362_write_reg(snow_adxl362_device* adxl_device, uint8_t reg_addr, uint8_t reg_val);


struct snow_adxl362_device snow_adxl362_create_device(uint8_t cs_pin, snow_adxl362_config_t* user_cfg);


snow_adxl362_ret_code_t nrf_spi_transfer(uint8_t* tx_buf, uint8_t tx_len, uint8_t* rx_buf, uint8_t rx_len, uint8_t cs_pin);



#endif