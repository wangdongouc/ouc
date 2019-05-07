/******************** (C) COPYRIGHT  Դ�ع����� ********************************
 * �ļ���  ��main.c
 * ����    :�������У�ESP8266ģ�鹤����STA��UDP��ģʽ�����ն�ģʽ����Ҫ��������·��������������APģʽ  
 * ��汾  ��V3.50
 * ����    ��zhuoyingxingyu
 * �Ա�    ��Դ�ع�����http://vcc-gnd.taobao.com/
 * ��̳��ַ������԰��-Ƕ��ʽ������̳http://vcc-gnd.com/
 * �汾����: 2016-03-08
 * ���Է�ʽ��J-Link-OB
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

u8  Data_buff[1024];     //���ݻ�����
u8  Data_len[5];         //���ݳ��Ȼ�����
u8  Data_id[5];          //���ݷ����ߵ�id������

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
	   
  SYSTICK_Init();	    //��ʱ������ʼ��
  delay_ms(1500);     //�ȴ�оƬ�ϵ縴λ�ɹ�
	LED_GPIO_Config();//��ʼ��LED
  USART1_Config(9600);	//���ڳ�ʼ��
  uart2_init(115200);	//���ڳ�ʼ��
	printf("\r\nϵͳ����...\r\n");

	OLED_Init(); 
  SHT2X_Configuration();
  SHT2X2_Configuration();
	OLED_ClrScr(0);
	OLED_DispStr(0,  0, "System start-up", &tFont12);  	

	
//	
//	DateTimeDis_Init();
 // RTC_Init();
  ESP8266_Exit_Transfer(10);//����Ƿ���͸��״̬����������˳�
	
	OLED_DispStr(0,15, "connect network", &tFont12); 
  printf("ESP8266׼�����ӷ�����!\r\n");
  res1=ESP8266_STA_UDP_Init();
  switch(res1)
  {
    case 0  :  printf("ESP8266����UDP�ɹ������ɹ�����͸��ģʽ\r\n");break;
    case 1  :  printf("ESP8266�����λʧ��! ׼������ϵͳ\r\n");NVIC_SystemReset();break;
    case 2  :  printf("ESP8266����STAģʽʧ��! ׼������ϵͳ\r\n");NVIC_SystemReset();break;
    case 3  :  printf("ESP8266����APʧ��!,׼������ϵͳ\r\n");NVIC_SystemReset();break;
    case 4  :  printf("ESP8266��IP��ȡʧ��!,׼������ϵͳ\r\n");NVIC_SystemReset();break;
    case 5  :  printf("ESP8266����͸��ʧ��!,׼������ϵͳ\r\n");NVIC_SystemReset();break;
    case 6  :  printf("ESP8266�رն�·����ʧ��!,׼������ϵͳ\r\n");NVIC_SystemReset();break;
    case 7  :  printf("ESP8266����UDPʧ��!,׼������ϵͳ\r\n");NVIC_SystemReset();break;
    case 8  :  printf("ESP8266����͸��ʧ��!,׼������ϵͳ\r\n");NVIC_SystemReset();break;
  }
	OLED_DispStr(0,30, "connected!", &tFont12); 
  USART2_DATA_FLAG=1;  //��ǽ�������͸����
  USART2_RX_STA=0;  
  memset(USART2_RX_BUF,0,USART2_REC_LEN); //�������2����
  OLED_DispStr(12, 45,(char*)IP_Buff, &tFont12);
	delay_ms(1500);
	OLED_ClrScr(0);
  OLED_DispStr(10,  0, "A�¶�:", &tFont12);  	
	OLED_DispStr(95,  0, "��", &tFont12);
	OLED_DispStr(10, 15, "Aʪ��:", &tFont12);    
	OLED_DispStr(95, 15, "%", &tFont12);
	OLED_DispStr(10,  30, "B�¶�:", &tFont12);  	
	OLED_DispStr(95,  30, "��", &tFont12);
	OLED_DispStr(10, 45, "Bʪ��:", &tFont12);    
	OLED_DispStr(95, 45, "%", &tFont12);
  while(1)
  {

    if(USART2_RX_STA&0x8000)
    {
      len=USART2_RX_STA&0x7FFF;
      memcpy(Data_buff,USART2_RX_BUF,len);
      USART2_RX_STA=0;
      Data_buff[len]='\0';			
      printf("�����ݷ���\r\n");
      printf("����:%s\r\n",Data_buff);
      u2_printf("%s",Data_buff);		
    }
    if(time>=10000)
    {
			OLED_ClrScr(0);
     	OLED_DispStr(10,  0, "A�¶�:", &tFont12);  	
			OLED_DispStr(95,  0, "��", &tFont12);
			OLED_DispStr(10, 15, "Aʪ��:", &tFont12);    
			OLED_DispStr(95, 15, "%", &tFont12);
			
			OLED_DispStr(10,  30, "B�¶�:", &tFont12);  	
			OLED_DispStr(95,  30, "��", &tFont12);
			OLED_DispStr(10, 45, "Bʪ��:", &tFont12);    
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
		
     
			
			OLED_DisDecimal(50, 0,temperatureC,2, &tFont16);//��ʾ�¶�
			OLED_DisDecimal(50, 15,humidityRH,2, &tFont16);//��ʾʪ��
			OLED_DisDecimal(50, 30,temperatureC2,2, &tFont16);//��ʾ�¶�
			OLED_DisDecimal(50, 45,humidityRH2,2, &tFont16);//��ʾʪ��
	//		error |= SHT2x_ReadUserRegister(&userRegister);  //get actual user reg
			
			LEDXToggle(1);
			
    }
    delay_ms(10);
    time++;
  }
}

