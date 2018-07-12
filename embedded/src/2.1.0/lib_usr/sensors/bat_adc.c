#include "bat_adc.h"
//napatie v mV
uint32_t getBatteryVoltage(int offset){
    uint32_t napatie = 0;
    napatie = adc_read(ADC1_CH); 
    napatie = (napatie*3300*2)/4096+offset;
    //napatie = (getMainVoltage()*napatie*2)/4096;
    return napatie;
}

uint32_t getMainVoltage(){
    uint32_t voltage = 0;
    voltage = adc_read(ADCREF_CH); //vysledok 0-4096 z internal reference
    voltage = (1230*4096)/voltage; //vref 1200mV to 1250mV, voltage vypocitane podla referencie
    return voltage;
}