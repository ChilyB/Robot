#ifndef _MOTORS_H_
#define _MOTORS_H_

#include "../lib_usr.h"

#define USE_MOTORS 1

#define SPEED_MAX      (i32)44

struct sMotors
{
	i32 left, right;
};

volatile struct sMotors g_motors;

//rev3 + magic soldering jumper
#define DRV8830_LEFT_ADDRESS		0xC2
#define DRV8830_RIGHT_ADDRESS	 0xC6

//rev1+2
//#define DRV8830_LEFT_ADDRESS		0xC0
//#define DRV8830_RIGHT_ADDRESS	 0xC2

#define DRV8830_CONTROL_REG		 0x00
#define DRV8830_FAULT_REG			 0x01

u32 motors_init();
void motors_uninit();

void motors_update();

#endif
