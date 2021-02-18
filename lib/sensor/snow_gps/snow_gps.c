#include "snow_gps.h"
#include "nrf_delay.h"


// Most of the driver code is taken from SparkFun_u-blox_GNSS_Arduino_Library.cpp 
// which has been translated from C++ to C and made to work with the NRF SDK
// The line <number> comments represent the corresponding functions in the sparkfun driver


nrf_drv_twi_t* m_twi;
sentence_types m_current_sentence;
uint16_t m_ubx_frame_counter;

uint8_t m_rolling_checksumA;
uint8_t m_rolling_checksumB;

uint16_t m_rtcm_frame_counter = 0;

//The packet buffers
//These are pointed at from within the ubxPacket
uint8_t payload_ack[2];
uint8_t payload_buf[2];
size_t packet_cfg_payload_size = 0;
uint8_t* payload_cfg = NULL;
uint8_t* payload_auto = NULL;

bool m_ignore_this_payload = false;

sfe_ublox_packet_buffer_e m_active_packet_buffer = SFE_UBLOX_PACKET_PACKETBUF;


//Init the packet structures and init them with pointers to the payloadAck, payloadCfg, payloadBuf and payloadAuto arrays
ubx_packet m_packet_ack = {0, 0, 0, 0, 0, payload_ack, 0, 0, SFE_UBLOX_PACKET_VALIDITY_NOT_DEFINED, SFE_UBLOX_PACKET_VALIDITY_NOT_DEFINED};
ubx_packet m_packet_buf = {0, 0, 0, 0, 0, payload_buf, 0, 0, SFE_UBLOX_PACKET_VALIDITY_NOT_DEFINED, SFE_UBLOX_PACKET_VALIDITY_NOT_DEFINED};
ubx_packet m_packet_cfg = {0, 0, 0, 0, 0, payload_cfg, 0, 0, SFE_UBLOX_PACKET_VALIDITY_NOT_DEFINED, SFE_UBLOX_PACKET_VALIDITY_NOT_DEFINED};
ubx_packet m_packet_auto = {0, 0, 0, 0, 0, payload_auto, 0, 0, SFE_UBLOX_PACKET_VALIDITY_NOT_DEFINED, SFE_UBLOX_PACKET_VALIDITY_NOT_DEFINED};


uint8_t snow_gps_init(nrf_drv_twi_t* twi_instance, snow_gps_device* device) {
    if (twi_instance == NULL)
        return 0; // TODO IMPLEMENT NULLPTR ERROR

    
    device->initialized = true;
    return 0; // TODO IMPLEMENT SUCCESS
}



uint8_t snow_gps_configure(snow_gps_device* device) {
    if (device == NULL)
        return 0; // TODO IMPLEMENT NULLPTR ERROR
}



// Sends an i2c command to the ublox GNSS module
// line 2265
// DOES NOT CALCULATE CHECKSUM!!!
//
uint8_t snow_gps_send_i2c_command(struct snow_gps_device* dev, struct ubx_packet* p, uint16_t max_wait) {
    
    if(nrf_drv_twi_tx(m_twi, dev->dev_id, 0xFF, 1, true) != NRF_SUCCESS) {
        // TODO Implement error (sensor did not ack)
    }

    // Write header bytes
    //
    uint8_t tx_header[6] = {0};
    tx_header[0] = UBX_SYNCH_1;
    tx_header[1] = UBX_SYNCH_2;
    tx_header[2] = p->cls;                        // class
    tx_header[3] = p->id;                         // id
    tx_header[4] = p->len & 0xFF;                 // LSB
    tx_header[5] = p->len >> 8;                   // MSB

    if(nrf_drv_twi_tx(m_twi, dev->dev_id, tx_header, 6, true) != NRF_SUCCESS) {
        // TODO Implement error (sensor did not ack)
    }


    // Write payload bytes in chunks of SNOW_GPS_I2C_TRANSACTION_SIZE
    //
    uint16_t bytes_to_send = p->len;
    uint16_t start_spot = 0;
    uint8_t tx_data[SNOW_GPS_I2C_TRANSACTION_SIZE] = {0};

    while (bytes_to_send > 1) {
        // Copy data chunk to tx buffer
        for (int i = 0; i < SNOW_GPS_I2C_TRANSACTION_SIZE; i++) {
            tx_data[i] = p->payload[start_spot + i];
        }
        
        if(nrf_drv_twi_tx(m_twi, dev->dev_id, tx_data, SNOW_GPS_I2C_TRANSACTION_SIZE, true) != NRF_SUCCESS) {
            // TODO Implement error (sensor did not ack)
        }
        
        // Control variables
        start_spot += SNOW_GPS_I2C_TRANSACTION_SIZE;
        bytes_to_send -= SNOW_GPS_I2C_TRANSACTION_SIZE;
    }

    // Write checksum bytes
    //
    uint8_t tx_checksum[3] = {0};
    uint8_t tx_checksum_len = 0;
     
    if (bytes_to_send == 1) {
        // There is one more byte of payload to send
        tx_checksum[0] = p->payload[start_spot]; // ???
        tx_checksum[1] = p->checksumA;
        tx_checksum[2] = p->checksumB;
        tx_checksum_len = 3;
    } else if (bytes_to_send == 0) {
        // No additional payload byte to send
        tx_checksum[0] = p->checksumA;
        tx_checksum[1] = p->checksumB;
        tx_checksum_len = 2;
    } else {
        // Theoretically impossible
        // TODO Implement error (this should never happen)
    }

    // Send final transaction (checksum) and release bus
    if(nrf_drv_twi_tx(m_twi, dev->dev_id, tx_checksum, tx_checksum_len, false) != NRF_SUCCESS) {
        // TODO Implement error (sensor did not ack)
    }       
}


// Checks if there is data available to read from the ublox GNSS module
// line 306
bool snow_gps_data_available(struct ubx_packet* p, uint8_t requested_class, uint8_t requested_id) {
    uint16_t bytes_available = 0;
    uint8_t rx_available[2] = {0};

    if(nrf_drv_twi_tx(m_twi, dev->dev_id, 0xFD, 1, true) != NRF_SUCCESS) {
        // TODO Implement error (sensor did not ack)
    } 

    if(nrf_drv_twi_rx(m_twi, dev->dev_id, rx_available, 2) {
        // TODO Implement error (sensor did not ack)
    } 

    uint8_t msb = rx_available[0];
    uint8_t lsb = rx_available[1];

    if (lsb == 0xFF) {
        // ublox bug? line 322
    }

    bytes_available = (uint16_t)msb << 8 | lsb;
    
    // No new data available
    if (bytes_available == 0)
        return false;
    
    // line 354 bug ???

    while (bytes_available) {
        // 0xFF is the register to read data from
        if (nrf_drv_twi_tx(m_twi, dev->dev_id, 0xFF, 1, true) != NRF_SUCCESS) {
            // TODO Implement error (sensor did not ack)
        }
        
      TRY_AGAIN:
        uint8_t rx_data[SNOW_GPS_I2C_TRANSACTION_SIZE] = {0};

        if (nrf_drv_twi_rx(m_twi, dev->dev_id, rx_data, SNOW_GPS_I2C_TRANSACTION_SIZE) != NRF_SUCCESS) {
            // TODO Implement error (sensor did not ack)
            // Probably should return false in this specific case
        }

        for (int i = 0; i < SNOW_GPS_I2C_TRANSACTION_SIZE; i++) {
            uint8_t incoming = rx_data[i];
            
            // Check if  the first byte read is 0x7F. Module is not ready to respond if it is wait and try again
            // TODO Implement non-blocking version of this functionality in a later version. This will have to do for now
            if (i == 0) {
                if (incoming == 0x7F) {
                    nrf_delay_ms(5);
                    goto TRY_AGAIN;
                }
            }

            snow_gps_process_incoming_data(incoming, p, requested_class, requested_id);
        }

        bytes_available -= SNOW_GPS_I2C_TRANSACTION_SIZE;
    }

    return true;
}


// Processes NMEA and UBX binary sentences one byte at a time
// Take a given byte and file it into the proper array
// line 714
void snow_gps_process_incoming_data(uint8_t incoming, ubx_packet* p, uint8_t requested_class, uint8_t requested_id) {
    if (m_current_sentence == NONE || m_current_sentence == NMEA) {
        if (incoming == UBX_SYNCH_1) {
            // Start of a new UBX binary frame (µ)
            // Reset control variables
            m_ubx_frame_counter = 0;
            m_current_sentence = UBX;
            m_packet_buf.counter = 0;
            m_ignore_this_payload = false;
            m_active_packet_buffer = SFE_UBLOX_PACKET_PACKETBUF;
        } else if (incoming == '$') {
            m_current_sentence = NMEA;
        } else if (incoming == 0xD3) {
            m_rtcm_frame_counter = 0;
            m_current_sentence = RTCM;
        } else {
            // TODO Implement error (unknown protocol)
        }
    }

    if (m_current_sentence == UBX) {
        if (m_ubx_frame_counter == 0 && incoming != 0xB5)
            m_current_sentence = NONE;
        else if (m_ubx_frame_counter == 1 && incoming != 0x62) 
            m_current_sentence = NONE;
        else if (m_ubx_frame_counter == 2) {
            // Class

            // Record the class in the packet buffer until it is known what to do with it
            m_packet_buf.cls = incoming;
            m_rolling_checksumA = 0;
            m_rolling_checksumB = 0;
            m_packet_buf.counter = 0;
            m_packet_buf.valid = SFE_UBLOX_PACKET_VALIDITY_NOT_DEFINED;
            m_packet_buf.startingSpot = p->startingSpot;
        } else if (m_ubx_frame_counter == 3) {
            // ID

            // Record the ID in the packet buffer until it is known what to do with it
            m_packet_buf.id = incoming;

            // Now the type of response can be identified
            // If the current package being received is not an ACK check for a class and ID match
            if (m_packet_buf.cls != UBX_CLASS_ACK) {
                // Not an ACK package so check for class and ID match
                if (m_packet_buf.cls == requested_class && m_packet_buf.id == requested_id) {
                    // Not an ACK and class and ID do match
                    m_active_packet_buffer = SFE_UBLOX_PACKET_PACKETCFG;
                    p->cls = m_packet_buf.cls;
                    p->id = m_packet_buf.id;
                    p->counter = m_packet_buf.counter;
                } else if (snow_gps_check_automatic(m_packet_buf.cls, m_packet_buf.id)) {
                    // This is not an ACK and we do not have a complete class and ID match
                    // So let's check if this is an "automatic" message which has its own storage defined

                    // TODO Implement automatic messages handling
                } else {
                    // This is not an ACK and does not have a class and ID match
                    // Keep diverting data into the packet buffer and ignore the payload

                    m_ignore_this_payload = true;
                }
            }
            else {
                // This is an ACK so it is to early to do anything with it
                // Wait until length and data bytes have been received
                // Keep diverting data into the packet buffer
            }
        } else if (m_ubx_frame_counter == 4) {
            // Length LSB
            m_packet_buf.len = incoming;
        } else if (m_ubx_frame_counter == 5) {
            // Length MSB
            m_packet_buf.len |= incoming << 8;
        } else if (m_ubx_frame_counter == 6) {
            // First payload data byte (unless len is zero)
            if (m_packet_buf.len == 0) {
                // Payload length is zero (which should be impossible, but okay)
                // TODO Implement error in case this happens (which should never happen)

                m_packet_buf.checksumA = incoming;
            }
        } else if (m_ubx_frame_counter == 7) {
            // Second payload byte
            if (m_packet_buf.len == 0) {
                // Payload length is zero so this is the checksum B byte
                m_packet_buf.checksumB = incoming;
            } else if (m_packet_buf.len == 1) {
                // Payload length is one so this is the checksum A byte
                m_packet_buf.checksumA = incoming;
            } else {
                // Payload is >= 2 so this is the second payload byte
                m_packet_buf.payload[1] = incoming;
            }

            // Now that two payload bytes have been received a match for ACK/NACK can be checked
            if (m_active_packet_buffer == SFE_UBLOX_PACKET_PACKETBUF    // If there is no data package being processed
                && m_packet_buf.cls == UBX_CLASS_ACK                    // and if this is an ACK/NACK package
                && m_packet_buf.payload[0] == requested_class           // and if the class matches
                && m_packet_buf.payload[1] == requested_id) {           // and if the ID matches

                if (m_packet_buf.len == 2) {
                    m_active_packet_buffer = SFE_UBLOX_PACKET_PACKETACK;
                    m_packet_ack.cls = m_packet_buf.cls;
                    m_packet_ack.id = m_packet_buf.id;
                    m_packet_ack.len = m_packet_buf.len;
                    m_packet_ack.counter = m_packet_buf.counter;
                    m_packet_ack.payload[0] = m_packet_buf.payload[0];
                    m_packet_ack.payload[1] = m_packet_buf.payload[1];
                } else {
                    // Length is not 2 (which should be impossible)
                    // TODO Implement error in case this happens
                }

        
                }
                
            }

            // Divert incoming into the correct buffer
            if (m_active_packet_buffer == SFE_UBLOX_PACKET_PACKETACK)
                snow_gps_process_ubx(incoming, &m_packet_ack, requested_class, requested_id);
            else if (m_active_packet_buffer == SFE_UBLOX_PACKET_PACKETCFG)
                snow_gps_process_ubx(incoming, p, requested_class, requested_id);
            else if (m_active_packet_buffer == SFE_UBLOX_PACKET_PACKETBUF) 
                snow_gps_process_ubx(incoming, &m_packet_buf, requested_class, requested_id);
            else // packet auto
                snow_gps_process_ubx(incoming, &m_packet_auto, requested_class, requested_id);

            // Increase the frame counter for next iteration
            m_ubx_frame_counter++;
        } else if (m_current_sentence == NMEA) {
            snow_gps_process_nmea(incoming);
        } else if (m_current_sentence == RTCM) {
            snow_gps_process_rtcm(incoming);
        }
    }
}



// Calculates the checksum for a given ubx packet
//
uint8_t snow_gps_calc_command_checksum(struct ubx_packet* p) {
    p->checksumA = 0;
    p->checksumB = 0;

    p->checksumA += p->cls;
    p->checksumB += p->checksumA;

    p->checksumA += p->id;
    p->checksumB += p->checksumA;

    p->checksumA += p->len & 0xFF;
    p->checksumB += p->checksumA;

    p->checksumA += p->cls >> 8;
    p->checksumB += p->checksumA;

    for (uint16_t i = 0; i < p->len; i++) {
        p->checksumA += p->payload[i];
        p->checksumB += p->checksumA;
    }
}