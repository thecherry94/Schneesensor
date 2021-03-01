//
// Driver to communicate with UBLOX GNSS modules
// Only I²C communication is possible at this time
//


#ifndef SNOW_GPS_H
#define SNOW_GPS_H


#include "nrf_drv_twi.h"

// Enum for package validity
typedef enum
{
	UBLOX_PACKET_VALIDITY_NOT_VALID,
	UBLOX_PACKET_VALIDITY_VALID,
	UBLOX_PACKET_VALIDITY_NOT_DEFINED,
	UBLOX_PACKET_NOTACKNOWLEDGED // This indicates that we received a NACK
} ublox_packet_validity_e;

typedef enum 
{
        NONE = 0,
        NMEA,
        UBX,
        RTCM
} ublox_sentence_type_e;


typedef enum
{
	UBLOX_PACKET_PACKETCFG,
	UBLOX_PACKET_PACKETACK,
	UBLOX_PACKET_PACKETBUF,
	UBLOX_PACKET_PACKETAUTO
} sfe_ublox_packet_buffer_e;


// Structure for gps device information
typedef struct snow_gps_device {
    uint8_t i2c_addr;
    bool initialized;
} snow_gps_device;


// Structure for a complete data packet
typedef struct ubx_packet {
    uint8_t cls;                                    // Class
    uint8_t id;                                     // Id
    uint16_t len;                                   // Total size
    uint16_t counter;                               // Helper variable for bytes received
    uint16_t;
    uint8_t* payload;                               // Data payload
    uint8_t chk_a;                                  // Checksum A
    uint8_t chk_b;                                  // Checksum B
    ublox_packet_validity_e valid;                  // State is set depending on checksum
    ublox_packet_validity_e cls_id_match;           // State is set depending on if the packet was expected
} ubx_packet;



typedef struct snow_gps_configuration {

} snow_gps_configuration;


//
// Defines
//

// I²C addresses of modules
//
#define SNOW_GPS_I2C_ADDR               0x42

// Register addresses
//
#define SNOW_GPS_REG_BYTES_AVAILABLE_LSB    0xFE
#define SNOW_GPS_REG_BYTES_AVAILABLE_MSB    0xFD
#define SNOW_GPS_REG_DATA                   0xFF

// Misc
//
#define SNOW_GPS_DATA_BUFFER_SIZE           128
#define UBLOX_BINARY_FLAG_1                 0xB5
#define UBLOX_BINARY_FLAG_2                 0x62


//
// Functions
//
uint8_t snow_gps_init(snow_gps_device* device, nrf_drv_twi_t* twi);
uint8_t snow_gps_get_position(snow_gps_device* device);
uint8_t snow_gps_configure(snow_gps_device* device, snow_gps_configuration* cfg);
uint8_t snow_gps_send_custom_command(snow_gps_device* device, ubx_packet* p);

uint8_t snow_gps_read_data(snow_gps_device* dev);

uint8_t snow_gps_feed_data(uint8_t cb);



//
// Callbacks
//



#endif