#include "tjc3224t024_11.h"
#include "delay.h"
#include "sys.h"


u8 cur_screen=0;
 
#if EN_UART5_RX   //���ʹ���˽���

u8  UART5_RX_BUF[UART5_REC_LEN]; //���ջ���,���USART_REC_LEN���ֽ�.ĩ�ֽ�Ϊ���з� 
u16 UART5_RX_STA=0;         		   //����״̬���	

  
void Init_UART5(u32 bound)
{
  //GPIO�˿�����
  GPIO_InitTypeDef GPIO_InitStructure;
	USART_InitTypeDef USART_InitStructure;
	NVIC_InitTypeDef NVIC_InitStructure;
	 
	
	RCC_APB2PeriphClockCmd( RCC_APB2Periph_AFIO | RCC_APB2Periph_GPIOC | RCC_APB2Periph_GPIOD, ENABLE);
  RCC_APB1PeriphClockCmd(RCC_APB1Periph_UART5 ,ENABLE);
  
	//UART5_TX   GPIOC.12
  GPIO_InitStructure.GPIO_Pin = GPIO_Pin_12; //PC12
  GPIO_InitStructure.GPIO_Speed = GPIO_Speed_50MHz;
  GPIO_InitStructure.GPIO_Mode = GPIO_Mode_AF_PP;	//�����������
  GPIO_Init(GPIOC, &GPIO_InitStructure);//��ʼ
   
  //UART5_RX	  GPIOD.2��ʼ��
  GPIO_InitStructure.GPIO_Pin = GPIO_Pin_2;//PD2
  GPIO_InitStructure.GPIO_Mode = GPIO_Mode_IN_FLOATING;//��������
  GPIO_Init(GPIOD, &GPIO_InitStructure);//��ʼ

  //Usart1 NVIC ����
  NVIC_InitStructure.NVIC_IRQChannel = UART5_IRQn;
	NVIC_InitStructure.NVIC_IRQChannelPreemptionPriority=3 ;//��ռ���ȼ�3
	NVIC_InitStructure.NVIC_IRQChannelSubPriority = 1;		//�����ȼ�3
	NVIC_InitStructure.NVIC_IRQChannelCmd = ENABLE;			//IRQͨ��ʹ��
	NVIC_Init(&NVIC_InitStructure);	//����ָ���Ĳ�����ʼ��VIC�Ĵ���
  
   //USART ��ʼ������

	USART_InitStructure.USART_BaudRate = bound;//���ڲ�����
	USART_InitStructure.USART_WordLength = USART_WordLength_8b;//�ֳ�Ϊ8λ���ݸ�ʽ
	USART_InitStructure.USART_StopBits = USART_StopBits_1;//һ��ֹͣλ
	USART_InitStructure.USART_Parity = USART_Parity_No;//����żУ��λ
	USART_InitStructure.USART_HardwareFlowControl = USART_HardwareFlowControl_None;//��Ӳ������������
	USART_InitStructure.USART_Mode = USART_Mode_Rx | USART_Mode_Tx;	//�շ�ģʽ

  USART_Init(UART5, &USART_InitStructure); //��ʼ������5
  USART_ITConfig(UART5, USART_IT_RXNE, ENABLE);//�������ڽ����ж�
  USART_Cmd(UART5, ENABLE);                    //ʹ�ܴ���5

}



void UART5_IRQHandler(void)                	//����5�жϷ������
	{
	u8 Res;
#if SYSTEM_SUPPORT_OS 		//���SYSTEM_SUPPORT_OSΪ�棬����Ҫ֧��OS.
	OSIntEnter();    
#endif
	if(USART_GetITStatus(UART5, USART_IT_RXNE) != RESET)  //�����ж�(���յ������ݱ�����0x0d 0x0a��β)
		{
		Res =USART_ReceiveData(UART5);	//��ȡ���յ�������
		
		if((UART5_RX_STA&0x8000)==0)//����δ���
			{
			if(UART5_RX_STA&0x4000)//���յ���0x0d
				{
				if(Res!=0x0A)UART5_RX_STA=0;//���մ���,���¿�ʼ
				else UART5_RX_STA|=0x8000;	//��������� 
				}
			else //��û�յ�0X0D
				{	
				if(Res==0x0D)UART5_RX_STA|=0x4000;
				else
					{
					UART5_RX_BUF[UART5_RX_STA&0X3FFF]=Res ;
					UART5_RX_STA++;
					if(UART5_RX_STA>(UART5_REC_LEN-1))UART5_RX_STA=0;//�������ݴ���,���¿�ʼ����	  
					}		 
				}
			}   		 
     } 
#if SYSTEM_SUPPORT_OS 	//���SYSTEM_SUPPORT_OSΪ�棬����Ҫ֧��OS.
	OSIntExit();  											 
#endif
} 
#endif	


void SendCmd_HMI(u8 *cmdstr,u8 len)
{  
	u8 i;
	for (i=0;i<len;i++)
	{
  		USART_SendData(UART5,cmdstr[i]);
			while(USART_GetFlagStatus(UART5, USART_FLAG_TXE) == RESET){} //waiting send ok
	}
		for (i=0;i<3;i++)
	{
  		USART_SendData(UART5,0xff);
			while(USART_GetFlagStatus(UART5, USART_FLAG_TXE) == RESET){} //waiting send ok
	}
}
void Init_HMI(void)
{ 
	Init_UART5(9600);
  
}





