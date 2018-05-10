#include "bat_adc.h"
//napatie v mV
uint32_t getBatteryVoltage(){
    uint32_t napatie = 0;
    napatie = adc_read(ADC_Channel_2);
    napatie = (napatie*3300)/4096;
}