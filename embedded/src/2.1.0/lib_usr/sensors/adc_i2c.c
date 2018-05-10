#include "adc_i2c.h"

#define ADC_ADDRESS 0x9B//0b10011011

uint32_t getChargingVoltage(){

//citaj i2c start 7bit adresa 1001101 R/W cakaj ack, read 1 daj ack read 2 daj nack
    uint32_t napatie = 0;
    
    napatie = read_i2c_adc();
    if(napatie != -1){
        napatie = (napatie*3300)/1024*2;
        return napatie;
    }else{
        return -1;
    }
    
}

uint32_t read_i2c_adc(){
    u8 high = 0;
    u8 low = 0;
    uint32_t ret = 0;
    i2cStart();

    int cont = i2cWrite(ADC_ADDRESS);
    if(cont == OK_I2C_ACK){
    high = i2cRead(1);
    low = i2cRead(0);
    i2cStop();
    
    ret = high;
    ret = ret<<6;
    ret |= low >> 2;
    
    return ret;
    }
    i2cStop();
    return -1;
}