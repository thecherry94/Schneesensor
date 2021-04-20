#ifndef SNOW_WPS250_H
#define SNOW_WPS250_H

#define ADC_VOLTAGE_MAX_DISPLACEMENT  3.15f
#define ADC_VOLTAGE_OFFSET            0.07f
#define WPS250_MAX_DISPLACEMENT_MM    250.0f
#define WPS250_VOLTS_PER_MM           (ADC_VOLTAGE_MAX_DISPLACEMENT / WPS250_MAX_DISPLACEMENT_MM)

void snow_wps250_init(uint8_t adc_channel);
void snow_wps250_voltage(float* voltage);
void snow_wps250_displacement(float* displacement);

#endif