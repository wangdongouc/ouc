#include "s8_co2.h"
#include "delay.h"
#include "sys.h"
 
 
#if EN_USART3_RX   //���ʹ���˽���
u8  USART3_RX_BUF[USART3_RECV_LEN]; //���ջ���,���USART_REC_LEN���ֽ�.ĩ�ֽ�Ϊ���з� 
u16 USART3_RX_STA;         		   //����״̬���	
u16 CO2ppm;
u8  s8_cmd_buf[8]={0xFE,0x04,0x00,0x03,0x00,0x01,0xD5,0xC5};
u8  dsco2_recv_buf[12];
u8  recv_usart3_byte_count;

void Init_USART3(u32 bound)
{
	  //GPIO�˿�����
  GPIO_InitTypeDef GPIO_InitStructure;
	USART_InitTypeDef USART_InitStructure;
	NVIC_InitTypeDef NVIC_InitStructure;

	RCC_APB2PeriphClockCmd(RCC_APB2Periph_GPIOB|RCC_APB2Periph_AFIO ,ENABLE);
  RCC_APB1PeriphClockCmd(RCC_APB1Periph_USART3,ENABLE);

	//USART3_TX   GPIOB.10
  GPIO_InitStructure.GPIO_Pin = GPIO_Pin_10; //Pc.10
  GPIO_InitStructure.GPIO_Speed = GPIO_Speed_50MHz;
  GPIO_InitStructure.GPIO_Mode = GPIO_Mode_AF_PP;	//�����������
  GPIO_Init(GPIOB, &GPIO_InitStructure);//��ʼ��GPIOA.9
   
  //USART3_RX	  GPIOB.11��ʼ��
  GPIO_InitStructure.GPIO_Pin = GPIO_Pin_11;//Pc11
  GPIO_InitStructure.GPIO_Mode = GPIO_Mode_IN_FLOATING;//��������
  GPIO_Init(GPIOB, &GPIO_InitStructure);//��ʼ��GPIOA.10  
	
  
	//Usart3 NVIC ����
	
  NVIC_InitStructure.NVIC_IRQChannel = USART3_IRQn;
	NVIC_InitStructure.NVIC_IRQChannelPreemptionPriority=3 ;//��ռ���ȼ�3
	NVIC_InitStructure.NVIC_IRQChannelSubPriority = 2;		//�����ȼ�3
	NVIC_InitStructure.NVIC_IRQChannelCmd = ENABLE;			//IRQͨ��ʹ��
	NVIC_Init(&NVIC_InitStructure);	//����ָ���Ĳ�����ʼ��VIC�Ĵ���
	
	USART_InitStructure.USART_BaudRate = bound;
	USART_InitStructure.USART_WordLength = USART_WordLength_8b;
	USART_InitStructure.USART_StopBits = USART_StopBits_1;
	USART_InitStructure.USART_Parity = USART_Parity_No;
	USART_InitStructure.USART_HardwareFlowControl = USART_HardwareFlowControl_None;
	USART_InitStructure.USART_Mode = USART_Mode_Rx | USART_Mode_Tx;
	
	USART_Init(USART3, &USART_InitStructure);
	USART_ITConfig(USART3, USART_IT_RXNE,ENABLE);
	USART_Cmd(USART3, ENABLE);

}


void USART3_IRQHandler(void)                	//����3�жϷ������
{
	u8 res;	    
	if(USART_GetITStatus(USART3, USART_IT_RXNE) != RESET)//���յ�����
	{	 
		res =USART_ReceiveData(USART3);		
		if(USART3_RX_STA<USART3_RECV_LEN)		//�����Խ�������
		{
			TIM_SetCounter(TIM3,0);//���������        				 
			if(USART3_RX_STA==0)
				TIM3_Set(1);	 	//ʹ�ܶ�ʱ��3���ж� 
			USART3_RX_BUF[USART3_RX_STA++]=res;		//��¼���յ���ֵ	 
		}
		else 
		{
			
			USART3_RX_STA=0x0000;					//ǿ�Ʊ�ǽ������
		} 
	}   
 
#if SYSTEM_SUPPORT_OS 	//���SYSTEM_SUPPORT_OSΪ�棬����Ҫ֧��OS.
	OSIntExit();  											 
#endif
} 
//��ʱ��4�жϷ������		    
void TIM3_IRQHandler(void)
{ 	
	if (TIM_GetITStatus(TIM3, TIM_IT_Update) != RESET)//�Ǹ����ж�
	{	
		S8Convert(); 			   
		USART3_RX_STA|=0x8000;	//��ǽ������
		
		TIM_ClearITPendingBit(TIM3, TIM_IT_Update  );  //���TIMx�����жϱ�־    
		TIM3_Set(0);			//�ر�TIM3  
	}	    
}
//����TIM4�Ŀ���
//sta:0���ر�;1,����;
void TIM3_Set(u8 sta)
{
	if(sta)
	{
       
		TIM_SetCounter(TIM3,0);//���������
		TIM_Cmd(TIM3, ENABLE);  //ʹ��TIMx	
	}else TIM_Cmd(TIM3, DISABLE);//�رն�ʱ��4	   
}
//ͨ�ö�ʱ���жϳ�ʼ��
//����ʼ��ѡ��ΪAPB1��2������APB1Ϊ36M
//arr���Զ���װֵ��
//psc��ʱ��Ԥ��Ƶ��		 
void TIM3_Init(u16 arr,u16 psc)
{	
	NVIC_InitTypeDef NVIC_InitStructure;
	TIM_TimeBaseInitTypeDef  TIM_TimeBaseStructure;

	RCC_APB1PeriphClockCmd(RCC_APB1Periph_TIM3, ENABLE); //ʱ��ʹ��//TIM4ʱ��ʹ��    
	
	//��ʱ��TIM3��ʼ��
	TIM_TimeBaseStructure.TIM_Period = arr; //��������һ�������¼�װ�����Զ���װ�ؼĴ������ڵ�ֵ	
	TIM_TimeBaseStructure.TIM_Prescaler =psc; //����������ΪTIMxʱ��Ƶ�ʳ�����Ԥ��Ƶֵ
	TIM_TimeBaseStructure.TIM_ClockDivision = TIM_CKD_DIV1; //����ʱ�ӷָ�:TDTS = Tck_tim
	TIM_TimeBaseStructure.TIM_CounterMode = TIM_CounterMode_Up;  //TIM���ϼ���ģʽ
	TIM_TimeBaseInit(TIM3, &TIM_TimeBaseStructure); //����ָ���Ĳ�����ʼ��TIMx��ʱ�������λ
 
	TIM_ITConfig(TIM3,TIM_IT_Update,ENABLE ); //ʹ��ָ����TIM4�ж�,��������ж�

	 	  
	NVIC_InitStructure.NVIC_IRQChannel = TIM3_IRQn;
	NVIC_InitStructure.NVIC_IRQChannelPreemptionPriority=1 ;//��ռ���ȼ�3
	NVIC_InitStructure.NVIC_IRQChannelSubPriority = 3;		//�����ȼ�3
	NVIC_InitStructure.NVIC_IRQChannelCmd = ENABLE;			//IRQͨ��ʹ��
	NVIC_Init(&NVIC_InitStructure);	//����ָ���Ĳ�����ʼ��VIC�Ĵ���
	
}
#endif		



u8 S8Convert(void)  // ת�������ֲ���
{  
	  u8 i,succ;
    u8 lrcdatah,lrcdatal;
	  u16 lrcdata,temp16data;
    u16 t16data1,t16data2,t16data3;
    
    succ=0;
		for(i=0;i<7;i++)
		{
			dsco2_recv_buf[i]=USART3_RX_BUF[i];
		}
	  if((dsco2_recv_buf[0]==0xfe)&&(dsco2_recv_buf[1]==0x04))//�жϹ̶����
    {
			for(i=0;i<5;i++)
			{
				temp16data = dsco2_recv_buf[i];
				lrcdata= lrcdata + temp16data;
			}
			lrcdatah=lrcdata>>8;
			lrcdatal=lrcdata;
			
				t16data1=dsco2_recv_buf[3];
				t16data2=dsco2_recv_buf[4];
				t16data3=((t16data1<<8)&0xff00)|(t16data2&0xff);
				CO2ppm=t16data3;
			if((lrcdatah==dsco2_recv_buf[5])&&(lrcdatal==dsco2_recv_buf[6]))//У���
			{
				t16data1=dsco2_recv_buf[3];
				t16data2=dsco2_recv_buf[4];
				t16data3=((t16data1<<8)&0xff00)|(t16data2&0xff);
				CO2ppm=t16data3;
				succ=0;
			}
			else
				succ=2;
    }
		else
			succ=1;
    return succ;
}	

void SendCmd_S8(u8 cmd)
{  
	u8 i;
	for(i=0;i<8;i++)
	{
		USART_SendData(USART3,s8_cmd_buf[i]);
		while(USART_GetFlagStatus(USART3, USART_FLAG_TXE) == RESET){} //waiting send ok
	}
	delay_us(200);

}
void Init_S8(void)
{ 
	Init_USART3(9600);
	TIM3_Init(999,7199);		//10ms�ж�
	USART3_RX_STA=0;		//����
	TIM3_Set(0);			//�رն�ʱ��4
}

