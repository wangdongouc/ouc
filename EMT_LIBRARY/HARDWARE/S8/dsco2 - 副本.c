#include "dsco2.h"
#include "delay.h"
#include "sys.h"

u8  USART3_RX_BUF[USART3_REC_LEN]; //���ջ���,���USART_REC_LEN���ֽ�.ĩ�ֽ�Ϊ���з� 
u16 USART3_RX_STA;         		   //����״̬���	
u16 CO2ppm;
u8  dsco2_cmd_buf[7];
u8  dsco2_recv_buf[12];
u16 recv_usart3_byte_count;

void Init_USART3(u32 bound)
{
	  //GPIO�˿�����
  GPIO_InitTypeDef GPIO_InitStructure;
	USART_InitTypeDef USART_InitStructure;
	NVIC_InitTypeDef NVIC_InitStructure;

	RCC_APB2PeriphClockCmd(RCC_APB1Periph_USART3 | RCC_APB2Periph_GPIOB,ENABLE);
	
	GPIO_InitStructure.GPIO_Pin = GPIO_Pin_10;
	GPIO_InitStructure.GPIO_Mode = GPIO_Mode_AF_PP;
	GPIO_InitStructure.GPIO_Speed = GPIO_Speed_50MHz;
	GPIO_Init(GPIOB, &GPIO_InitStructure);
	GPIO_InitStructure.GPIO_Pin = GPIO_Pin_11;
	GPIO_InitStructure.GPIO_Mode = GPIO_Mode_IN_FLOATING;
	GPIO_InitStructure.GPIO_Speed = GPIO_Speed_50MHz;
	GPIO_Init(GPIOB, &GPIO_InitStructure);
	
  
	  //Usart3 NVIC ����
	
  NVIC_PriorityGroupConfig(NVIC_PriorityGroup_3); 
  NVIC_InitStructure.NVIC_IRQChannel = USART3_IRQn;
	NVIC_InitStructure.NVIC_IRQChannelPreemptionPriority=1 ;//��ռ���ȼ�3
	NVIC_InitStructure.NVIC_IRQChannelSubPriority = 1;		//�����ȼ�3
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

	u8 Res,i;
	if(USART_GetITStatus(USART3, USART_IT_RXNE) != RESET)  //�����ж�(���յ������ݱ�����0x42 0x4d��ͷ)
	{
			Res =USART_ReceiveData(USART3);	//��ȡ���յ�������
			if((USART3_RX_STA&0x8000)==0)//����δ���
			{
				if(USART3_RX_STA&0x4000)//���յ���0x42 0x4d
				{
						USART3_RX_BUF[recv_usart3_byte_count]=Res ;
						recv_usart3_byte_count ++;
					  if (recv_usart3_byte_count==12)
						{				  
							for(i=0;i<12;i++)
							{
								dsco2_recv_buf[i]=USART3_RX_BUF[i];
							}
							DSCO2Convert();
							USART3_RX_STA|=0x8000; //�����ꣻ
						}
						
							
				}
				else //��û�յ�0X4d
				{	
					if(USART3_RX_STA&0x2000)
					{
						if (Res==0x4d)
						{
							USART3_RX_STA|=0x4000;
							USART3_RX_BUF[0]=0x42;
							USART3_RX_BUF[1]=0x4d;
							recv_usart3_byte_count=2;
						}
						else
							USART3_RX_STA=0;
					}
					else
					{
					   if (Res==0x42)	USART3_RX_STA|=0x2000;
						 else 
							 USART3_RX_STA=0;
					}		 
				}
			} 
		
   } 
	
 }
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
		USART_SendData(USART3,dsco2_cmd_buf[i]);
	}
	delay_us(200);

}
void Init_DSCO2(void)
{ 
	Init_USART3(9600);
//	SendCmd_DSCO2(0xe1);
}

