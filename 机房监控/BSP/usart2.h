#ifndef __USART2_H
#define __USART2_H

#include "stm32f10x.h"
#include "stdio.h"
#include "stdarg.h"		 
#include "string.h"	

#define USART2_REC_LEN  		2048     //定义串口2最大接收字节数 1024
#define USART2_TRS_LEN          1024     //定义串口2最大接发送节数 1024
#define EN_USART2_RX 			1		 //使能（1）/禁止（0）串口2接收
	  	
extern u8  USART2_RX_BUF[USART2_REC_LEN]; //串口2接收缓冲,最大USART2_REC_LEN个字节.末字节为换行符 
extern u8  USART2_TX_BUF[USART2_TRS_LEN]; //串口2发送缓冲,最大USART2_TRS_LEN个字节.末字节为换行符
extern u16 USART2_RX_STA;         		  //串口2接收状态标记	
extern u8  USART2_DATA_FLAG;               //数据接收标记

void uart2_init(u32 bound);
void u2_printf(char* fmt,...);
#endif
