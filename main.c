#include <stdint.h>
#include <stdbool.h>
#include <stddef.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

/* DEFINES */
#define TWI_INSTANCE_ID 0
#define SPI_INSTANCE_ID 1


/* INCLUDES */

#include <boards.h>
#include "nrf_drv_twi.h"
#include "nrf_drv_spi.h"
#include "app_error.h"
#include "app_util_platform.h"
#include "nrf_delay.h"

#include "nrf_log.h"
#include "nrf_log_ctrl.h"
#include "nrf_log_default_backends.h"


#include <math.h>

#include "snow_slave.h"


void main(void) { 
    snow_slave_init();
    snow_slave_run();
}


