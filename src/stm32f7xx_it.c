#include "stm32f7xx_it.h"

void NMI_Handler(void){
	__asm("nop");
}

void HardFault_Handler(void){
	__asm("nop");
}

void MemManage_Handler(void){
	__asm("nop");
}

void BusFault_Handler(void){
	__asm("nop");
}

void UsageFault_Handler(void){
	__asm("nop");
}

void SVC_Handler(void){
	__asm("nop");
}

void DebugMon_Handler(void){
	__asm("nop");
}

void PendSV_Handler(void){
	__asm("nop");
}

