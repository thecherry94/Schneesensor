#include "snow_adxl362.h"
#include "nrf_drv_spi.h"
#include "nrf_gpio.h"
#include <stdio.h>


nrf_drv_spi_t*                m_spi;
snow_adxl362_spi_transfer_t   m_spi_transfer_func;
uint8_t                       m_last_command;
bool                          m_initialized = false;
float                         m_scale_factor = 0.001f;
snow_adxl362_config_t         m_cfg;



bool inRange(float low, float high, float x) 
{ 
    return ((x-high)*(x-low) <= 0); 
} 


snow_adxl362_ret_code_t snow_adxl362_init(nrf_drv_spi_t* spi_instance, snow_adxl362_spi_transfer_t spi_transfer_func_ptr) {
    if (spi_instance == NULL || spi_transfer_func_ptr == NULL)
        return SNOW_ADXL362_NULLPTR_ERROR;
    
    m_spi = spi_instance;
    m_spi_transfer_func = spi_transfer_func_ptr;

    // Perform a read of some constant registers set by the manufacturer as a test
    //
    uint8_t tx_buf[] = { SNOW_ADXL362_READ, SNOW_ADXL362_REG_DEVICE_ID };
    uint8_t rx_buf[6] = {0};

    snow_adxl362_ret_code_t err_code = m_spi_transfer_func(tx_buf, sizeof(tx_buf), rx_buf, sizeof(rx_buf));
    
    m_initialized = err_code == SNOW_ADXL362_OK;

    return err_code;
}


// This function configures the entire configurable sensor registers
//
snow_adxl362_ret_code_t snow_adxl362_configure(snow_adxl362_config_t* cfg, bool check_config) {
    if (!m_initialized)
        return SNOW_ADXL362_NOT_INITIALIZED_ERROR;

    // Feed values into the transfer buffer with a burst write
    //
    uint8_t tx_buf_write_cfg[] = {
        SNOW_ADXL362_WRITE,
        SNOW_ADXL362_REG_THRESH_ACT_LSB,

        cfg->threshold_active & 0x0F,
        (cfg->threshold_active >> 8) & 0x07,

        cfg->time_active,

        cfg->threshold_inactive & 0x0F,
        (cfg->threshold_inactive >> 8) & 0x07,

        cfg->time_inactive & 0x0F,
        cfg->time_inactive & 0xF0,

        cfg->activity_control,

        cfg->fifo_control,
        0x00,

        cfg->intmap1,
        cfg->intmap2,

        cfg->filter_control,

        cfg->power_control
    };

    // Transfer configuration to sensor
    snow_adxl362_ret_code_t err_code = m_spi_transfer_func(tx_buf_write_cfg, SNOW_ADXL362_CFG_BUF_SIZE, NULL, 0);

    // Check SPI status
    if (err_code != SNOW_ADXL362_OK)
        return err_code;
    
    // Perform a check if the configuration on the sensor is identical with the values sent
    if (check_config) {
       // Begin read from first configuration register and perform a burst read
        uint8_t tx_buf_read_cfg[] = {
            SNOW_ADXL362_READ,
            SNOW_ADXL362_REG_THRESH_ACT_LSB
        };
      
        // cfg read buffer
        uint8_t rx_buf_read_cfg[SNOW_ADXL362_CFG_BUF_SIZE] = {0};
        
        // Read configuration from sensor
        snow_adxl362_ret_code_t err_code = m_spi_transfer_func(tx_buf_read_cfg, 2, rx_buf_read_cfg, SNOW_ADXL362_CFG_BUF_SIZE);

        // Check SPI status
        if (err_code != SNOW_ADXL362_OK)
            return err_code;
        
        // Compare write buffer and read buffer 
        if (memcmp(tx_buf_write_cfg+2, rx_buf_read_cfg+2, SNOW_ADXL362_CFG_BUF_SIZE-2) != 0) 
            return SNOW_ADXL362_CONFIGURATION_ERROR;
    }

    // Apply g-force value scale factor according to sensitivity settings
    switch(cfg->filter_control & 0x120) {
        case SNOW_ADXL362_VAL_FILTER_SENS_2G:
            m_scale_factor = SNOW_ADXL362_SCALE_FACTOR_2G;
            break;
        
        case SNOW_ADXL362_VAL_FILTER_SENS_4G:
            m_scale_factor = SNOW_ADXL362_SCALE_FACTOR_4G;
            break;
        
        case SNOW_ADXL362_VAL_FILTER_SENS_8G:
            m_scale_factor = SNOW_ADXL362_SCALE_FACTOR_8G;
            break;
    }

    m_cfg = *cfg;

    // Everything OK
    return SNOW_ADXL362_OK;
}


snow_adxl362_ret_code_t snow_adxl362_read_config(snow_adxl362_config_t* cfg) {
    // Begin read from first configuration register and perform a burst read
    uint8_t tx_buf[] = {
        SNOW_ADXL362_READ,
        SNOW_ADXL362_REG_THRESH_ACT_LSB
    };
  
    // cfg read buffer
    uint8_t rx_buf[SNOW_ADXL362_CFG_BUF_SIZE] = {0};
    
    // Read configuration from sensor
    snow_adxl362_ret_code_t err_code = m_spi_transfer_func(tx_buf, 2, rx_buf, SNOW_ADXL362_CFG_BUF_SIZE);

    // Check SPI status
    if (err_code != SNOW_ADXL362_OK)
        return err_code;

    cfg->threshold_active = (rx_buf[3] << 8) | rx_buf[2];
    cfg->time_active = rx_buf[4];
    cfg->threshold_inactive = (rx_buf[6] << 8) | rx_buf[5];
    cfg->time_inactive = (rx_buf[8] << 8) | rx_buf[7];
    cfg->activity_control = rx_buf[9];
    cfg->fifo_control = rx_buf[10];
    cfg->intmap1 = rx_buf[12];
    cfg->intmap2 = rx_buf[13];
    cfg->filter_control = rx_buf[14];
    cfg->power_control = rx_buf[15];

    return SNOW_ADXL362_OK;
}



// Performs a soft reset of the adxl362
// A wait time of 0.5ms is recommended
// If wait_recommended is true the function waits for 1ms
//
snow_adxl362_ret_code_t snow_adxl362_soft_reset(bool wait_recommended) {
    // Write reset value in reset register
    uint8_t tx_buf[] = { 
        SNOW_ADXL362_WRITE, 
        SNOW_ADXL362_REG_RESET, 
        SNOW_ADXL362_VAL_RESET
    };
    
    snow_adxl362_ret_code_t err_code = m_spi_transfer_func(tx_buf, sizeof(tx_buf), NULL, 0);

    if (wait_recommended)
        nrf_delay_ms(1);

    return err_code;
}



snow_adxl362_ret_code_t snow_adxl362_read_accl(snow_accl_xyz_t* accl) {

    uint8_t tx_buf[] = {
        SNOW_ADXL362_READ,        // Command read
        SNOW_ADXL362_REG_X_LSB    // Burst read from X-Axis LSB Register to Z-Axis MSB Register
    };
    
    // rx_buf[0] <=> 0
    // rx_buf[1] <=> 0
    // rx_buf[2] <=> X LSB
    // rx_buf[3] <=> X MSB
    // rx_buf[4] <=> Y LSB
    // rx_buf[5] <=> Y MSB
    // rx_buf[6] <=> Z LSB
    // rx_buf[7] <=> Z MSB
    uint8_t rx_buf[8] = {0};

    snow_adxl362_ret_code_t err_code = m_spi_transfer_func(tx_buf, 8, rx_buf, 8);

    uint16_t x;
    uint16_t y;
    uint16_t z;
    
    // Construct 12-bit sensor values according to ADXL362 Datasheet page 26
    x = (rx_buf[3] << 8) | rx_buf[2];
    y = (rx_buf[5] << 8) | rx_buf[4];
    z = (rx_buf[7] << 8) | rx_buf[6]; 

    // Copy the bit values one-by-one instead of uint->float value conversion
    accl->x = *((int16_t*)&x) * m_scale_factor;
    accl->y = *((int16_t*)&y) * m_scale_factor;
    accl->z = *((int16_t*)&z) * m_scale_factor;

    return err_code;
}


snow_adxl362_ret_code_t snow_adxl362_read_temp(float* temp) {
    uint8_t tx_buf[] = {
        SNOW_ADXL362_READ,
        SNOW_ADXL362_REG_TEMPERATURE_LSB
    };

    uint8_t rx_buf[4] = {0};

    snow_adxl362_ret_code_t err_code = m_spi_transfer_func(tx_buf, 2, rx_buf, 4);

    uint16_t rx_temp = (rx_buf[3] << 8) | rx_buf[2];
    *temp = *((int16_t*)&rx_temp) * 0.065f;

    return err_code;
}


// Sensor self test according to datasheet page 41
//
snow_adxl362_ret_code_t snow_adxl362_perform_self_test(snow_adxl362_self_test_t* result, uint8_t samples) {
    snow_adxl362_config_t old_cfg = m_cfg;
    *result = 0;

    m_cfg.filter_control = SNOW_ADXL362_VAL_FILTER_ODR_100 | SNOW_ADXL362_VAL_FILTER_SENS_8G;
    snow_adxl362_ret_code_t err_code = snow_adxl362_configure(&m_cfg, false);

    float x = 0;
    float y = 0;
    float z = 0;

    for (uint8_t i = 0; i < samples; i++) {
        snow_accl_xyz_t accl1 = {0};
        err_code = snow_adxl362_read_accl(&accl1);

        err_code = snow_adxl362_write_reg(SNOW_ADXL362_REG_SELF_TEST, 0x01);
        nrf_delay_ms(40);

        snow_accl_xyz_t accl2 = {0};
        err_code = snow_adxl362_read_accl(&accl2);
  
        x += accl2.x - accl1.x;
        y += accl2.y - accl1.y;
        z += accl2.z - accl1.z;

        err_code = snow_adxl362_write_reg(SNOW_ADXL362_REG_SELF_TEST, 0x00);

        nrf_delay_ms(10);
    }

    x /= samples;
    y /= samples;
    z /= samples;

    *result = inRange(0.2f, 2.8f, x) ? SNOW_ADXL362_SELF_TEST_X_OK : 0;
    *result = inRange(-2.8f, -0.2f, y) ? SNOW_ADXL362_SELF_TEST_Y_OK : 0;
    *result = inRange(0.2f, 2.8f, z) ? SNOW_ADXL362_SELF_TEST_Z_OK : 0;

    

    m_cfg = old_cfg;
    err_code = snow_adxl362_configure(&m_cfg, false);

    return SNOW_ADXL362_OK;
}



snow_adxl362_ret_code_t snow_adxl362_write_reg(uint8_t reg_addr, uint8_t reg_val) {
    uint8_t tx_buf[] = {
        SNOW_ADXL362_WRITE,
        reg_addr,
        reg_val
    };

    return nrf_spi_transfer(tx_buf, sizeof(tx_buf), NULL, 0);
}

