#ifndef SNOW_ADXL362_DEFS_H
#define SNOW_ADXL362_DEFS_H

// Commands
//
#define SNOW_ADXL362_WRITE        0xA
#define SNOW_ADXL362_READ         0xB


// Registers
//
#define SNOW_ADXL362_REG_RESET        0x1F
#define SNOW_ADXL362_REG_X_LSB        0x0E
#define SNOW_ADXL362_REG_DEVICE_ID    0x00
#define SNOW_ADXL362_REG_MEMS_ID      0x01
#define SNOW_ADXL362_REG_PART_ID      0x02
#define SNOW_ADXL362_REG_REVISION_ID  0x03


// Specific Register values
//
#define SNOW_ADXL362_VAL_RESET        0x52
#define SNOW_ADXL362_VAL_DEVICE_ID    0xAD
#define SNOW_ADXL362_VAL_MEMS_ID      0x1D
#define SNOW_ADXL362_VAL_PART_ID      0xF2
#define SNOW_ADXL362_VAL_REVISION_ID  0x01




// Status messages/Errors/Warnings
//
#define SNOW_ADXL362_OK                     0
#define SNOW_ADXL362_SPI_ERROR              1
#define SNOW_ADXL362_NULLPTR_ERROR          3
#define SNOW_ADXL362_NOT_INITIALIZED_ERROR  4



// Misc
#define SNOW_ADXL362_CS_PIN       23


#endif