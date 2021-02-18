#ifndef SNOW_GPS_H
#define SNOW_GPS_H


#include "nrf_drv_twi.h"

#define ZOE_M8Q_I2C_ADDR    0x42

#define UBX_SYNCH_1         0xB5  // µ
#define UBX_SYNCH_2         0x62  // b

#define SNOW_GPS_I2C_TRANSACTION_SIZE  32


//The following are UBX Class IDs. Descriptions taken from ZED-F9P Interface Description Document page 32, NEO-M8P Interface Description page 145
const uint8_t UBX_CLASS_NAV = 0x01;	 //Navigation Results Messages: Position, Speed, Time, Acceleration, Heading, DOP, SVs used
const uint8_t UBX_CLASS_RXM = 0x02;	 //Receiver Manager Messages: Satellite Status, RTC Status
const uint8_t UBX_CLASS_INF = 0x04;	 //Information Messages: Printf-Style Messages, with IDs such as Error, Warning, Notice
const uint8_t UBX_CLASS_ACK = 0x05;	 //Ack/Nak Messages: Acknowledge or Reject messages to UBX-CFG input messages
const uint8_t UBX_CLASS_CFG = 0x06;	 //Configuration Input Messages: Configure the receiver.
const uint8_t UBX_CLASS_UPD = 0x09;	 //Firmware Update Messages: Memory/Flash erase/write, Reboot, Flash identification, etc.
const uint8_t UBX_CLASS_MON = 0x0A;	 //Monitoring Messages: Communication Status, CPU Load, Stack Usage, Task Status
const uint8_t UBX_CLASS_AID = 0x0B;	 //(NEO-M8P ONLY!!!) AssistNow Aiding Messages: Ephemeris, Almanac, other A-GPS data input
const uint8_t UBX_CLASS_TIM = 0x0D;	 //Timing Messages: Time Pulse Output, Time Mark Results
const uint8_t UBX_CLASS_ESF = 0x10;	 //(NEO-M8P ONLY!!!) External Sensor Fusion Messages: External Sensor Measurements and Status Information
const uint8_t UBX_CLASS_MGA = 0x13;	 //Multiple GNSS Assistance Messages: Assistance data for various GNSS
const uint8_t UBX_CLASS_LOG = 0x21;	 //Logging Messages: Log creation, deletion, info and retrieval
const uint8_t UBX_CLASS_SEC = 0x27;	 //Security Feature Messages
const uint8_t UBX_CLASS_HNR = 0x28;	 //(NEO-M8P ONLY!!!) High Rate Navigation Results Messages: High rate time, position speed, heading
const uint8_t UBX_CLASS_NMEA = 0xF0; //NMEA Strings: standard NMEA stringss



// Identify which packet buffer is in use:
// packetCfg (or a custom packet), packetAck or packetBuf
// packetAuto is used to store expected "automatic" messages
typedef enum
{
	SFE_UBLOX_PACKET_PACKETCFG,
	SFE_UBLOX_PACKET_PACKETACK,
	SFE_UBLOX_PACKET_PACKETBUF,
	SFE_UBLOX_PACKET_PACKETAUTO
} sfe_ublox_packet_buffer_e;


typedef enum
{
	SFE_UBLOX_PACKET_VALIDITY_NOT_VALID,
	SFE_UBLOX_PACKET_VALIDITY_VALID,
	SFE_UBLOX_PACKET_VALIDITY_NOT_DEFINED,
	SFE_UBLOX_PACKET_NOTACKNOWLEDGED // This indicates that we received a NACK
} sfe_ublox_packet_validity_e;

enum sentence_types {
        NONE = 0,
        NMEA,
        UBX,
        RTCM
}; 

typedef struct ubx_packet
{
	uint8_t cls;
	uint8_t id;
	uint16_t len; //Length of the payload. Does not include cls, id, or checksum bytes
	uint16_t counter; //Keeps track of number of overall bytes received. Some responses are larger than 255 bytes.
	uint16_t startingSpot; //The counter value needed to go past before we begin recording into payload array
	uint8_t *payload; // We will allocate RAM for the payload if/when needed.
	uint8_t checksumA; //Given to us from module. Checked against the rolling calculated A/B checksums.
	uint8_t checksumB;
	sfe_ublox_packet_validity_e valid;			 //Goes from NOT_DEFINED to VALID or NOT_VALID when checksum is checked
	sfe_ublox_packet_validity_e classAndIDmatch; // Goes from NOT_DEFINED to VALID or NOT_VALID when the Class and ID match the requestedClass and requestedID
} ubxPacket;


typedef struct snow_gps_config_t {
    
} snow_gps_config_t;

typedef struct snow_gps_device {
    uint8_t dev_id;
    snow_gps_config_t cfg;
    bool initialized;
} snow_gps_device;

typedef struct snow_gps_coordinates_t {
    float latitude;
    float longitude;
} snow_gps_coordinates_t;


uint8_t snow_gps_init(nrf_drv_twi_t* twi_instance, snow_gps_device* device);
uint8_t snow_gps_configure(snow_gps_device* device);
uint8_t snow_gps_get_coordinates(snow_gps_coordinates_t* coords);

uint8_t snow_gps_send_i2c_command(struct ubx_packet* p, uint16_t max_wait);
uint8_t snow_gps_calc_command_checksum(struct ubx_packet* p);
bool snow_gps_data_available(struct ubx_packet* p, uint8_t requested_class, uint8_t requested_id);

void snow_gps_process_incoming_data(uint8_t incoming, ubx_packet p, uint8_t requested_class, uint8_t requested_id);
void snow_gps_process_ubx(uint8_t incoming, ubx_packet p, uint8_t requested_class, uint8_t requested_id);
void snow_gps_process_nmea(uint8_t incoming);
void snow_gps_process_rtcm(uint8_t incoming);

bool snow_gps_check_automatic(uint8_t cls, uint8_t id);


#endif