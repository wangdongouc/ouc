/******************** (C) COPYRIGHT  源地工作室 ********************************
 * 文件名  ：main.c
 * 描述    :本例程中，ESP8266模块工作在STA（UDP）模式，即终端模式。需要连接无线路由器或是其他的AP模式  
 * 库版本  ：V3.50
 * 作者    ：zhuoyingxingyu
 * 淘宝    ：源地工作室http://vcc-gnd.taobao.com/
 * 论坛地址：极客园地-嵌入式开发论坛http://vcc-gnd.com/
 * 版本更新: 2016-03-08
 * 调试方式：J-Link-OB
**********************************************************************************/	

#include "delay.h"
#include "led.h"
#include "esp8266.h"
#include "usart.h"
#include "usart2.h"
#include "OLED.h"
#include "fonts.h"
#include "SHT2X.h"
#include "SHT2X2.h"
#include "rtc.h"

u8  Data_buff[1024];     //数据缓冲区
u8  Data_len[5];         //数据长度缓冲区
u8  Data_id[5];          //数据发送者的id缓冲区

extern u8 IP_Buff[20]; 
/**
  * @file   main
  * @brief  Main program.
  * @param  None
  * @retval None
  */
int main(void)
{	
  u8 res1;
  u16 len,time;
	u8 i=0;
  u8  error = 0;              //variable for error code. For codes see system.h
  u8  userRegister;           //variable for user register
	u8  userRegister2;           //variable for user register
  u16 sRH[1];                    //variable for raw humidity ticks
  u16 sT[1];                     //variable for raw temperature ticks 
	u16 sRH2[1];                    //variable for raw humidity ticks
  u16 sT2[1];                     //variable for raw temperature ticks 
	float   humidityRH;             //variable for relative humidity[%RH] as float
  float   temperatureC;           //variable for temperature[?] as float
	float   humidityRH2;             //variable for relative humidity[%RH] as float
  float   temperatureC2;           //variable for temperature[?] as float
  u8  SerialNumber_SHT2x[8];  //64bit serial number
	u8  SerialNumber_SHT2x2[8];  //64bit serial number
	   
  SYSTICK_Init();	    //延时函数初始化
  delay_ms(1500);     //等待芯片上电复位成功
	LED_GPIO_Config();//初始化LED
  USART1_Config(9600);	//串口初始化
  uart2_init(115200);	//串口初始化
	printf("\r\n系统启动...\r\n");

	OLED_Init(); 
  SHT2X_Configuration();
  SHT2X2_Configuration();
	OLED_ClrScr(0);
	OLED_DispStr(0,  0, "System start-up", &tFont12);  	

	
//	
//	DateTimeDis_Init();
 // RTC_Init();
  ESP8266_Exit_Transfer(10);//检测是否在透传状态，如果在则退出
	
	OLED_DispStr(0,15, "connect network", &tFont12); 
  printf("ESP8266准备连接服务器!\r\n");
  res1=ESP8266_STA_UDP_Init();
  switch(res1)
  {
    case 0  :  printf("ESP8266设置UDP成功，并成功进入透传模式\r\n");break;
    case 1  :  printf("ESP8266软件复位失败! 准备重启系统\r\n");NVIC_SystemReset();break;
    case 2  :  printf("ESP8266设置STA模式失败! 准备重启系统\r\n");NVIC_SystemReset();break;
    case 3  :  printf("ESP8266连接AP失败!,准备重启系统\r\n");NVIC_SystemReset();break;
    case 4  :  printf("ESP8266的IP获取失败!,准备重启系统\r\n");NVIC_SystemReset();break;
    case 5  :  printf("ESP8266开启透传失败!,准备重启系统\r\n");NVIC_SystemReset();break;
    case 6  :  printf("ESP8266关闭多路连接失败!,准备重启系统\r\n");NVIC_SystemReset();break;
    case 7  :  printf("ESP8266设置UDP失败!,准备重启系统\r\n");NVIC_SystemReset();break;
    case 8  :  printf("ESP8266进入透传失败!,准备重启系统\r\n");NVIC_SystemReset();break;
  }
	OLED_DispStr(0,30, "connected!", &tFont12); 
  USART2_DATA_FLAG=1;  //标记进入数据透传了
  USART2_RX_STA=0;  
  memset(USART2_RX_BUF,0,USART2_REC_LEN); //清除串口2数据
  OLED_DispStr(12, 45,(char*)IP_Buff, &tFont12);
	delay_ms(1500);
	OLED_ClrScr(0);
  OLED_DispStr(10,  0, "A温度:", &tFont12);  	
	OLED_DispStr(95,  0, "℃", &tFont12);
	OLED_DispStr(10, 15, "A湿度:", &tFont12);    
	OLED_DispStr(95, 15, "%", &tFont12);
	OLED_DispStr(10,  30, "B温度:", &tFont12);  	
	OLED_DispStr(95,  30, "℃", &tFont12);
	OLED_DispStr(10, 45, "B湿度:", &tFont12);    
	OLED_DispStr(95, 45, "%", &tFont12);
  while(1)
  {

    if(USART2_RX_STA&0x8000)
    {
      len=USART2_RX_STA&0x7FFF;
      memcpy(Data_buff,USART2_RX_BUF,len);
      USART2_RX_STA=0;
      Data_buff[len]='\0';			
      printf("有数据发来\r\n");
      printf("数据:%s\r\n",Data_buff);
      u2_printf("%s",Data_buff);		
    }
    if(time>=10000)
    {
			OLED_ClrScr(0);
     	OLED_DispStr(10,  0, "A温度:", &tFont12);  	
			OLED_DispStr(95,  0, "℃", &tFont12);
			OLED_DispStr(10, 15, "A湿度:", &tFont12);    
			OLED_DispStr(95, 15, "%", &tFont12);
			
			OLED_DispStr(10,  30, "B温度:", &tFont12);  	
			OLED_DispStr(95,  30, "℃", &tFont12);
			OLED_DispStr(10, 45, "B湿度:", &tFont12);    
			OLED_DispStr(95, 45, "%", &tFont12);
			time=0;
    }
		if(time%100==0)
		{
			error = 0;                                       // reset error status
//			// --- Reset sensor by command ---
//			error |= SHT2x_SoftReset();
//			// --- Read the sensors serial number (64bit) ---
//			error |= SHT2x_GetSerialNumber(SerialNumber_SHT2x);
//			printf("GetSerialNumber=");
//			for(i=0;i<7;i++)
//			{
//			printf("%d",SerialNumber_SHT2x[i]);
//			}
//			printf("\r\n");

			// --- Set Resolution e.g. RH 10bit, Temp 13bit ---
			error |= SHT2x_ReadUserRegister(&userRegister);  //get actual user reg
			userRegister = (userRegister & ~SHT2x_RES_MASK) | SHT2x_RES_10_13BIT;
			error |= SHT2x_WriteUserRegister(&userRegister); //write changed user reg
			error |= SHT2x_ReadUserRegister(&userRegister);  //get actual user reg
			// --- measure humidity with "Hold Master Mode (HM)"  ---
			error |= SHT2x_MeasureHM(HUMIDITY, sRH);
			error |= SHT2x_MeasureHM(TEMP, sT);
			//printf("1:%8x  %8x\r\n",sRH[0], sT[0]);
			//-- calculate humidity and temperature --
			temperatureC= SHT2x_CalcTemperatureC(sT[0]);
			humidityRH = SHT2x_CalcRH(sRH[0]);
			printf("C1=%3.2f;RH1=%3.2f\r\n",temperatureC,humidityRH);
			error = 0; 
						// --- Reset sensor by command ---
//			error |= SHT2x2_SoftReset();
//			// --- Read the sensors serial number (64bit) ---
//			error |= SHT2x2_GetSerialNumber(SerialNumber_SHT2x2);
//			printf("GetSerialNumber2=");
//			for(i=0;i<7;i++)
//			{
//			printf("%d",SerialNumber_SHT2x2[i]);
//			}
//			printf("\r\n");
			error |= SHT2x2_ReadUserRegister(&userRegister2);  //get actual user reg
			userRegister2 = (userRegister2 & ~SHT2x_RES_MASK) | SHT2x_RES_10_13BIT;
			error |= SHT2x2_WriteUserRegister(&userRegister2); //write changed user reg
			error |= SHT2x2_ReadUserRegister(&userRegister2);  //get actual user reg
			// --- measure humidity with "Hold Master Mode (HM)"  ---
			error |= SHT2x2_MeasureHM(HUMIDITY, sRH2);
			error |= SHT2x2_MeasureHM(TEMP, sT2);
			//printf("2:%8x  %8x\r\n",sRH2[0], sT2[0]);
			//-- calculate humidity and temperature --
			temperatureC2= SHT2x_CalcTemperatureC(sT2[0]);
			humidityRH2 = SHT2x_CalcRH(sRH2[0]);
			printf("C2=%3.2f;RH2=%3.2f\r\n",temperatureC2,humidityRH2);
			u2_printf("C1=%3.2f;RH1=%3.2f;C2=%3.2f;RH2=%3.2f;\r\n",temperatureC,humidityRH,temperatureC2,humidityRH2);
//			if (temperatureC<=25.0)
//			{
//				LED1_ONOFF(1);
//				LED2_ONOFF(1);
//				LED3_ONOFF(0);
//				
//			}
//			else if (temperatureC>25.0&&temperatureC<=35.0)
//			{
//				LED1_ONOFF(1);
//				LED2_ONOFF(0);
//				LED3_ONOFF(0);
//			}
//			else
//			{
//				LED1_ONOFF(0);
//				LED2_ONOFF(0);
//				LED3_ONOFF(0);
//			}

//			
		
     
			
			OLED_DisDecimal(50, 0,temperatureC,2, &tFont16);//显示温度
			OLED_DisDecimal(50, 15,humidityRH,2, &tFont16);//显示湿度
			OLED_DisDecimal(50, 30,temperatureC2,2, &tFont16);//显示温度
			OLED_DisDecimal(50, 45,humidityRH2,2, &tFont16);//显示湿度
	//		error |= SHT2x_ReadUserRegister(&userRegister);  //get actual user reg
			
			LEDXToggle(1);
			
    }
    delay_ms(10);
    time++;
  }
}

