#include "snow_gps.h"
#include "nrf_delay.h"

#include "lib/module/minmea/minmea.h"


nrf_drv_twi_t* m_twi;
uint8_t m_read_buf[SNOW_GPS_DATA_BUFFER_SIZE+1] = {0};

snow_gps_device* m_last_device = NULL;

enum minmea_sentence_id m_requested_sentence;


uint8_t snow_gps_init(snow_gps_device* device, nrf_drv_twi_t* twi) {
    
    // Do some init stuff in the future

    device->initialized = true;

    if (m_twi == NULL) {
        m_twi = twi;
    }

    return NRF_SUCCESS;
}


uint8_t snow_gps_read_data(snow_gps_device* dev) {
    
    uint16_t bytes_available = 0;
    uint16_t read_buf_cnt = 0;
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

    if (bytes_available == 0)
        return 0;

    // Data is read in chunks
    //
    while (bytes_available > 0) {

        // Inform GNSS module that we want to read the data register
        uint8_t tx_data_reg = SNOW_GPS_REG_DATA;
        err_code = nrf_drv_twi_tx(m_twi, dev->i2c_addr, &tx_data_reg, 1, true);

        uint16_t bytes_received = 0;

        //printf("\n\nBytes available: %d\n", bytes_available);

        // Determine chunk size
        if (bytes_available > SNOW_GPS_DATA_CHUNK_SIZE) {
            bytes_received = SNOW_GPS_DATA_CHUNK_SIZE;               
        } else {          
            bytes_received = bytes_available;
        }
        
        // Read a chunk of data
        err_code = nrf_drv_twi_rx(m_twi, dev->i2c_addr, m_read_buf + read_buf_cnt, bytes_received);

        // Control variables
        read_buf_cnt += bytes_received;
        bytes_available -= bytes_received;     
    }

    m_read_buf[read_buf_cnt] = '\0';

    //printf("%s\n\n", m_read_buf);

    // Processing of received data
    snow_gps_on_data_read();

    // Remember which device requested this data 
    m_last_device = dev;

    return 0;
}


// This function is called as soon as new data has been received from the GNSS module
// It separates the entire bulk data of sentences into single ones and feeds them to the minmea library for further processing
//
uint8_t snow_gps_on_data_read() {
    uint8_t* cb = m_read_buf;

    uint16_t start = 0;
    uint16_t end = 0;
    uint16_t loc = 0;

    // NMEA sentence buffer
    uint8_t line[MINMEA_MAX_LENGTH] = {0};


    // Loop through the entire read data buffer
    while (*cb) {
        // Check for "\r\n" indicating the end of a NMEA sentence
        if (*cb == '\n' && *(cb-1) == '\r') {
            end = loc;
            uint8_t len =  end - start;

            // Copy the NMEA sentence into a separate buffer
            memcpy(line, cb - len, len + 1);
            line[len+1] = '\0';

            // Set new starting position
            start = end + 1;
            
            // Process the single NMEA sentence
            snow_gps_process_nmea_line(line, MINMEA_MAX_LENGTH);
            
        }
        
        // Increase control variables
        cb++;
        loc++;
    }

    return 0;
}


uint8_t snow_gps_process_nmea_line(uint8_t* line, uint8_t size) {
    enum minmea_sentence_id current_sentence = minmea_sentence_id(line, false);

    if (current_sentence == m_requested_sentence) {
        switch (current_sentence) {
            case MINMEA_SENTENCE_RMC: {
                struct minmea_sentence_rmc frame;
                if (minmea_parse_rmc(&frame, line)) {
                    // Received RMC package
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
}



uint8_t snow_gps_request_nmea_package(snow_gps_device* dev, enum minmea_sentence_id requested_sentence) {
    m_requested_sentence = requested_sentence;  
    snow_gps_read_data(dev);
}
