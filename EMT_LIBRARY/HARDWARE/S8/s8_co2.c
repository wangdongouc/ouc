#include "s8_co2.h"
#include "delay.h"
#include "sys.h"
 
 
#if EN_USART3_RX   //如果使能了接收
u8  USART3_RX_BUF[USART3_RECV_LEN]; //接收缓冲,最大USART_REC_LEN个字节.末字节为换行符 
u16 USART3_RX_STA;         		   //接收状态标记	
u16 CO2ppm;
u8  s8_cmd_buf[8]={0xFE,0x04,0x00,0x03,0x00,0x01,0xD5,0xC5};
u8  dsco2_recv_buf[12];
u8  recv_usart3_byte_count;

void Init_USART3(u32 bound)
{
	  //GPIO端口设置
  GPIO_InitTypeDef GPIO_InitStructure;
	USART_InitTypeDef USART_InitStructure;
	NVIC_InitTypeDef NVIC_InitStructure;

	RCC_APB2PeriphClockCmd(RCC_APB2Periph_GPIOB|RCC_APB2Periph_AFIO ,ENABLE);
  RCC_APB1PeriphClockCmd(RCC_APB1Periph_USART3,ENABLE);

	//USART3_TX   GPIOB.10
  GPIO_InitStructure.GPIO_Pin = GPIO_Pin_10; //Pc.10
  GPIO_InitStructure.GPIO_Speed = GPIO_Speed_50MHz;
  GPIO_InitStructure.GPIO_Mode = GPIO_Mode_AF_PP;	//复用推挽输出
  GPIO_Init(GPIOB, &GPIO_InitStructure);//初始化GPIOA.9
   
  //USART3_RX	  GPIOB.11初始化
  GPIO_InitStructure.GPIO_Pin = GPIO_Pin_11;//Pc11
  GPIO_InitStructure.GPIO_Mode = GPIO_Mode_IN_FLOATING;//浮空输入
  GPIO_Init(GPIOB, &GPIO_InitStructure);//初始化GPIOA.10  
	
  
	//Usart3 NVIC 配置
	
  NVIC_InitStructure.NVIC_IRQChannel = USART3_IRQn;
	NVIC_InitStructure.NVIC_IRQChannelPreemptionPriority=3 ;//抢占优先级3
	NVIC_InitStructure.NVIC_IRQChannelSubPriority = 2;		//子优先级3
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
	u8 res;	    
	if(USART_GetITStatus(USART3, USART_IT_RXNE) != RESET)//接收到数据
	{	 
		res =USART_ReceiveData(USART3);		
		if(USART3_RX_STA<USART3_RECV_LEN)		//还可以接收数据
		{
			TIM_SetCounter(TIM3,0);//计数器清空        				 
			if(USART3_RX_STA==0)
				TIM3_Set(1);	 	//使能定时器3的中断 
			USART3_RX_BUF[USART3_RX_STA++]=res;		//记录接收到的值	 
		}
		else 
		{
			
			USART3_RX_STA=0x0000;					//强制标记接收完成
		} 
	}   
 
#if SYSTEM_SUPPORT_OS 	//如果SYSTEM_SUPPORT_OS为真，则需要支持OS.
	OSIntExit();  											 
#endif
} 
//定时器4中断服务程序		    
void TIM3_IRQHandler(void)
{ 	
	if (TIM_GetITStatus(TIM3, TIM_IT_Update) != RESET)//是更新中断
	{	
		S8Convert(); 			   
		USART3_RX_STA|=0x8000;	//标记接收完成
		
		TIM_ClearITPendingBit(TIM3, TIM_IT_Update  );  //清除TIMx更新中断标志    
		TIM3_Set(0);			//关闭TIM3  
	}	    
}
//设置TIM4的开关
//sta:0，关闭;1,开启;
void TIM3_Set(u8 sta)
{
	if(sta)
	{
       
		TIM_SetCounter(TIM3,0);//计数器清空
		TIM_Cmd(TIM3, ENABLE);  //使能TIMx	
	}else TIM_Cmd(TIM3, DISABLE);//关闭定时器4	   
}
//通用定时器中断初始化
//这里始终选择为APB1的2倍，而APB1为36M
//arr：自动重装值。
//psc：时钟预分频数		 
void TIM3_Init(u16 arr,u16 psc)
{	
	NVIC_InitTypeDef NVIC_InitStructure;
	TIM_TimeBaseInitTypeDef  TIM_TimeBaseStructure;

	RCC_APB1PeriphClockCmd(RCC_APB1Periph_TIM3, ENABLE); //时钟使能//TIM4时钟使能    
	
	//定时器TIM3初始化
	TIM_TimeBaseStructure.TIM_Period = arr; //设置在下一个更新事件装入活动的自动重装载寄存器周期的值	
	TIM_TimeBaseStructure.TIM_Prescaler =psc; //设置用来作为TIMx时钟频率除数的预分频值
	TIM_TimeBaseStructure.TIM_ClockDivision = TIM_CKD_DIV1; //设置时钟分割:TDTS = Tck_tim
	TIM_TimeBaseStructure.TIM_CounterMode = TIM_CounterMode_Up;  //TIM向上计数模式
	TIM_TimeBaseInit(TIM3, &TIM_TimeBaseStructure); //根据指定的参数初始化TIMx的时间基数单位
 
	TIM_ITConfig(TIM3,TIM_IT_Update,ENABLE ); //使能指定的TIM4中断,允许更新中断

	 	  
	NVIC_InitStructure.NVIC_IRQChannel = TIM3_IRQn;
	NVIC_InitStructure.NVIC_IRQChannelPreemptionPriority=1 ;//抢占优先级3
	NVIC_InitStructure.NVIC_IRQChannelSubPriority = 3;		//子优先级3
	NVIC_InitStructure.NVIC_IRQChannelCmd = ENABLE;			//IRQ通道使能
	NVIC_Init(&NVIC_InitStructure);	//根据指定的参数初始化VIC寄存器
	
}
#endif		



u8 S8Convert(void)  // 转换出各种参数
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
	  if((dsco2_recv_buf[0]==0xfe)&&(dsco2_recv_buf[1]==0x04))//判断固定标记
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
			if((lrcdatah==dsco2_recv_buf[5])&&(lrcdatal==dsco2_recv_buf[6]))//校验和
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
	TIM3_Init(999,7199);		//10ms中断
	USART3_RX_STA=0;		//清零
	TIM3_Set(0);			//关闭定时器4
}

