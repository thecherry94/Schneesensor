#include "snow_adxl362.h"
#include "lib/module/spi_handler/spi_handler.h"
#include "nrf_drv_spi.h"
#include "nrf_gpio.h"
#include <stdio.h>


nrf_drv_spi_t*                m_spi = NULL;
snow_spi_transfer_t           m_spi_transfer_func = NULL;



bool inRange(float low, float high, float x) 
{ 
    return ((x-high)*(x-low) <= 0); 
} 


snow_adxl362_ret_code_t snow_adxl362_init(snow_adxl362_device* adxl_device, nrf_drv_spi_t* spi_instance, snow_adxl362_spi_transfer_t spi_transfer_func_ptr) {
    if (spi_instance == NULL || spi_transfer_func_ptr == NULL)
        return SNOW_ADXL362_NULLPTR_ERROR;

    nrf_gpio_cfg_output(adxl_device->cs_pin);
    nrf_gpio_pin_set(adxl_device->cs_pin);
    
    if (m_spi == NULL)
        m_spi = spi_instance;

    if (m_spi_transfer_func == NULL)
        m_spi_transfer_func = spi_transfer_func_ptr;

    // Perform a read of some constant registers set by the manufacturer as a test
    //
    uint8_t tx_buf[] = { SNOW_ADXL362_READ, SNOW_ADXL362_REG_DEVICE_ID };
    uint8_t rx_buf[6] = {0};

    snow_adxl362_ret_code_t err_code = m_spi_transfer_func(tx_buf, sizeof(tx_buf), rx_buf, sizeof(rx_buf), adxl_device->cs_pin);
    
    adxl_device->initialized = err_code == SNOW_ADXL362_OK;

    return err_code;
}


// This function configures the entire configurable sensor registers
//
snow_adxl362_ret_code_t snow_adxl362_configure(snow_adxl362_device* adxl_device, bool check_config) {
    if (!adxl_device->initialized)
        return SNOW_ADXL362_NOT_INITIALIZED_ERROR;

    snow_adxl362_config_t* cfg = &adxl_device->cfg;

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
    snow_adxl362_ret_code_t err_code = m_spi_transfer_func(tx_buf_write_cfg, SNOW_ADXL362_CFG_BUF_SIZE, NULL, 0, adxl_device->cs_pin);

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
        snow_adxl362_ret_code_t err_code = m_spi_transfer_func(tx_buf_read_cfg, 2, rx_buf_read_cfg, SNOW_ADXL362_CFG_BUF_SIZE, adxl_device->cs_pin);

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
            adxl_device->scale_factor = SNOW_ADXL362_SCALE_FACTOR_2G;
            break;
        
        case SNOW_ADXL362_VAL_FILTER_SENS_4G:
            adxl_device->scale_factor = SNOW_ADXL362_SCALE_FACTOR_4G;
            break;
        
        case SNOW_ADXL362_VAL_FILTER_SENS_8G:
            adxl_device->scale_factor = SNOW_ADXL362_SCALE_FACTOR_8G;
            break;
    }

    // Everything OK
    return SNOW_ADXL362_OK;
}


snow_adxl362_ret_code_t snow_adxl362_read_config(snow_adxl362_device* adxl_device, snow_adxl362_config_t* cfg) {
    if (!adxl_device->initialized)
        return SNOW_ADXL362_NOT_INITIALIZED_ERROR;

    // Begin read from first configuration register and perform a burst read
    uint8_t tx_buf[] = {
        SNOW_ADXL362_READ,
        SNOW_ADXL362_REG_THRESH_ACT_LSB
    };
  
    // cfg read buffer
    uint8_t rx_buf[SNOW_ADXL362_CFG_BUF_SIZE] = {0};
    
    // Read configuration from sensor
    snow_adxl362_ret_code_t err_code = m_spi_transfer_func(tx_buf, 2, rx_buf, SNOW_ADXL362_CFG_BUF_SIZE, adxl_device->cs_pin);

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
snow_adxl362_ret_code_t snow_adxl362_soft_reset(snow_adxl362_device* adxl_device, bool wait_recommended) {
    // Write reset value in reset register
    uint8_t tx_buf[] = { 
        SNOW_ADXL362_WRITE, 
        SNOW_ADXL362_REG_RESET, 
        SNOW_ADXL362_VAL_RESET
    };
    
    snow_adxl362_ret_code_t err_code = m_spi_transfer_func(tx_buf, sizeof(tx_buf), NULL, 0, adxl_device->cs_pin);

    if (wait_recommended)
        nrf_delay_ms(1);

    return err_code;
}



snow_adxl362_ret_code_t snow_adxl362_read_accl(snow_adxl362_device* adxl_device, snow_accl_xyz_t* accl) {
    if (!adxl_device->initialized)
        return SNOW_ADXL362_NOT_INITIALIZED_ERROR;

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

    snow_adxl362_ret_code_t err_code = m_spi_transfer_func(tx_buf, 8, rx_buf, 8, adxl_device->cs_pin);

    uint16_t x;
    uint16_t y;
    uint16_t z;
    
    // Construct 12-bit sensor values according to ADXL362 Datasheet page 26
    x = (rx_buf[3] << 8) | rx_buf[2];
    y = (rx_buf[5] << 8) | rx_buf[4];
    z = (rx_buf[7] << 8) | rx_buf[6]; 

    // Copy the bit values one-by-one instead of uint->float value conversion
    accl->x = *((int16_t*)&x) * adxl_device->scale_factor;
    accl->y = *((int16_t*)&y) * adxl_device->scale_factor;
    accl->z = *((int16_t*)&z) * adxl_device->scale_factor;

    return err_code;
}


snow_adxl362_ret_code_t snow_adxl362_read_temp(snow_adxl362_device* adxl_device, float* temp) {
    if (!adxl_device->initialized)
        return SNOW_ADXL362_NOT_INITIALIZED_ERROR;

    uint8_t tx_buf[] = {
        SNOW_ADXL362_READ,
        SNOW_ADXL362_REG_TEMPERATURE_LSB
    };

    uint8_t rx_buf[4] = {0};

    snow_adxl362_ret_code_t err_code = m_spi_transfer_func(tx_buf, 2, rx_buf, 4, adxl_device->cs_pin);

    uint16_t rx_temp = (rx_buf[3] << 8) | rx_buf[2];
    *temp = *((int16_t*)&rx_temp) * 0.065f;

    return err_code;
}


// Sensor self test according to datasheet page 41
//
snow_adxl362_ret_code_t snow_adxl362_perform_self_test(snow_adxl362_device* adxl_device, snow_adxl362_self_test_t* result, uint8_t samples) {
    if (!adxl_device->initialized)
        return SNOW_ADXL362_NOT_INITIALIZED_ERROR;

    snow_adxl362_device old_device= *adxl_device;
    *result = 0;

    adxl_device->cfg.filter_control = SNOW_ADXL362_VAL_FILTER_ODR_100 | SNOW_ADXL362_VAL_FILTER_SENS_8G;
    snow_adxl362_ret_code_t err_code = snow_adxl362_configure(adxl_device, false);

    float x = 0;
    float y = 0;
    float z = 0;

    for (uint8_t i = 0; i < samples; i++) {
        snow_accl_xyz_t accl1 = {0};
        err_code = snow_adxl362_read_accl(adxl_device, &accl1);

        err_code = snow_adxl362_write_reg(adxl_device, SNOW_ADXL362_REG_SELF_TEST, 0x01);
        nrf_delay_ms(40);

        snow_accl_xyz_t accl2 = {0};
        err_code = snow_adxl362_read_accl(adxl_device, &accl2);
  
        x += accl2.x - accl1.x;
        y += accl2.y - accl1.y;
        z += accl2.z - accl1.z;

        err_code = snow_adxl362_write_reg(adxl_device, SNOW_ADXL362_REG_SELF_TEST, 0x00);

        nrf_delay_ms(10);
    }

    x /= samples;
    y /= samples;
    z /= samples;

    *result |= inRange(0.2f, 2.8f, x) ? SNOW_ADXL362_SELF_TEST_X_OK : 0;
    *result |= inRange(-2.8f, -0.2f, y) ? SNOW_ADXL362_SELF_TEST_Y_OK : 0;
    *result |= inRange(0.2f, 2.8f, z) ? SNOW_ADXL362_SELF_TEST_Z_OK : 0;

    

    *adxl_device = old_device;
    err_code = snow_adxl362_configure(adxl_device, false);

    return SNOW_ADXL362_OK;
}



snow_adxl362_ret_code_t snow_adxl362_write_reg(snow_adxl362_device* adxl_device, uint8_t reg_addr, uint8_t reg_val) {
    uint8_t tx_buf[] = {
        SNOW_ADXL362_WRITE,
        reg_addr,
        reg_val
    };

    return nrf_spi_transfer(tx_buf, sizeof(tx_buf), NULL, 0, adxl_device->cs_pin);
}


struct snow_adxl362_device snow_adxl362_create_device(uint8_t cs_pin, snow_adxl362_config_t* user_cfg) {
    snow_adxl362_device device;
    
    snow_adxl362_config_t default_cfg = {
        .filter_control = 
        SNOW_ADXL362_VAL_FILTER_ODR_100 | 
        SNOW_ADXL362_VAL_FILTER_EXT_SAMPLE_OFF | 
        SNOW_ADXL362_VAL_FILTER_BW_HALF | 
        SNOW_ADXL362_VAL_FILTER_SENS_2G,

        .power_control = 
        SNOW_ADXL362_VAL_PWR_MEASURE |
        SNOW_ADXL362_VAL_PWR_AUTOSLEEP_OFF |
        SNOW_ADXL362_VAL_PWR_WAKEUP_OFF | 
        SNOW_ADXL362_VAL_PWR_NOISE_NORMAL | 
        SNOW_ADXL362_VAL_PWR_EXT_CLOCK_OFF,

        .activity_control = 
        SNOW_ADXL362_VAL_ACT_ACT_EN_OFF |
        SNOW_ADXL362_VAL_ACT_REF_OFF | 
        SNOW_ADXL362_VAL_ACT_INACT_OFF |
        SNOW_ADXL362_VAL_ACT_INACT_REF_OFF | 
        SNOW_ADXL362_VAL_ACT_LL_DEFAULT,

        .fifo_control = 
        SNOW_ADXL362_VAL_FIFO_DISABLED |
        SNOW_ADXL362_VAL_FIFO_TEMP_OFF | 
        SNOW_ADXL362_VAL_FIFO_ABOVE_HALF_OFF,

        .intmap1 = 
        SNOW_ADXL362_VAL_INTMAP_DATA_READY_OFF |
        SNOW_ADXL362_VAL_INTMAP_FIFO_READY_OFF |
        SNOW_ADXL362_VAL_INTMAP_FIFO_WM_OFF |
        SNOW_ADXL362_VAL_INTMAP_FIFO_OV_OFF |
        SNOW_ADXL362_VAL_INTMAP_ACTIVITY_OFF |
        SNOW_ADXL362_VAL_INTMAP_INACTIVITY_OFF |
        SNOW_ADXL362_VAL_INTMAP_AWAKE_OFF |
        SNOW_ADXL362_VAL_INTMAP_ACTIVE_LOW_OFF,

        .intmap2 = 
        SNOW_ADXL362_VAL_INTMAP_DATA_READY_OFF |
        SNOW_ADXL362_VAL_INTMAP_FIFO_READY_OFF |
        SNOW_ADXL362_VAL_INTMAP_FIFO_WM_OFF |
        SNOW_ADXL362_VAL_INTMAP_FIFO_OV_OFF |
        SNOW_ADXL362_VAL_INTMAP_ACTIVITY_OFF |
        SNOW_ADXL362_VAL_INTMAP_INACTIVITY_OFF |
        SNOW_ADXL362_VAL_INTMAP_AWAKE_OFF |
        SNOW_ADXL362_VAL_INTMAP_ACTIVE_LOW_OFF,
        
        .threshold_active = 0x6D,

        .time_active = 0x00,

        .threshold_inactive = 0x6D,

        .time_inactive = 0x00
    };

    device.cfg = user_cfg == NULL ? default_cfg : *user_cfg;
    device.cs_pin = cs_pin;
    device.initialized = false;
    device.scale_factor = 0;

    return device;
}

snow_adxl362_ret_code_t nrf_spi_transfer(uint8_t* tx_buf, uint8_t tx_len, uint8_t* rx_buf, uint8_t rx_len, uint8_t cs_pin) {
    nrf_gpio_pin_clear(cs_pin);
    ret_code_t err_code = nrf_drv_spi_transfer(&m_spi, tx_buf, tx_len, rx_buf, rx_len);
    nrf_gpio_pin_set(cs_pin);

    return err_code == NRF_SUCCESS ? SNOW_ADXL362_OK : SNOW_ADXL362_SPI_ERROR;
}


/*struct snow_adxl362_device snow_adxl362_create_device(snow_adxl362_config_t* cfg) {

}
*/