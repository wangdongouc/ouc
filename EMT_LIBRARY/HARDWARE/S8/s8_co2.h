#ifndef __S8_CO2_H__
#define __S8_CO2_H__

#include "stdio.h"	
#include "sys.h" 
#define USART3_RECV_LEN  		64  	//�����������ֽ��� 200
#define EN_USART3_RX 			1		//ʹ�ܣ�1��/��ֹ��0������1����
void TIM3_Set(u8 sta);
void TIM3_Init(u16 arr,u16 psc);
void SendCmd_S8(u8 cmd);	  	
void Init_USART3(u32 bound);
void Init_S8(void);//��ʼ��IO   ��ȡУ׼����
u8 S8Convert(void);	//У׼��������ֱ����      
      
#endif

