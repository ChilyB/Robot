#ifndef _ADC_H_
#define _ADC_H_

#include "../lib_low_level.h"

#define ADC0_CH 	((u32)0)		//ADC1_IN1
#define ADC1_CH 	((u32)1)		//ADC1_IN2 //battery voltage
#define ADC2_CH 	((u32)2)		//ADC1_IN3
#define ADC3_CH 	((u32)3)		//ADC1_IN4
#define ADC4_CH 	((u32)4)		//ADC2_IN1
#define ADC5_CH 	((u32)5)		//ADC2_IN2
#define ADC6_CH 	((u32)6)		//ADC2_IN3
#define ADC7_CH 	((u32)7)		//ADC2_IN4

#define ADC8_CH 	((u32)8)		//ADC3_IN13
#define ADCREF_CH    ((u32)9)        //ADC1_IN18 internal referenceň

void adc_init();

u16 adc_read(u32 ch);

#endif