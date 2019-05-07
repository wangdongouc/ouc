#include "dsco2.h"
#include "delay.h"
#include "sys.h"

u8  USART3_RX_BUF[USART3_REC_LEN]; //接收缓冲,最大USART_REC_LEN个字节.末字节为换行符 
u16 USART3_RX_STA;         		   //接收状态标记	
u16 CO2ppm;
u8  dsco2_cmd_buf[7];
u8  dsco2_recv_buf[12];
u16 recv_usart3_byte_count;

void Init_USART3(u32 bound)
{
	  //GPIO端口设置
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
	
  
	  //Usart3 NVIC 配置
	
  NVIC_PriorityGroupConfig(NVIC_PriorityGroup_3); 
  NVIC_InitStructure.NVIC_IRQChannel = USART3_IRQn;
	NVIC_InitStructure.NVIC_IRQChannelPreemptionPriority=1 ;//抢占优先级3
	NVIC_InitStructure.NVIC_IRQChannelSubPriority = 1;		//子优先级3
	NVIC_InitStructure.NVIC_IRQChannelCmd = ENABLE;			//IRQ通道使能
	NVIC_Init(&NVIC_InitStructure);	//根据指定的参数初始化VIC寄存器
	
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


void USART3_IRQHandler(void)                	//串口3中断服务程序
{

	u8 Res,i;
	if(USART_GetITStatus(USART3, USART_IT_RXNE) != RESET)  //接收中断(接收到的数据必须是0x42 0x4d开头)
	{
			Res =USART_ReceiveData(USART3);	//读取接收到的数据
			if((USART3_RX_STA&0x8000)==0)//接收未完成
			{
				if(USART3_RX_STA&0x4000)//接收到了0x42 0x4d
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
							USART3_RX_STA|=0x8000; //接受完；
						}
						
							
				}
				else //还没收到0X4d
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

u8 DSCO2Convert(void)  // 转换出各种参数
{  
	  u8 i,succ;
    u8 lrcdatah,lrcdatal;
	  u16 lrcdata,temp16data;
    u16 t16data1,t16data2,t16data3;
    
    succ=0;

	  if((dsco2_recv_buf[0]==0x42)&&(dsco2_recv_buf[1]==0x4d))//判断固定标记
    {
        if(dsco2_recv_buf[3]==0x08)//判断帧长度
        {   
            lrcdata=0;
            for(i=0;i<10;i++)
						{
							temp16data = dsco2_recv_buf[i];
							lrcdata= lrcdata + temp16data;
						}
    		    lrcdatah=lrcdata>>8;
    		    lrcdatal=lrcdata;
    		    if((lrcdatah==dsco2_recv_buf[10])&&(lrcdatal==dsco2_recv_buf[11]))//校验和
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

