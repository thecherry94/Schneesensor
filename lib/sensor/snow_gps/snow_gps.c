#include "snow_gps.h"


nrf_drv_twi_t* m_twi;

uint8_t m_read_buf[SNOW_GPS_DATA_BUFFER_SIZE] = {0};

// 
// Private helper variables
//
typedef struct processing_helper {
    ublox_sentence_type_e current_sentence;
    uint8_t frame_counter;
    bool ignore_payload;
    sfe_ublox_packet_buffer_e active_p_buf;
    uint8_t rolling_chk_a;
    uint8_t rolling_chk_b;
} processing_helper;

// Data byte processing helper
processing_helper ph = {0};


// Buffers for the incoming packages
ubx_packet p_ack = {0, 0, 0, 0, 0, payloadAck, 0, 0, SFE_UBLOX_PACKET_VALIDITY_NOT_DEFINED, SFE_UBLOX_PACKET_VALIDITY_NOT_DEFINED};
ubx_packet p_buf = {0, 0, 0, 0, 0, payloadBuf, 0, 0, SFE_UBLOX_PACKET_VALIDITY_NOT_DEFINED, SFE_UBLOX_PACKET_VALIDITY_NOT_DEFINED};
ubx_packet p_cfg = {0, 0, 0, 0, 0, payloadCfg, 0, 0, SFE_UBLOX_PACKET_VALIDITY_NOT_DEFINED, SFE_UBLOX_PACKET_VALIDITY_NOT_DEFINED};
ubx_packet p_aut = {0, 0, 0, 0, 0, payloadAuto, 0, 0, SFE_UBLOX_PACKET_VALIDITY_NOT_DEFINED, SFE_UBLOX_PACKET_VALIDITY_NOT_DEFINED};



// 
// private helper functions
//
uint8_t process_gps_byte(uint8_t cb, ubx_packet* p, uint8_t requested_class, uint8_t requested_id);


uint8_t process_gps_byte(uint8_t byte, ubx_packet* p, uint8_t requested_class, uint8_t requested_id) {
    if (ph.current_sentence == NONE || ph.current_sentence == NMEA) {
        if (cb == UBLOX_BINARY_FLAG_1) {
            // Byte is the start of a new ublox binary sentence
            ph.frame_counter = 0;
            ph.current_sentence = UBX;
            p_buf.counter = 0;
            ph.ignore_payload = false;
            ph.active_p_buf = UBLOX_PACKET_PACKETBUF;
        } else if (cb == '$') {
            ph.current_sentence = NMEA;
        } else if (cb == 0xD3) {
            // RTCM not implemented
            ph.current_sentence = RTCM;
        }

        if (ph.current_sentence == UBX) {
            // Current sentence is UBX

            if (ph.frame_counter == 0 && cb != UBLOX_BINARY_FLAG_1)
                ph.current_sentence = NONE;
            else if (ph.frame_counter == 1 && cb != UBLOX_BINARY_FLAG_2) 
                ph.current_sentence = NONE;
            else if (ph.frame_counter == 2) {
                // Current byte is the class specifier
                p_buf.cls = cb;
                ph.rolling_chk_a = 0;
                ph.rolling_chk_b = 0;
                p_buf.counter = 0;
                p_buf.valid = UBLOX_PACKET_VALIDITY_NOT_DEFINED;
                p_buf.start_spot = p->start_spot;
            } else if (ph.frame_counter == 3) {
                // Current byte is the ID specifier
                p_buf.id = cb;

            }
        }
    }
}



uint8_t snow_gps_init(snow_gps_device* device, nrf_drv_twi_t* twi) {
    
    // Do some init stuff in the future

    device->initialized = true;

    if (m_twi == NULL) {
        m_twi = twi;
    }

    return NRF_SUCCESS;
}


uint8_t snow_gps_read_data(snow_gps_device* dev, ubx_packet* p, uint8_t requested_cls, uint8_t requested_id) {
    
    uint16_t bytes_available = 0;
    ret_code_t err_code;

    uint8_t tx_bytes_available = SNOW_GPS_REG_BYTES_AVAILABLE_MSB;

    // Inform GNSS module that we want to read the amount of data bytes available
    err_code = nrf_drv_twi_tx(m_twi, dev->i2c_addr, &tx_bytes_available, 1, true);

    #ifdef __DEBUG__
    if (err_code != NRF_SUCCESS) 
        printf("GPS module did not acknowledge\n");
    #endif
    
    // Read bytes available and 
    uint8_t rx_bytes_available[2] = {0};
    err_code = nrf_drv_twi_rx(m_twi, dev->i2c_addr, rx_bytes_available, 2);
    
    // put them here
    bytes_available = ((uint16_t)rx_bytes_available[0] << 8) | rx_bytes_available[1];

    // Data is read and processed in chunks
    //
    while (bytes_available) {

        // Inform GNSS module that we want to read the data register
        uint8_t tx_data_reg = SNOW_GPS_REG_DATA;
        err_code = nrf_drv_twi_tx(m_twi, dev->i2c_addr, &tx_data_reg, 1, true);

TRY_AGAIN:

        // Read a chunk of data
        err_code = nrf_drv_twi_rx(m_twi, dev->i2c_addr, m_read_buf, SNOW_GPS_DATA_BUFFER_SIZE);

        // Loop through entire buffer array
        //
        for (uint16_t i = 0; i < SNOW_GPS_DATA_BUFFER_SIZE; i++) {
            
            // Current byte
            uint8_t cb = m_read_buf[i];

            // Check the first byte
            if (i == 0) {
                if (cb == 0x7F) {
                    // Module not ready yet
                    printf("UBLOX ERROR: Device not ready yet\n");
                    nrf_delay_ms(2);

                    goto TRY_AGAIN;
                }
            }

            process
        }

        bytes_available -= SNOW_GPS_DATA_BUFFER_SIZE;
    }

    return 0;
}