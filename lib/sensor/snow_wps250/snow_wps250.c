#include "nrf_drv_saadc.h"
#include "snow_wps250.h"


void snow_wps250_init(uint8_t adc_channel) {
    nrf_saadc_channel_config_t channel_config = NRFX_SAADC_DEFAULT_CHANNEL_CONFIG_SE(adc_channel);
    nrfx_saadc_channel_init(0, &channel_config);
}


void snow_wps250_voltage(float* voltage) {
    nrf_saadc_value_t adc_val;
    nrfx_saadc_sample_convert(0, &adc_val);
    *voltage = adc_val * 3.6f / 1024 - ADC_VOLTAGE_OFFSET;
    //printf("Voltage: %f\n", *voltage);
}


void snow_wps250_displacement(float* displacement) {
    float voltage;
    snow_wps250_voltage(&voltage);

    float dp = voltage / WPS250_VOLTS_PER_MM;

    if (dp < 1) dp = 0;
    if (dp > 249.75f) dp = 250;

    *displacement = dp;
}