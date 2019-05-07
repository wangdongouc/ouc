#ifndef __PMS7003M_H__
#define __PMS7003M_H__
#include "stdio.h"	
#include "sys.h" 

void Get_PMS7003M_Cmd_Data(u8 scmd ,u16 sdata);
void Init_PMS7003M(void);
u8 PMS7003MConvert(void);	//校准，将结果分别存入  
void SendCmd_PMS7003(u8 cmd);
void PMS7003M_Start(void);

#define UART4_REC_LEN  		64  	//定义最大接收字节数 200
#define EN_UART4_RX 			1		//使能（1）/禁止（0）串口1接收
	  	

//如果想串口中断接收，请不要注释以下宏定义
void Init_UART4(u32 bound);
#endif
      


