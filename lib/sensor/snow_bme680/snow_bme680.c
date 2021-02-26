#include "snow_bme680.h"

#include "nrf_delay.h"


static const nrf_drv_twi_t*    m_twi;
static uint16_t                meas_period;


int8_t snow_bme680_init(struct snow_bme680_device* snow_bme_device, const nrf_drv_twi_t* twi, int8_t amb_temp) {
    m_twi = twi;
    
    struct bme680_dev* bme_device = &snow_bme_device->device;

    bme_device->dev_id = SNOW_BME680_ADDR;
    bme_device->intf = SNOW_BME680_INTF;
    bme_device->read = &user_i2c_read;
    bme_device->write = &user_i2c_write;
    bme_device->delay_ms = nrf_delay_ms;

    bme_device->amb_temp = amb_temp;
    
    int8_t rslt = BME680_OK;
    rslt = bme680_init(bme_device);

    return rslt;
}



int8_t snow_bme680_configure(struct snow_bme680_device* snow_bme_device, uint16_t* meas_period) {
    uint16_t set_required_settings;
    struct bme680_dev* bme_device = &snow_bme_device->device;

    /* Set the temperature, pressure and humidity settings */
    bme_device->tph_sett.os_hum = SNOW_BME680_OS_HUM;
    bme_device->tph_sett.os_pres = SNOW_BME680_OS_PRES;
    bme_device->tph_sett.os_temp = SNOW_BME680_OS_TEMP;
    bme_device->tph_sett.filter = SNOW_BME680_FILTER;

    /* Set the remaining gas sensor settings and link the heating profile */
    bme_device->gas_sett.run_gas = SNOW_BME680_RUN_GAS;
    /* Create a ramp heat waveform in 3 steps */
    bme_device->gas_sett.heatr_temp = SNOW_BME680_HEAT_RAMP; /* degree Celsius */
    bme_device->gas_sett.heatr_dur = SNOW_BME680_HEAT_DUR; /* milliseconds */

    /* Select the power mode */
    /* Must be set before writing the sensor configuration */
    bme_device->power_mode = SNOW_BME680_PWR_MODE; 

    /* Set the required sensor settings needed */
    set_required_settings = SNOW_BME680_REQ_SET;

    /* Set the desired sensor configuration */
    int8_t result = bme680_set_sensor_settings(set_required_settings, bme_device);

    /* Set the power mode */
    result = bme680_set_sensor_mode(bme_device);

    if (result == BME680_OK) {
        bme680_get_profile_dur(meas_period, bme_device);
    }

    return result;
}


int8_t snow_bme680_measure(struct snow_bme680_device* snow_bme_device, struct bme680_field_data* data) {
    struct bme680_dev* bme_device = &snow_bme_device->device;
    
    int8_t result = bme680_get_sensor_data(data, bme_device);

    if (bme_device->power_mode == BME680_FORCED_MODE)
        bme680_set_sensor_mode(bme_device);
    
    return result;
}


static int8_t user_i2c_read(uint8_t dev_id, uint8_t reg_addr, uint8_t *reg_data, uint16_t len) {
    int8_t rslt = 0; /* Return 0 for Success, non-zero for failure */

    /*
     * The parameter dev_id can be used as a variable to store the I2C address of the device
     */

    /*
     * Data on the bus should be like
     * |------------+---------------------|
     * | I2C action | Data                |
     * |------------+---------------------|
     * | Start      | -                   |
     * | Write      | (reg_addr)          |
     * | Stop       | -                   |
     * | Start      | -                   |
     * | Read       | (reg_data[0])       |
     * | Read       | (....)              |
     * | Read       | (reg_data[len - 1]) |
     * | Stop       | -                   |
     * |------------+---------------------|
     */
    ret_code_t err_code = nrf_drv_twi_tx(m_twi, dev_id, &reg_addr, 1, false);
    err_code = nrf_drv_twi_rx(m_twi, dev_id, reg_data, len);
    return err_code;
}


static int8_t user_i2c_write(uint8_t dev_id, uint8_t reg_addr, uint8_t *reg_data, uint16_t len) {
    int8_t rslt = 0; /* Return 0 for Success, non-zero for failure */
    /*
     * The parameter dev_id can be used as a variable to store the I2C address of the device
     */

    /*
     * Data on the bus should be like
     * |------------+---------------------|
     * | I2C action | Data                |
     * |------------+---------------------|
     * | Start      | -                   |
     * | Write      | (reg_addr)          |
     * | Write      | (reg_data[0])       |
     * | Write      | (....)              |
     * | Write      | (reg_data[len - 1]) |
     * | Stop       | -                   |
     * |------------+---------------------|
     */

    uint8_t buf[32];
    buf[0]=reg_addr;

    for(int i=0;i<len;i++)
        buf[i+1]=reg_data[i];
    
    ret_code_t err_code = nrf_drv_twi_tx(m_twi, dev_id, buf, len+1, false);
    
    return err_code;
}