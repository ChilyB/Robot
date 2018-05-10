#ifndef _TEST_H_
#define _TEST_H_

#include "../os/suzuha_os.h"
#include "../lib_usr/lib_usr.h"
#include "movements.h"


#define  LINE_WHITE     (u32)(0)
#define  LINE_RED       (u32)(1)
#define  LINE_GREEN     (u32)(2)
#define  LINE_BLUE      (u32)(3)


#define RX_BUFFER_LENGHT 128
#define TX_BUFFER_LENGHT 128

#define LEFT_SIDE 1
#define RIGHT_SIDE 2

char rx_buffer[RX_BUFFER_LENGHT];
char tx_buffer[TX_BUFFER_LENGHT];


void sensor_test();
void imu_test();

void i2cADC_test();
void batADC_test();
void charging_test_go_straight_until_line(u32 line_color);
void line_follower_until_color(u32 line_color,u32 end_color);
void slightTurn(u32 time,i32 speed, char side);
void charging_wifi_test();
void line_up_to_color(u32 line_color);

void line_follower_with_charging(u32 line_color,u32 charging_line_color,uint32_t low_battery_V, uint32_t high_battery_V,uint32_t charger_V);
void motors_test();


void go_forward_test();
void rotation_test();

void line_follower_test(u32 line_color);

#endif
