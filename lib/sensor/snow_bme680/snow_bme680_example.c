/*******************************************************************************
* JesFs_main.C: JesFs Demo/Test
*
* JesFs - Jo's Embedded Serial File System
*
* Demo how to use JesFs on
* - TI CC13xx/CC26xx Launchpad
* - Nordic nRF52840 DK_PCA10056 (nRF52)
* - Windows (Compilers: "Embarcadero(R) C++ Builder Community Edition" (for PC)
*           and "Microsoft Visual Studio Community 2019")
*
* Can be used as standalone project or,
* in combination with secure JesFsBoot Bootloader
*
* Docu in 'JesFs.pdf'
*
* (C) joembedded@gmail.com - www.joembedded.de
* Version: 
* 1.5: 25.11.2019 
* 1.51: 07.12.2019 (nRF52) added deep sleep functions in Toolbox (nrF52840<3uA) (see cmd 's')
* 1.6: 22.12.2019  added fs_check_disk() for detailed checks
* 1.61: 05.01.2020 source cosmetics and (nRF52) SPIM 16MHz as default
* 1.62: 19.01.2020 Changed WD behavior in tb_tools
* 1.7: 25.02.2020 (nRF52) Added Defines for u-Blox NINA-B3 
* 1.8: 20.03.2020 Added Time set with '!' and UART-RX-Error
* 2.0: 06.09.2020 (nRF52) Changed UART Driver to APP_UART  for Multi-Use in tb_tools
* 2.01: 08.09.2020 (nRF52) Fixed Error in SDK17 (see tb_tools_nrf52.c-> 'SDK17')
* 2.02: 23.09.2020 (nRF52) Adapted to SDK17.0.2 (still Problem in 'nrf_drv_clock.c' -> see 'SDK17')
* 2.03: 22.11.2020 Corrected small error in JesFs_main.c 'r' command.
*******************************************************************************/

#include <stdint.h>
#include <stdbool.h>
#include <stddef.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

/* DEFINES */
#define TWI_INSTANCE_ID 0



/* INCLUDES */
#include "boards.h"

#include "nrf_drv_twi.h"
#include "app_error.h"
#include "app_util_platform.h"
#include "nrf_delay.h"

#include "nrf_log.h"
#include "nrf_log_ctrl.h"
#include "nrf_log_default_backends.h"


#include "snow_bme680.h"

/* FUNCTION DECLARATIONS */
int8_t user_i2c_read(uint8_t dev_id, uint8_t reg_addr, uint8_t *reg_data, uint16_t len);
int8_t user_i2c_write(uint8_t dev_id, uint8_t reg_addr, uint8_t *reg_data, uint16_t len);

int8_t init_bme(struct bme680_dev*, int8_t);
int8_t conf_bme(struct bme680_dev*);

void twi_init();
void twi_handler(nrf_drv_twi_evt_t const * p_event, void * p_context);

void print_result(const char* op, uint8_t code, bool meas);


/* GLOBAL VARIABLES */
static volatile bool m_i2c_tx_done = false;
static const nrf_drv_twi_t m_twi = NRF_DRV_TWI_INSTANCE(TWI_INSTANCE_ID);






//========= MAIN ====================
int main(void) { // renamed to mainThread() on CCxxyy

    twi_init();
    
    snow_bme680_init(&m_twi, 10);
    snow_bme680_conf();

    nrf_delay_ms(500);

    struct bme680_field_data data;

    for (;;) {
        snow_bme680_measure(&data, true);
        
        printf("T: %.2f degC, P: %.2f hPa, H %.2f %%rH A: %.2f m\n", data.temperature / 100.0f,
            data.pressure / 100.0f, data.humidity / 1000.0f, 44330.0f * (1.0f - pow(data.pressure / 101325.0f, 0.1903f)));
    }
}


void twi_init() {
    ret_code_t err_code;

    const nrf_drv_twi_config_t twi_conf = {
        .scl = ARDUINO_SCL_PIN,
        .sda = ARDUINO_SDA_PIN,
        .frequency = NRF_DRV_TWI_FREQ_100K,
        .interrupt_priority = APP_IRQ_PRIORITY_LOW,
        .clear_bus_init = true
    };

    err_code = nrf_drv_twi_init(&m_twi, &twi_conf, NULL, NULL);
    APP_ERROR_CHECK(err_code);

    nrf_drv_twi_enable(&m_twi);
}

