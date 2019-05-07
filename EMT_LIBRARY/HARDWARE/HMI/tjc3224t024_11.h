#ifndef __tjc3224t024_11_H__
#define __tjc3224t024_11_H__
#include "stdio.h"	
#include "sys.h" 


void Init_HMI(void);
void SendCmd_HMI(u8 *cmdstr,u8 len);

#define UART5_REC_LEN  		64  	//定义最大接收字节数 200
#define EN_UART5_RX 			1		//使能（1）/禁止（0）串口1接收
void Init_UART5(u32 bound);

#endif
      


