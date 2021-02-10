#ifndef SNOW_ADXL362_DEFS_H
#define SNOW_ADXL362_DEFS_H

// Commands
//
#define SNOW_ADXL362_WRITE        0xA
#define SNOW_ADXL362_READ         0xB


// Register addresses
//

// Reset
#define SNOW_ADXL362_REG_RESET                  0x1F

// Device Status
#define SNOW_ADXL362_REG_STATUS                 0x0B

// Accelerometer Data
#define SNOW_ADXL362_REG_X_LSB                  0x0E
#define SNOW_ADXL362_REG_X_MSB                  0x0F
#define SNOW_ADXL362_REG_Y_LSB                  0x10
#define SNOW_ADXL362_REG_Y_MSB                  0x11
#define SNOW_ADXL362_REG_Z_LSB                  0x12
#define SNOW_ADXL362_REG_Z_MSB                  0x13

// Temperature Data
#define SNOW_ADXL362_REG_TEMPERATURE_LSB        0x14
#define SNOW_ADXL362_REG_TEMPERATURE_MSB        0x15

// Manufacturer Information
#define SNOW_ADXL362_REG_DEVICE_ID              0x00
#define SNOW_ADXL362_REG_MEMS_ID                0x01
#define SNOW_ADXL362_REG_PART_ID                0x02
#define SNOW_ADXL362_REG_REVISION_ID            0x03

// Control Registers
#define SNOW_ADXL362_REG_FILTER_CTL             0x2C
#define SNOW_ADXL362_REG_PWR_CTL                0x2D
#define SNOW_ADXL362_REG_INTMAP1                0x2A
#define SNOW_ADXL362_REG_INTMAP2                0x2B
#define SNOW_ADXL362_REG_ACTIVITY_CTL           0x27

// Threshold / Timing Registers
#define SNOW_ADXL362_REG_THRESH_ACT_LSB         0x20
#define SNOW_ADXL362_REG_THRESH_ACT_MSB         0x21
#define SNOW_ADXL362_REG_TIME_ACT               0x22
#define SNOW_ADXL362_REG_THRESH_INACT_LSB       0x23
#define SNOW_ADXL362_REG_THRESH_INACT_MSB       0x24
#define SNOW_ADXL362_REG_TIME_INACT_LSB         0x25
#define SNOW_ADXL362_REG_TIME_INACT_MSB         0x26

// FIFO Registers
#define SNOW_ADXL362_REG_FIFO_CTL               0x28
#define SNOW_ADXL362_REG_FIFO_SAMPLE            0x29
#define SNOW_ADXL362_REG_FIFO_ENTRIES_LSB       0x0C
#define SNOW_ADXL362_REG_FIFO_ENTRIES_MSB       0x0D




// Specific Register values
//
#define SNOW_ADXL362_VAL_RESET                  0x52
#define SNOW_ADXL362_VAL_DEVICE_ID              0xAD
#define SNOW_ADXL362_VAL_MEMS_ID                0x1D
#define SNOW_ADXL362_VAL_PART_ID                0xF2
#define SNOW_ADXL362_VAL_REVISION_ID            0x01

// Filter Control Register
#define SNOW_ADXL362_VAL_FILTER_ODR_12_5        0x00
#define SNOW_ADXL362_VAL_FILTER_ODR_25          0x01
#define SNOW_ADXL362_VAL_FILTER_ODR_50          0x02
#define SNOW_ADXL362_VAL_FILTER_ODR_100         0x03
#define SNOW_ADXL362_VAL_FILTER_ODR_200         0x04
#define SNOW_ADXL362_VAL_FILTER_ODR_400         0x05

#define SNOW_ADXL362_VAL_FILTER_EXT_SAMPLE_OFF  0x00
#define SNOW_ADXL362_VAL_FILTER_EXT_SAMPLE_ON   0x08

#define SNOW_ADXL362_VAL_FILTER_BW_HALF         0x00
#define SNOW_ADXL362_VAL_FILTER_BW_QUARTER      0x10

#define SNOW_ADXL362_VAL_FILTER_SENS_2G         0x00
#define SNOW_ADXL362_VAL_FILTER_SENS_4G         0x40
#define SNOW_ADXL362_VAL_FILTER_SENS_8G         0x80


// Power Control Register
#define SNOW_ADXL362_VAL_PWR_STANDBY            0x00
#define SNOW_ADXL362_VAL_PWR_MEASURE            0x02

#define SNOW_ADXL362_VAL_PWR_AUTOSLEEP_OFF      0x00
#define SNOW_ADXL362_VAL_PWR_AUTOSLEEP_ON       0x04

#define SNOW_ADXL362_VAL_PWR_WAKEUP_OFF         0x00
#define SNOW_ADXL362_VAL_PWR_WAKEUP_ON          0x08

#define SNOW_ADXL362_VAL_PWR_NOISE_NORMAL       0x00
#define SNOW_ADXL362_VAL_PWR_NOISE_LOW          0x10
#define SNOW_ADXL362_VAL_PWR_NOISE_ULTRA_LOW    0x20

#define SNOW_ADXL362_VAL_PWR_EXT_CLOCK_OFF      0x00
#define SNOW_ADXL362_VAL_PWR_EXT_CLOCK_ON       0x40


// Interrupt Map Register(s)
#define SNOW_ADXL362_VAL_INTMAP_DATA_READY_OFF  0x00
#define SNOW_ADXL362_VAL_INTMAP_DATA_READY_ON   0x01

#define SNOW_ADXL362_VAL_INTMAP_FIFO_READY_OFF  0x00
#define SNOW_ADXL362_VAL_INTMAP_FIFO_READY_ON   0x02

#define SNOW_ADXL362_VAL_INTMAP_FIFO_WM_OFF     0x00
#define SNOW_ADXL362_VAL_INTMAP_FIFO_WM_ON      0x04

#define SNOW_ADXL362_VAL_INTMAP_FIFO_OV_OFF     0x00
#define SNOW_ADXL362_VAL_INTMAP_FIFO_OV_ON      0x08

#define SNOW_ADXL362_VAL_INTMAP_ACTIVITY_OFF    0x00
#define SNOW_ADXL362_VAL_INTMAP_ACTIVITY_ON     0x10

#define SNOW_ADXL362_VAL_INTMAP_INACTIVITY_OFF  0x00
#define SNOW_ADXL362_VAL_INTMAP_INACTIVITY_ON   0x20

#define SNOW_ADXL362_VAL_INTMAP_AWAKE_OFF       0x00
#define SNOW_ADXL362_VAL_INTMAP_AWAKE_ON        0x40

#define SNOW_ADXL362_VAL_INTMAP_ACTIVE_LOW_OFF  0x00
#define SNOW_ADXL362_VAL_INTMAP_ACTIVE_LOW_ON   0x80


// Activity/Inactivity Register
#define SNOW_ADXL362_VAL_ACT_ACT_EN_OFF         0x00
#define SNOW_ADXL362_VAL_ACT_ACT_EN_ON          0x01

#define SNOW_ADXL362_VAL_ACT_REF_OFF            0x00
#define SNOW_ADXL362_VAL_ACT_REF_ON             0x02

#define SNOW_ADXL362_VAL_ACT_INACT_OFF          0x00
#define SNOW_ADXL362_VAL_ACT_INACT_ON           0x04

#define SNOW_ADXL362_VAL_ACT_INACT_REF_OFF      0x00
#define SNOW_ADXL362_VAL_ACT_INACT_REF_ON       0x08

#define SNOW_ADXL362_VAL_ACT_LL_DEFAULT         0x00
#define SNOW_ADXL362_VAL_ACT_LL_LINKED          0x10
#define SNOW_ADXL362_VAL_ACT_LL_LOOP            0x30




// Status messages/Errors/Warnings
//
#define SNOW_ADXL362_OK                     0
#define SNOW_ADXL362_SPI_ERROR              1
#define SNOW_ADXL362_NULLPTR_ERROR          3
#define SNOW_ADXL362_NOT_INITIALIZED_ERROR  4
#define SNOW_ADXL362_CONFIGURATION_ERROR    5



// Misc
#define SNOW_ADXL362_CS_PIN       23
#define SNOW_ADXL362_CFG_BUF_SIZE 15


#endif