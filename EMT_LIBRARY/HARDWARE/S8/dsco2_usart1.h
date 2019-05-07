#ifndef __DSCO2_H__
#define __DSCO2_H__

#include "stdio.h"	
#include "sys.h" 
#define USART1_REC_LEN  		100  	//定义最大接收字节数 200
#define EN_USART1_RX 			1		//使能（1）/禁止（0）串口1接收

void Get_DSCO2_Cmd_Data(u8 scmd ,u16 sdata);
void SendCmd_DSCO2(u8 cmd);	  	
void Init_USART1(u32 bound);
void Init_DSCO2(void);//初始化IO   读取校准参数
u8 DSCO2Convert(void);	//校准，将结果分别存入      
      
#endif

