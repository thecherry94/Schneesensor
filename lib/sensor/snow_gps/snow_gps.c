#include "snow_gps.h"
#include "nrf_delay.h"

#include "lib/module/minmea/minmea.h"


nrf_drv_twi_t* m_twi;
uint8_t m_read_buf[SNOW_GPS_DATA_BUFFER_SIZE+1] = {0};

snow_gps_position m_last_position;

snow_gps_device m_device;


// TODO 
// - Implement wake / sleep state



uint8_t snow_gps_init(uint8_t i2c_addr, nrf_drv_twi_t* twi) {
    
    // Do some init stuff in the future

    m_device.initialized = true;
    m_device.i2c_addr = i2c_addr;

    if (m_twi == NULL) {
        m_twi = twi;
    }

    m_last_position.valid = false;

    return NRF_SUCCESS;
}


uint8_t snow_gps_read_data() {
    
    uint16_t bytes_available = 0;
    uint16_t read_buf_cnt = 0;
    ret_code_t err_code;

    uint8_t tx_bytes_available = SNOW_GPS_REG_BYTES_AVAILABLE_MSB;

    // Inform GNSS module that we want to read the amount of data bytes available
    err_code = nrf_drv_twi_tx(m_twi, m_device.i2c_addr, &tx_bytes_available, 1, true);

    #ifdef __DEBUG__
    if (err_code != NRF_SUCCESS) 
        printf("GPS module did not acknowledge\n");
    #endif
    
    // Read bytes available and 
    uint8_t rx_bytes_available[2] = {0};
    err_code = nrf_drv_twi_rx(m_twi, m_device.i2c_addr, rx_bytes_available, 2);
    
    // put them here
    bytes_available = ((uint16_t)rx_bytes_available[0] << 8) | rx_bytes_available[1];

    if (bytes_available == 0)
        return 0;

    // Data is read in chunks
    //
    while (bytes_available > 0) {

        // Inform GNSS module that we want to read the data register
        uint8_t tx_data_reg = SNOW_GPS_REG_DATA;
        err_code = nrf_drv_twi_tx(m_twi, m_device.i2c_addr, &tx_data_reg, 1, true);

        uint16_t bytes_received = 0;

        //printf("\n\nBytes available: %d\n", bytes_available);

        // Determine chunk size
        if (bytes_available > SNOW_GPS_DATA_CHUNK_SIZE) {
            bytes_received = SNOW_GPS_DATA_CHUNK_SIZE;               
        } else {          
            bytes_received = bytes_available;
        }
        
        // Read a chunk of data
        err_code = nrf_drv_twi_rx(m_twi, m_device.i2c_addr, m_read_buf + read_buf_cnt, bytes_received);

        // Control variables
        read_buf_cnt += bytes_received;
        bytes_available -= bytes_received;     
    }

    // Terminate read buffer
    m_read_buf[read_buf_cnt] = '\0';

    //printf("%s\n\n", m_read_buf);

    // Processing of received data
    snow_gps_on_data_read();

    return 0;
}


// This function is called as soon as new data has been received from the GNSS module
// It separates the entire bulk data of sentences into single ones and feeds them to the minmea library for further processing 
// TODO 
// - Implement possibility to differentiate between NMEA and UBX protocol. At the moment only the NMEA protocol is supported but 
//   the configuration of the module is only possible via the UBX protocol.
uint8_t snow_gps_on_data_read() {
    uint8_t* cb = m_read_buf;

    uint16_t start = 0;
    uint16_t end = 0;
    uint16_t loc = 0;

    // NMEA sentence buffer
    uint8_t line[MINMEA_MAX_LENGTH] = {0};

    enum snow_gps_current_sentence current_sentence;

    // Check the first character whether it's a $ or µ(b) to specify the protocol
    // TODO make this a separate function
    switch (*cb) {
        case '$': {
            current_sentence = SNOW_GPS_SENTENCE_NMEA;
        } break;
        case SNOW_GPS_UBX_1: {
            // Check next character just to make sure 
            if (*(cb+1) == SNOW_GPS_UBX_2) {
                current_sentence = SNOW_GPS_SENTENCE_UBX;
            } else {
                // TODO ERROR
            }
        } break;
        default: {
            // TODO Unexpected message start
        } break;
    };

    // Loop through the entire read data buffer until string terminator
    //
    while (*cb) {

        // TODO The current sentence check above could be entirely put into this spot inside the loop

        if (current_sentence == SNOW_GPS_SENTENCE_NMEA) {
            // Check for "\r\n" indicating the end of a NMEA sentence
            if (*cb == '\n' && *(cb-1) == '\r') {
                // Unnecessary yet kept for clarities sake
                end = loc;

                // NMEA sentence length
                uint8_t len =  end - start;

                // Copy the NMEA sentence into a separate buffer
                memcpy(line, cb - len, len + 1);

                // Terminate the NMEA sentence string
                line[len+1] = '\0';

                // Set new starting position
                start = end + 1;
        
                // Process the single NMEA sentence
                snow_gps_process_nmea_line(line, MINMEA_MAX_LENGTH);         
            }
        }
        
        // Increase control variables
        cb++;
        loc++;
    }

    return 0;
}


// Processes a NMEA package 
// At the moment only the RMC is really needed since it contains all the data necessary
uint8_t snow_gps_process_nmea_line(uint8_t* line, uint8_t size) {
    enum minmea_sentence_id current_sentence = minmea_sentence_id(line, false);

    switch (current_sentence) {
        case MINMEA_SENTENCE_RMC: {
            struct minmea_sentence_rmc frame;
            if (minmea_parse_rmc(&frame, line)) {
                m_last_position.latitude = minmea_tocoord(&frame.latitude);
                m_last_position.longitude = minmea_tocoord(&frame.longitude);
                m_last_position.speed = minmea_tocoord(&frame.speed);
                m_last_position.date = frame.date;
                m_last_position.time = frame.time;
                m_last_position.valid = frame.valid;
            }
        } break;       
        case MINMEA_SENTENCE_GGA: {
            struct minmea_sentence_gga frame;
            if (minmea_parse_gga(&frame, line)) {
                // Received GGA package
            }
        } break;
        case MINMEA_SENTENCE_GST: {
            struct minmea_sentence_gst frame;
            if (minmea_parse_gst(&frame, line)) {
                // Received GST package
            }
        } break;
        case MINMEA_SENTENCE_GSV: {
            struct minmea_sentence_gsv frame;
            if (minmea_parse_gsv(&frame, line)) {
                // Received GSV package
            }
        } break;
        case MINMEA_SENTENCE_VTG: {
            struct minmea_sentence_vtg frame;
            if (minmea_parse_vtg(&frame, line)) {
                // Received VTG package
            }
        } break;
        case MINMEA_SENTENCE_ZDA: {
            struct minmea_sentence_zda frame;
            if (minmea_parse_zda(&frame, line)) {
                // Received VTG package
            }
        } break;
        case MINMEA_INVALID: {
            volatile int i = 0;
        } break;
        case MINMEA_UNKNOWN: {
            volatile int i = 0;
        } break;
        default: {
            volatile int i = 0;
        } break;
    }
}


void snow_gps_get_position(snow_gps_position* pos) {
    *pos = m_last_position;
}
