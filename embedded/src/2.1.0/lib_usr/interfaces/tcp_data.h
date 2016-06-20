#ifndef _TCP_DATA_H_
#define _TCP_DATA_H_

#include "../lib_usr.h"
#include "tcp_data_struct.h"



void tcp_init();
i32 tcp_rgb_sensors_send();
i32 tcp_line_sensor_send();
i32 tcp_lsm9ds0_imu_send();

void tcp_terminal_puts(char *s);
i32 tcp_terminal_send();

#endif
