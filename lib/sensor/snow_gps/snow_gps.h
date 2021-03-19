//
// Driver to communicate with UBLOX GNSS modules
// Only I²C communication is possible at this time
//


// TODO
//

// TODO Primary
// - Implement UBX protocol (?) => partially implement most important configuration packets
// - Implement wake / sleep state
// - Implement error checks and error values everywhere
// - Implement a neat way for event handling and requesting packets

// TODO Secondary
// - Implement support for multiple modules running at the same time



#ifndef SNOW_GPS_H
#define SNOW_GPS_H


#include "nrf_drv_twi.h"
#include "minmea.h"


//
// Defines
//

#define SNOW_GPS_DATA_BUFFER_SIZE           1024
#define SNOW_GPS_DATA_CHUNK_SIZE            128
#define UBX_PCKG_MIN_LEN                    0x08

// I²C addresses of modules
//
#define SNOW_GPS_I2C_ADDR                   0x42

// Register addresses
//
#define SNOW_GPS_REG_BYTES_AVAILABLE_LSB    0xFE
#define SNOW_GPS_REG_BYTES_AVAILABLE_MSB    0xFD
#define SNOW_GPS_REG_DATA                   0xFF

// Misc
//
#define SNOW_GPS_UBX_1                      0xB5
#define SNOW_GPS_UBX_2                      0x62




// UBX specific
//

// Classes
#define     UBX_PCKG_CLASS_NAV              0x01
#define     UBX_PCKG_CLASS_RXM              0x02
#define     UBX_PCKG_CLASS_INF              0x04
#define     UBX_PCKG_CLASS_ACK              0x05
#define     UBX_PCKG_CLASS_CFG              0x06
#define     UBX_PCKG_CLASS_MON              0x0A
#define     UBX_PCKG_CLASS_AID              0x0B
#define     UBX_PCKG_CLASS_TIM              0x0D
#define     UBX_PCKG_CLASS_ESF              0x10


// IDs
#define UBX_ID_ACK_ACK                     0x01
#define UBX_ID_ACK_NACK                    0x00





enum snow_gps_current_sentence {
    SNOW_GPS_SENTENCE_NMEA,
    SNOW_GPS_SENTENCE_UBX,
    SNOW_GPS_SENTENCE_UNKNOWN
};

enum snow_gps_ubx_packet_validity {
    SNOW_GPS_UBX_PCKG_VALIDITY_UNCONFIRMED,
    SNOW_GPS_UBX_PCKG_VALID,
    SNOW_GPS_UBX_PCKG_INVALID
};

// Structure to hold device module information
// it was intended to be able to use multiple modules at the same time using this structure 
// for organisation but due to complexity reasons only one GNSS module at a time is supported at the moment
//
typedef struct snow_gps_device {
    uint8_t i2c_addr;
    bool initialized;
} snow_gps_device;


// Structure to hold GNNS position information
// latitude, longitude <=> GNSS position
// speed <=> surface speed
// date, time <=> date and time when record was taken
//
typedef struct snow_gps_position_information {
    float latitude;
    float longitude;
    float speed;
    struct minmea_date date;
    struct minmea_time time;
    bool valid;
} snow_gps_position_information;


// Structure to hold UBX protocol package information for sending and receiving configuration options
// cls <=> class
// id <=> id
// len <=> length of the payload
// payload <=> parameters
// chksm a & b <=> used to verify the validity of the data
// valid <=> for outgoing packages valid if checksum has been calculated 
//           for incoming packages valid if checksum has been verified
//
typedef struct ubx_packet {
    uint8_t cls;
    uint8_t id;
    uint16_t len;
    uint8_t* payload;
    uint8_t chksm_a;
    uint8_t chksm_b;
    bool valid;
} ubx_packet;



//
// Functions
//
uint8_t snow_gps_init(uint8_t i2c_addr, nrf_drv_twi_t* twi);
uint8_t snow_gps_send_command(ubx_packet* p);

uint8_t snow_gps_read_data();
uint8_t snow_gps_on_data_read();
uint8_t snow_gps_process_nmea_line(uint8_t* line, uint8_t size);

void snow_gps_get_position(snow_gps_position_information* pos);

void calculate_checksum(ubx_packet* p);


//
// Callbacks
//



#endif