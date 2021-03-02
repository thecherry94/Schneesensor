//
// Driver to communicate with UBLOX GNSS modules
// Only I²C communication is possible at this time
//


#ifndef SNOW_GPS_H
#define SNOW_GPS_H


#include "nrf_drv_twi.h"


//
// Defines
//

#define SNOW_GPS_DATA_BUFFER_SIZE           1024
#define SNOW_GPS_DATA_CHUNK_SIZE            128

// I²C addresses of modules
//
#define SNOW_GPS_I2C_ADDR                   0x42

// Register addresses
//
#define SNOW_GPS_REG_BYTES_AVAILABLE_LSB    0xFE
#define SNOW_GPS_REG_BYTES_AVAILABLE_MSB    0xFD
#define SNOW_GPS_REG_DATA                   0xFF


typedef struct snow_gps_device {
    uint8_t i2c_addr;
    bool initialized;
} snow_gps_device;


//
// Functions
//
uint8_t snow_gps_init(snow_gps_device* device, nrf_drv_twi_t* twi);
uint8_t snow_gps_get_position(snow_gps_device* device);
uint8_t snow_gps_send_custom_command(snow_gps_device* device, uint8_t* cmd);

uint8_t snow_gps_read_data(snow_gps_device* dev);
uint8_t snow_gps_on_data_read();
uint8_t snow_gps_process_nmea_line(uint8_t* line, uint8_t size);



//
// Callbacks
//



#endif