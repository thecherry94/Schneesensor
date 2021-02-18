#ifndef SPI_HANDLER_H
#define SPI_HANDLER_H

typedef uint8_t (*snow_spi_transfer_t)(uint8_t* tx_buf, uint8_t tx_len, uint8_t* rx_buf, uint8_t rx_len, uint8_t cs_pin);

typedef struct snow_spi_transfer_handler_t {
    uint8_t cs_pin;
    uint8_t (*on_transmission_begin)();
    uint8_t (*on_transmission_completed)();
} snow_spi_transfer_handler_t;

#endif