#ifndef __DSCO2_H__
#define __DSCO2_H__

#include "stdio.h"	
#include "sys.h" 
#define USART1_REC_LEN  		100  	//�����������ֽ��� 200
#define EN_USART1_RX 			1		//ʹ�ܣ�1��/��ֹ��0������1����

void Get_DSCO2_Cmd_Data(u8 scmd ,u16 sdata);
void SendCmd_DSCO2(u8 cmd);	  	
void Init_USART1(u32 bound);
void Init_DSCO2(void);//��ʼ��IO   ��ȡУ׼����
u8 DSCO2Convert(void);	//У׼��������ֱ����      
      
#endif

