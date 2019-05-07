#include "dsco2_usart1.h"
#include "delay.h"
#include "sys.h"
//////////////////////////////////////////////////////////////////
//�������´���,֧��printf����,������Ҫѡ��use MicroLIB	  
#if 1
#pragma import(__use_no_semihosting)             
//��׼����Ҫ��֧�ֺ���                 
struct __FILE 
{ 
	int handle; 

}; 

FILE __stdout;       
//����_sys_exit()�Ա���ʹ�ð�����ģʽ    
_sys_exit(int x) 
{ 
	x = x; 
} 
//�ض���fputc���� 
int fputc(int ch, FILE *f)
{      
	while((USART1->SR&0X40)==0);//ѭ������,ֱ���������   
    USART1->DR = (u8) ch;      
	return ch;
}
#endif 
 
#if EN_USART1_RX   //���ʹ���˽���
//����1�жϷ������
//ע��,��ȡUSARTx->SR�ܱ���Ī������Ĵ���   	
u8  USART1_RX_BUF[USART1_REC_LEN]; //���ջ���,���USART_REC_LEN���ֽ�.ĩ�ֽ�Ϊ���з� 
u16 USART1_RX_STA;         		   //����״̬���	
u16 CO2ppm;
u8  dsco2_cmd_buf[7];
u8  dsco2_recv_buf[12];
u16 recv_usart1_byte_count;

void Init_USART1(u32 bound)
{
  GPIO_InitTypeDef GPIO_InitStructure;
	USART_InitTypeDef USART_InitStructure;
	NVIC_InitTypeDef NVIC_InitStructure;
	 
	RCC_APB2PeriphClockCmd(RCC_APB2Periph_USART1|RCC_APB2Periph_GPIOA, ENABLE);	//ʹ��USART1��GPIOAʱ��
  
	//USART1_TX   GPIOA.9
  GPIO_InitStructure.GPIO_Pin = GPIO_Pin_9; //PA.9
  GPIO_InitStructure.GPIO_Speed = GPIO_Speed_50MHz;
  GPIO_InitStructure.GPIO_Mode = GPIO_Mode_AF_PP;	//�����������
  GPIO_Init(GPIOA, &GPIO_InitStructure);//��ʼ��GPIOA.9
   
  //USART1_RX	  GPIOA.10��ʼ��
  GPIO_InitStructure.GPIO_Pin = GPIO_Pin_10;//PA10
  GPIO_InitStructure.GPIO_Mode = GPIO_Mode_IN_FLOATING;//��������
  GPIO_Init(GPIOA, &GPIO_InitStructure);//��ʼ��GPIOA.10  

  //Usart1 NVIC ����
  NVIC_InitStructure.NVIC_IRQChannel = USART1_IRQn;
	NVIC_InitStructure.NVIC_IRQChannelPreemptionPriority=3 ;//��ռ���ȼ�3
	NVIC_InitStructure.NVIC_IRQChannelSubPriority = 3;		//�����ȼ�3
	NVIC_InitStructure.NVIC_IRQChannelCmd = ENABLE;			//IRQͨ��ʹ��
	NVIC_Init(&NVIC_InitStructure);	//����ָ���Ĳ�����ʼ��VIC�Ĵ���
  
   //USART ��ʼ������

	USART_InitStructure.USART_BaudRate = bound;//���ڲ�����
	USART_InitStructure.USART_WordLength = USART_WordLength_8b;//�ֳ�Ϊ8λ���ݸ�ʽ
	USART_InitStructure.USART_StopBits = USART_StopBits_1;//һ��ֹͣλ
	USART_InitStructure.USART_Parity = USART_Parity_No;//����żУ��λ
	USART_InitStructure.USART_HardwareFlowControl = USART_HardwareFlowControl_None;//��Ӳ������������
	USART_InitStructure.USART_Mode = USART_Mode_Rx | USART_Mode_Tx;	//�շ�ģʽ

  USART_Init(USART1, &USART_InitStructure); //��ʼ������1
  USART_ITConfig(USART1, USART_IT_RXNE, ENABLE);//�������ڽ����ж�
  USART_Cmd(USART1, ENABLE);                    //ʹ�ܴ���1 

}


void USART1_IRQHandler(void)                	//����3�жϷ������
{

	u8 Res,i;
	if(USART_GetITStatus(USART1, USART_IT_RXNE) != RESET)  //�����ж�(���յ������ݱ�����0x42 0x4d��ͷ)
	{
			Res =USART_ReceiveData(USART1);	//��ȡ���յ�������
			if((USART1_RX_STA&0x8000)==0)//����δ���
			{
				if(USART1_RX_STA&0x4000)//���յ���0x42 0x4d
				{
						USART1_RX_BUF[recv_usart1_byte_count]=Res ;
						recv_usart1_byte_count ++;
					  if (recv_usart1_byte_count==12)
						{				  
							for(i=0;i<12;i++)
							{
								dsco2_recv_buf[i]=USART1_RX_BUF[i];
							}
							DSCO2Convert();
							USART1_RX_STA|=0x8000; //�����ꣻ
						}
						
							
				}
				else //��û�յ�0X4d
				{	
					if(USART1_RX_STA&0x2000)
					{
						if (Res==0x4d)
						{
							USART1_RX_STA|=0x4000;
							USART1_RX_BUF[0]=0x42;
							USART1_RX_BUF[1]=0x4d;
							recv_usart1_byte_count=2;
						}
						else
							USART1_RX_STA=0;
					}
					else
					{
					   if (Res==0x42)	USART1_RX_STA|=0x2000;
						 else 
							 USART1_RX_STA=0;
					}		 
				}
			} 
		
   } 
	


 #if SYSTEM_SUPPORT_OS 	//���SYSTEM_SUPPORT_OSΪ�棬����Ҫ֧��OS.
	OSIntExit();  											 
#endif
} 
#endif	
void Get_DSCO2_Cmd_Data(u8 scmd ,u16 sdata)
{
    u16 lrcdata,temp16data;
    u8 i;
    dsco2_cmd_buf[0]=0x42;
    dsco2_cmd_buf[1]=0x4d;
    dsco2_cmd_buf[2]=scmd;
    dsco2_cmd_buf[3]=sdata>>8;
    dsco2_cmd_buf[4]=sdata;
    lrcdata=0;
    for(i=0;i<5;i++)
     	{
          temp16data = dsco2_cmd_buf[i];
        	lrcdata= lrcdata + temp16data;
        }
    dsco2_cmd_buf[5]=lrcdata>>8;
    dsco2_cmd_buf[6]=lrcdata;
}

u8 DSCO2Convert(void)  // ת�������ֲ���
{  
	  u8 i,succ;
    u8 lrcdatah,lrcdatal;
	  u16 lrcdata,temp16data;
    u16 t16data1,t16data2,t16data3;
    
    succ=0;

	  if((dsco2_recv_buf[0]==0x42)&&(dsco2_recv_buf[1]==0x4d))//�жϹ̶����
    {
        if(dsco2_recv_buf[3]==0x08)//�ж�֡����
        {   
            lrcdata=0;
            for(i=0;i<10;i++)
						{
							temp16data = dsco2_recv_buf[i];
							lrcdata= lrcdata + temp16data;
						}
    		    lrcdatah=lrcdata>>8;
    		    lrcdatal=lrcdata;
    		    if((lrcdatah==dsco2_recv_buf[10])&&(lrcdatal==dsco2_recv_buf[11]))//У���
            {
							t16data1=dsco2_recv_buf[4];
							t16data2=dsco2_recv_buf[5];
							t16data3=((t16data1<<8)&0xff00)|(t16data2&0xff);
							CO2ppm=t16data3;

					
              succ=0;
            }
						else
							succ=3;
        }
				else
					succ=2;
    }
		else
			succ=1;
    return succ;
}	

void SendCmd_DSCO2(u8 cmd)
{  
	u8 i;
  Get_DSCO2_Cmd_Data(cmd,0);
  delay_us(10);

	for(i=0;i<7;i++)
	{
		USART_SendData(USART1,dsco2_cmd_buf[i]);
		while(USART_GetFlagStatus(USART1, USART_FLAG_TXE) == RESET){} //waiting send ok
	}
	delay_us(200);

}
void Init_DSCO2(void)
{ 
	Init_USART1(9600);
//	SendCmd_DSCO2(0xe1);
}

