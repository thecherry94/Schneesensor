#ifndef SNOW_BME680
#define SNOW_BME680


#include "nrf_drv_twi.h"
#include "bme680_defs.h"
#include "bme680.h"



// Sensor general configuration settings
#define SNOW_BME680_ADDR      BME680_I2C_ADDR_PRIMARY
#define SNOW_BME680_INTF      BME680_I2C_INTF



// Sensor measurement default configuration settings
#define SNOW_BME680_OS_HUM    BME680_OS_2X;
#define SNOW_BME680_OS_PRES   BME680_OS_4X;
#define SNOW_BME680_OS_TEMP   BME680_OS_8X;
#define SNOW_BME680_FILTER    BME680_FILTER_SIZE_3;

#define SNOW_BME680_RUN_GAS   BME680_ENABLE_GAS_MEAS;
#define SNOW_BME680_HEAT_RAMP 100
#define SNOW_BME680_HEAT_DUR  150

#define SNOW_BME680_PWR_MODE  BME680_FORCED_MODE;
#define SNOW_BME680_REQ_SET   BME680_OST_SEL | BME680_OSP_SEL | BME680_OSH_SEL | BME680_FILTER_SEL | BME680_GAS_SENSOR_SEL



typedef struct snow_bme680_device {
    struct bme680_dev device;
    uint16_t meas_period;
} snow_bme680_device;



static int8_t bme680_i2c_read(uint8_t dev_id, uint8_t reg_addr, uint8_t *reg_data, uint16_t len);
static int8_t bme680_i2c_write(uint8_t dev_id, uint8_t reg_addr, uint8_t *reg_data, uint16_t len);

int8_t snow_bme680_init(struct snow_bme680_device* snow_bme_device, const nrf_drv_twi_t*, int8_t);
int8_t snow_bme680_configure(struct snow_bme680_device* snow_bme_device, uint16_t* meas_period);

int8_t snow_bme680_measure(struct snow_bme680_device* snow_bme_device, struct bme680_field_data* data, bool wait);

#endif