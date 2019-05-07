#ifndef __S8_CO2_H__
#define __S8_CO2_H__

#include "stdio.h"	
#include "sys.h" 
#define USART3_RECV_LEN  		64  	//定义最大接收字节数 200
#define EN_USART3_RX 			1		//使能（1）/禁止（0）串口1接收
void TIM3_Set(u8 sta);
void TIM3_Init(u16 arr,u16 psc);
void SendCmd_S8(u8 cmd);	  	
void Init_USART3(u32 bound);
void Init_S8(void);//初始化IO   读取校准参数
u8 S8Convert(void);	//校准，将结果分别存入      
      
#endif

