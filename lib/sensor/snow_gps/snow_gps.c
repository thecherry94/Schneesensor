#include "snow_gps.h"
#include "nrf_delay.h"


nrf_drv_twi_t* m_twi;

uint8_t m_read_buf[SNOW_GPS_DATA_BUFFER_SIZE+1] = {0};
uint8_t m_msg_buf[SNOW_GPS_DATA_BUFFER_SIZE] = {0};



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
    while (bytes_available > 0) {

        // Inform GNSS module that we want to read the data register
        uint8_t tx_data_reg = SNOW_GPS_REG_DATA;
        err_code = nrf_drv_twi_tx(m_twi, dev->i2c_addr, &tx_data_reg, 1, true);
        memset(m_read_buf, 0, SNOW_GPS_DATA_BUFFER_SIZE);

        uint16_t bytes_received = 0;

        printf("\n\nBytes available: %d\n", bytes_available);

        // Read a chunk of data
        if (bytes_available > SNOW_GPS_DATA_BUFFER_SIZE) {
            err_code = nrf_drv_twi_rx(m_twi, dev->i2c_addr, m_read_buf, SNOW_GPS_DATA_BUFFER_SIZE);
            bytes_available -= SNOW_GPS_DATA_BUFFER_SIZE;
            m_read_buf[SNOW_GPS_DATA_BUFFER_SIZE] = '\0';
            bytes_received = SNOW_GPS_DATA_BUFFER_SIZE;
        } else {
            err_code = nrf_drv_twi_rx(m_twi, dev->i2c_addr, m_read_buf, bytes_available);
            bytes_received = bytes_available;
            m_read_buf[bytes_available] = '\0';
            bytes_available = 0;
        }
        
        
        uint8_t* cb = m_read_buf;
        uint8_t cnt = 0;
        uint8_t pos = 0;

        while (pos < bytes_received) {
            while (cb[pos] != '\n' && cb[pos-1] != '\r') {           
                m_msg_buf[cnt++] = cb[pos++];

                if (pos == bytes_received)
                    break;
            }
            
            printf("%s\n", m_msg_buf);

            cnt = 0;
            pos++;
        }
        
/*
        uint8_t* token = strtok(m_read_buf, "$");

        while (token != NULL) {
            printf("%s\n", token);
            token = strtok(NULL, "\r\n");
        }
        */

        //printf("%s\n\n", m_read_buf);
    }

    

    return 0;
}


uint8_t snow_gps_on_new_nmea_message(uint8_t* msg, uint8_t len) {

}