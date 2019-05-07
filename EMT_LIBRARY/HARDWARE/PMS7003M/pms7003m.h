#ifndef __PMS7003M_H__
#define __PMS7003M_H__
#include "stdio.h"	
#include "sys.h" 

void Get_PMS7003M_Cmd_Data(u8 scmd ,u16 sdata);
void Init_PMS7003M(void);
u8 PMS7003MConvert(void);	//У׼��������ֱ����  
void SendCmd_PMS7003(u8 cmd);
void PMS7003M_Start(void);

#define UART4_REC_LEN  		64  	//�����������ֽ��� 200
#define EN_UART4_RX 			1		//ʹ�ܣ�1��/��ֹ��0������1����
	  	

//����봮���жϽ��գ��벻Ҫע�����º궨��
void Init_UART4(u32 bound);
#endif
      


