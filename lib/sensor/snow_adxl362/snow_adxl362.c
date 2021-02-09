#include "snow_adxl362.h"



nrf_drv_spi_t*                m_spi;
snow_adxl362_spi_transfer_t   m_spi_transfer_func;
uint8_t                       m_last_command;
bool                          m_initialized = false;






snow_adxl362_ret_code_t snow_adxl362_init(nrf_drv_spi_t* spi_instance, snow_adxl362_spi_transfer_t spi_transfer_func_ptr) {
    if (spi_instance == NULL || spi_transfer_func_ptr == NULL)
        return SNOW_ADXL362_NULLPTR_ERROR;
    
    m_spi = spi_instance;
    m_spi_transfer_func = spi_transfer_func_ptr;

    // Perform a read of some constant registers set by the manufacturer as a test
    //


}



snow_adxl362_ret_code_t snow_adxl362_configure(snow_adxl362_config_t* cfg) {
    
}




snow_adxl362_ret_code_t adxl362_soft_reset(bool wait_recommended) {
    uint8_t tx_buf[] = { 0x0A, 0x1F, 0x52 };
    
    nrf_gpio_pin_clear(23);
    ret_code_t err_code = nrf_drv_spi_transfer(m_spi, tx_buf, 3, NULL, 0);
    nrf_gpio_pin_set(23);

    if (wait_recommended)
        nrf_delay_ms(1);

    return return err_code == NRF_SUCCESS ? SNOW_ADXL362_OK : SNOW_ADXL362_SPI_ERROR;;
}



snow_adxl362_ret_code_t adxl362_read_accl(accl_xyz_t* accl) {

    uint8_t tx_buf[] = {
        0x0B,   // Command read
        0x0E   // Read X-Axis LSB Register
    };
    
    // rx_buf[0] <=> 0
    // rx_buf[1] <=> 0
    // rx_buf[2] <=> X LSB
    // rx_buf[3] <=> X MSB
    // rx_buf[4] <=> Y LSB
    // rx_buf[5] <=> Y MSB
    // rx_buf[6] <=> Z LSB
    // rx_buf[7] <=> Z MSB
    uint8_t rx_buf[8] = {0};
    uint8_t len = 8;

    nrf_gpio_pin_clear(23);
    ret_code_t err_code = nrf_drv_spi_transfer(m_spi, tx_buf, len, rx_buf, len);
    nrf_gpio_pin_set(23);

    uint16_t x;
    uint16_t y;
    uint16_t z;
    
    // Construct 12-bit sensor values according to ADXL362 Datasheet page 26
    x = (rx_buf[3] << 8) | rx_buf[2];
    y = (rx_buf[5] << 8) | rx_buf[4];
    z = (rx_buf[7] << 8) | rx_buf[6];

    // Scale factor changes with sensitivity
    const float scale_factor = 0.001f;    

    // Copy the bit values one-by-one instead of uint->float value conversion
    accl->x = *((int16_t*)&x) * scale_factor;
    accl->y = *((int16_t*)&y) * scale_factor;
    accl->z = *((int16_t*)&z) * scale_factor;

    return err_code == NRF_SUCCESS ? SNOW_ADXL362_OK : SNOW_ADXL362_SPI_ERROR;
}