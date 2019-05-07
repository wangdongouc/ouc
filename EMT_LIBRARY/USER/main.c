#include "delay.h"
#include "sys.h"
#include "usart.h"
#include "stdio.h"
#include "myiic.h"
#include "rtc.h"
#include "tjc3224t024_11.h"
#include "pms7003m.h"
#include "esp8266.h"
#include "24cxx.h"
#include "s8_co2.h"
#include "sht2x.h"
#include "led.h"

u16 deviceid;//设备编号
u8 link_mode=0;//0不联网;1 sta;3 sta+ap;
extern u16 portnum;		 
//WIFI STA模式,设置要去连接的路由器无线参数,请根据你自己的路由器设置,自行修改.
extern u8 wifista_ssid[16];			//路由器SSID号
extern u8 wifista_encryption[16];	//wpa/wpa2 aes加密方式
extern u8 wifista_password[16]; 	//连接密码
//WIFI AP模式,模块对外的无线参数,可自行修改.
extern u8 wifiap_ssid[16];			//对外SSID号
extern u8 wifiap_encryption[16];	//wpa/wpa2 aes加密方式
extern u8 wifiap_password[16]; 		//连接密码 
extern u8 server_ip[16];

extern u16 USART2_RX_STA;   //wifi
extern u8 USART2_RX_BUF[USART2_MAX_RECV_LEN];
extern u8 USART2_TX_BUF[USART2_MAX_SEND_LEN];

extern u16 USART3_RX_STA;         		   //接收co2状态标记	
extern u16 CO2ppm;

extern u16 UART4_RX_STA;         		   //接收pm状态标记	
extern u16 PM1_0,PM2_5,PM10,DQPM1_0,DQPM2_5,DQPM10;
extern u16 P03UP,P05UP,P10UP,P25UP,P50UP,P100UP;

extern u8  UART5_RX_BUF[UART5_REC_LEN]; //hmi  接收缓冲,最大USART_REC_LEN个字节.末字节为换行符 
extern u16 UART5_RX_STA;   
u8 ESP8266_wifiapsta(u8 retry);
u8 ESP8266_wifiap(u8 retry);
u8 ESP8266_wifista(u8 retry);
void SetTime(u16 rlen);

void ESP8266_send_sta(u8* str);
void ESP8266_send_ap(u8* str);
void ESP8266_send_apsta(u8* str);


void LoadDefaultParam(void)
{
	link_mode=3;
	deviceid=7;
	portnum=8080;
	sprintf((char*)wifista_ssid,"infotec");
	sprintf((char*)wifista_encryption,"wpawpa2_aes");
	sprintf((char*)wifista_password,"66786506");
	sprintf((char*)wifiap_ssid,"EMT");
	sprintf((char*)wifiap_encryption,"wpawpa2_aes");
	sprintf((char*)wifiap_password,"66786506");	
	sprintf((char*)server_ip,"222.195.226.140");	

}
void SaveParamToEEPROM(void)
{
	AT24CXX_Write(0,(u8*)&deviceid,2);
	AT24CXX_Write(2,(u8*)&portnum,2);
	AT24CXX_WriteOneByte(4,link_mode);
	AT24CXX_Write(16,wifista_ssid,16);
	AT24CXX_Write(32,wifista_password,16);
	AT24CXX_Write(48,wifista_encryption,16);
	AT24CXX_Write(64,wifiap_ssid,16);
	AT24CXX_Write(80,wifiap_password,16);
	AT24CXX_Write(96,wifiap_encryption,16);
	AT24CXX_Write(112,server_ip,16);
}
void LoadParamFromEEPROM(void)
{
	
	AT24CXX_Read(0,(u8*)&deviceid,2);
	AT24CXX_Read(2,(u8*)&portnum,2);
	link_mode=AT24CXX_ReadOneByte(4);
	AT24CXX_Read(16,wifista_ssid,16);
	AT24CXX_Read(32,wifista_password,16);
	AT24CXX_Read(48,wifista_encryption,16);
	AT24CXX_Read(64,wifiap_ssid,16);
	AT24CXX_Read(80,wifiap_password,16);
	AT24CXX_Read(96,wifiap_encryption,16);
	AT24CXX_Read(112,server_ip,16);
}
int main(void)
{	
	u8  sec,secs=0;
	u16  i,len=0;
  u8   rlen;
	u8   buf[128];
	u8   ap[16];
	u8   sta[16];
  u8   connect_network=0;
	u8   sta_ret=0;
	u8   ap_ret=0;
	u8   cur_screen=0;
	u8  error = 0;              //variable for error code. 
  u8  userRegister;           //variable for user register
	u16 sRH[1];                    //variable for raw humidity ticks
  u16 sT[1];                     //variable for raw temperature ticks 
	float temperature,humidity=10.0;
	u8  tcpconnect=0;
	
	uart_init(9600);
	delay_init();	    	 //延时函数初始化	
	NVIC_PriorityGroupConfig(NVIC_PriorityGroup_2);// 设置中断优先级分组2
	LED_Init();
	printf("\r\n图书馆馆舍空气监测终端\r\n");
	printf("系统启动...\r\n");

	Init_HMI();	
	len=sprintf((char*)buf,"page main");
	SendCmd_HMI(buf,len);
	
	len=sprintf((char*)buf,"main.strStatus.txt=\"系统启动...\"");
	SendCmd_HMI(buf,len);
	while(RTC_Init())		//RTC初始化	，一定要初始化成功
	{ 
		len=sprintf((char*)buf,"main.strStatus.txt=\"RTC Error\"");
		SendCmd_HMI(buf,len);	
		delay_ms(800);
		len=sprintf((char*)buf,"main.strStatus.txt=\"RTC Trying\"");
		SendCmd_HMI(buf,len);	
	}		
	len=sprintf((char*)buf,"main.strStatus.txt=\"连接传感器...\"");
	SendCmd_HMI(buf,len);
	delay_ms(100);
	printf("启动PM传感器.\r\n");
  Init_PMS7003M();

	printf("启动CO2传感器.\r\n");
  Init_S8();

  printf("启动温湿度传感.\r\n");
	SHT2X_Configuration();
	error |=SHT2x_SoftReset();
  delay_ms(100);	
	
  
	AT24CXX_Init();
	len=sprintf((char*)buf,"main.strStatus.txt=\"读入参数...\"");
	SendCmd_HMI(buf,len);
	if(AT24CXX_Check())//检测未初始化
	{
		len=sprintf((char*)buf,"main.strStatus.txt=\"EEPROM无参数，载入默认参数\"");
		SendCmd_HMI(buf,len);	
		LoadDefaultParam();
		SaveParamToEEPROM();
		delay_ms(1000);
	}
	else
	{
		printf("从EEPROM读入参数\r\n");
		len=sprintf((char*)buf,"main.strStatus.txt=\"从EEPROM读入参数\"");
		SendCmd_HMI(buf,len);	
		LoadParamFromEEPROM();
		delay_ms(1000);
	}
	printf("寻找WIFI：%s\r\n",wifista_ssid);
	len=sprintf((char*)buf,"main.strStatus.txt=\"寻找WIFI：%s\"",wifista_ssid);
	SendCmd_HMI(buf,len);	
	USART2_Init(115200);  //初始化串口2波特率为115200
  ESP8266_send_cmd("AT+CWMODE=1","OK",50);		//设置WIFI STA模式
	ESP8266_send_cmd("AT+RST","OK",20);		//DHCP服务器关闭(仅AP模式有效) 
	delay_ms(1000);
	delay_ms(1000);
  sta_ret=ESP8266_send_cmd("AT+CWLAP",wifista_ssid,300);  //查找wifi
	if(sta_ret)
	{
		printf("寻找AP：%s\r\n",wifiap_ssid);
	  len=sprintf((char*)buf,"main.strStatus.txt=\"寻找AP：%s\"",wifiap_ssid);
	  SendCmd_HMI(buf,len);	
		ap_ret=ESP8266_send_cmd("AT+CWLAP",wifiap_ssid,600);  //查找ap
		ap_ret=ESP8266_send_cmd("AT+CWLAP","EMT",600);  //查找ap
		if(ap_ret)
			link_mode=2;
		else
			link_mode=1;
	}
	else
		link_mode=3;
  printf("linkmode:%d,sta:%d,ap:%d\r\n",link_mode,sta_ret,ap_ret);
	
	len=sprintf((char*)buf,"main.strStatus.txt=\"启动完成,独立工作\"");
	SendCmd_HMI(buf,len);
	printf("传感器启动完成,独立工作");
//	switch(link_mode)
//	{
//		case 1:
//			connect_network=ESP8266_wifista(2);
//			printf("%d\r\n",connect_network);
//			if(connect_network)
//			{
//				ESP8266_get_wanip(sta);
//				len=sprintf((char*)buf,"main.strStatus.txt=\"连接AP：%s成功\"",wifiap_ssid);
//				SendCmd_HMI(buf,len);
//				printf("连接AP:%s\r\n",wifiap_ssid);
//			}			
//			else
//			{
//				len=sprintf((char*)buf,"main.strStatus.txt=\"连接AP:%s failed\"",wifiap_ssid);
//				SendCmd_HMI(buf,len);
//				printf("连接%s失败\r\n",wifiap_ssid);
//			}
//			break;
//		case 2:	
//			connect_network=ESP8266_wifiap(2);
//			printf("%d\r\n",connect_network);
//			if(connect_network)
//			{
//				ESP8266_get_wanip(sta);
//				len=sprintf((char*)buf,"main.strStatus.txt=\"启动独立AP:%s_solo\"",wifiap_ssid);
//				SendCmd_HMI(buf,len);
//				printf("启动独立AP:%s_solo\r\n",wifiap_ssid);
//			}			
//			else
//			{
//				len=sprintf((char*)buf,"main.strStatus.txt=\"启动AP:%s_solo failed\"",wifiap_ssid);
//				SendCmd_HMI(buf,len);
//				printf("连接%s_solo失败\r\n",wifiap_ssid);
//			}
//			break;
//		case 3:
//			connect_network=ESP8266_wifiapsta(2);
//			printf("%d\r\n",connect_network);
//			if(connect_network)
//			{
//				ESP8266_get_wanip(sta);
//				len=sprintf((char*)buf,"main.strStatus.txt=\"联网%d,IP:%s\"",link_mode,sta);
//				SendCmd_HMI(buf,len);
//				printf("联网成功,mode=%d\r\n",link_mode);
//			}			
//			else
//			{
//				len=sprintf((char*)buf,"main.strStatus.txt=\"Connect ssid:%s failed\"",wifista_ssid);
//				SendCmd_HMI(buf,len);
//				printf("连接%s失败\r\n",wifista_ssid);
//			}
//			break;
//	}

  while(1)
	{	
		if(sec!=calendar.sec)
		{
			sec=calendar.sec;
			LED=!LED;
			secs ++;	
			len=sprintf((char*)buf,"main.strTime.txt=\"%d:%d:%d\"",calendar.hour,calendar.min,calendar.sec);
			SendCmd_HMI(buf,len);	
			switch(calendar.week)
			{
				case 1:
					len=sprintf((char*)buf,"main.strDate.txt=\"%d-%d-%d 星期一\"",calendar.w_year,calendar.w_month,calendar.w_date);
					break;
				case 2:
					len=sprintf((char*)buf,"main.strDate.txt=\"%d-%d-%d 星期二\"",calendar.w_year,calendar.w_month,calendar.w_date);
					break;
				case 3:
					len=sprintf((char*)buf,"main.strDate.txt=\"%d-%d-%d 星期三\"",calendar.w_year,calendar.w_month,calendar.w_date);
					break;
				case 4:
					len=sprintf((char*)buf,"main.strDate.txt=\"%d-%d-%d 星期四\"",calendar.w_year,calendar.w_month,calendar.w_date);
					break;
				case 5:
					len=sprintf((char*)buf,"main.strDate.txt=\"%d-%d-%d 星期五\"",calendar.w_year,calendar.w_month,calendar.w_date);
					break;
				case 6:
					len=sprintf((char*)buf,"main.strDate.txt=\"%d-%d-%d 星期六\"",calendar.w_year,calendar.w_month,calendar.w_date);
					break;
				case 0:
					len=sprintf((char*)buf,"main.strDate.txt=\"%d-%d-%d 星期日\"",calendar.w_year,calendar.w_month,calendar.w_date);
					break;
				default:
					len=sprintf((char*)buf,"main.strDate.txt=\"%d-%d-%d %d\"",calendar.w_year,calendar.w_month,calendar.w_date,calendar.week);
					break;
			}
			SendCmd_HMI(buf,len);
			SendCmd_S8(0);	
			len=sprintf((char*)buf,"add 16,0,%d",(int)humidity);
			SendCmd_HMI(buf,len);	
			len=sprintf((char*)buf,"add 16,1,%d",(int)((float)CO2ppm/30.0));
			SendCmd_HMI(buf,len);
			len=sprintf((char*)buf,"add 16,2,%d",(int)temperature);
			SendCmd_HMI(buf,len);
			len=sprintf((char*)buf,"add 16,3,%d",(int)((float)PM2_5/2.0));
			SendCmd_HMI(buf,len);	
			error=0;
			
				// --- Set Resolution e.g. RH 10bit, Temp 13bit ---
			error |= SHT2x_ReadUserRegister(&userRegister);  //get actual user reg
			userRegister = (userRegister & ~SHT2x_RES_MASK) | SHT2x_RES_10_13BIT;
			error |= SHT2x_WriteUserRegister(&userRegister); //write changed user reg
			error |= SHT2x_ReadUserRegister(&userRegister);  //get actual user reg
			// --- measure humidity with "Hold Master Mode (HM)"  ---
			error |= SHT2x_MeasureHM(HUMIDITY, sRH);
			error |= SHT2x_MeasureHM(TEMP, sT);
			temperature= SHT2x_CalcTemperatureC(sT[0]);
			humidity = SHT2x_CalcRH(sRH[0]);
			len=sprintf((char*)buf,"main.strTemperature.txt=\"%2.1f℃\"",temperature);
		  SendCmd_HMI(buf,len);
			len=sprintf((char*)buf,"main.strHumidity.txt=\"%2.1f%%\"",humidity);
		  SendCmd_HMI(buf,len);
    	error = 0; 
			
		}	

		if(USART2_RX_STA&0X8000)		//接收到一次数据了
		{ 
			rlen=USART2_RX_STA&0X7FFF;	//得到本次接收到的数据长度
			USART2_RX_BUF[rlen]=0;		//添加结束符 
			if(ESP8266_check_cmd("AirInspection"))//接受到其他client的转发数据包
			{
				printf("Transfor:%s\r\n",&USART2_RX_BUF[12]);
				len=sprintf((char*)buf,"%s\r\n",&USART2_RX_BUF[12]);//测试数据
				if(link_mode==3)
					ESP8266_send_apsta(buf);
				else 
					ESP8266_send_sta(buf);
			}
			if(ESP8266_check_cmd("Timer"))//接受到时间设置数据包
			{
				calendar.w_year=USART2_RX_BUF[18]*256+USART2_RX_BUF[19];
				calendar.w_month=USART2_RX_BUF[20];
				calendar.w_date=USART2_RX_BUF[21];
				calendar.hour=USART2_RX_BUF[22];
				calendar.min=USART2_RX_BUF[23];
				calendar.sec=USART2_RX_BUF[24];
				RTC_Set(calendar.w_year,calendar.w_month,calendar.w_date,calendar.hour,calendar.min,calendar.sec);
				printf("TimeSet:%d %d %d-%d-%d %d:%d:%d ok\r\n",USART2_RX_BUF[18],USART2_RX_BUF[19],calendar.w_year,calendar.w_month,calendar.w_date,calendar.hour,calendar.min,calendar.sec);
				sprintf((char*)buf,"TimeSet:%d %d %d-%d-%d %d:%d:%d ok\r\n",USART2_RX_BUF[18],USART2_RX_BUF[19],calendar.w_year,calendar.w_month,calendar.w_date,calendar.hour,calendar.min,calendar.sec);
				ESP8266_send_ap(buf);
			}
			if(ESP8266_check_cmd("STASSID"))//接收到wifi ssid
			{
				printf("STA SSID:%s\r\n",&USART2_RX_BUF[20]);
				for(i=20;i<rlen;i++)
				  wifista_ssid[i-20]=USART2_RX_BUF[i];
				wifista_ssid[rlen-20]=0;
				SaveParamToEEPROM();
				sprintf((char*)buf,"STASSID:%s ok\r\n",&USART2_RX_BUF[20]);
				ESP8266_send_ap(buf);
			}
			if(ESP8266_check_cmd("STAPWD"))//接受到wifi密码
			{
				printf("STA PWD:%s\r\n",&USART2_RX_BUF[19]);
				for(i=19;i<rlen;i++)
				  wifista_password[i-19]=USART2_RX_BUF[i];
				wifista_password[rlen-19]=0;
				SaveParamToEEPROM();
				sprintf((char*)buf,"STAPWD:%s ok\r\n",&USART2_RX_BUF[19]);
				ESP8266_send_ap(buf);
			}
			if(ESP8266_check_cmd("APSSID"))//接受到AP ssid设置
			{
				printf("AP SSID:%s\r\n",&USART2_RX_BUF[19]);
				for(i=19;i<rlen;i++)
				  wifiap_ssid[i-19]=USART2_RX_BUF[i];
				wifiap_ssid[rlen-19]=0;
				SaveParamToEEPROM();
				sprintf((char*)buf,"APSSID:%s ok\r\n",&USART2_RX_BUF[19]);
				ESP8266_send_ap(buf);
			}
			if(ESP8266_check_cmd("APPWD"))//接受到AP密码设置
			{
				printf("AP PWD:%s\r\n",&USART2_RX_BUF[18]);
				for(i=18;i<rlen;i++)
				  wifiap_password[i-18]=USART2_RX_BUF[i];
				wifiap_password[rlen-18]=0;
				SaveParamToEEPROM();
				sprintf((char*)buf,"APPWD:%s ok\r\n",&USART2_RX_BUF[18]);
				ESP8266_send_ap(buf);
			}
			if(ESP8266_check_cmd("ServerIP"))//接受到AP密码设置
			{
				printf("ServerIP:%s\r\n",&USART2_RX_BUF[21]);
				for(i=21;i<rlen;i++)
				  server_ip[i-21]=USART2_RX_BUF[i];
				server_ip[rlen-21]=0;
				SaveParamToEEPROM();
				sprintf((char*)buf,"ServerIP:%s ok\r\n",&USART2_RX_BUF[21]);
				ESP8266_send_ap(buf);
			}
			if(ESP8266_check_cmd("RunMode"))//接受到runmode
			{
				printf("Run mode:%d\r\n",USART2_RX_BUF[20]);
				link_mode=USART2_RX_BUF[20];
				SaveParamToEEPROM();
				sprintf((char*)buf,"RunMode:%d ok\r\n",USART2_RX_BUF[20]);
				ESP8266_send_ap(buf);
			}
			if(ESP8266_check_cmd("DeviceID"))//接受到ID
			{

				deviceid=USART2_RX_BUF[21];
				SaveParamToEEPROM();	
				printf("DeviceID:%d\r\n",USART2_RX_BUF[21]);
				sprintf((char*)buf,"DeviceID:%d ok\r\n",USART2_RX_BUF[21]);
				ESP8266_send_ap(buf);
			}
			if(ESP8266_check_cmd("Reset"))//接受到重启
			{
				printf("Reset\r\n");
				if(tcpconnect)
					ESP8266_send_ap("reset ok");
				NVIC_SystemReset();
			}
			if(ESP8266_check_cmd("1,CONNECT"))//接受TCP客户端连接
			{
				printf("tcp client connect\r\n");
				tcpconnect=1;
			}
			if(ESP8266_check_cmd("1,CLOSED"))//接受TCP客户端连接关闭
			{
				printf("tcpconnection closed\r\n");
				tcpconnect=0;
			}
 			USART2_RX_STA=0;
		}  

		
		if((USART3_RX_STA&0x8000))
		{
			if(cur_screen==0)
			{
				len=sprintf((char*)buf,"main.nCO2.val=%d",CO2ppm);
				SendCmd_HMI(buf,len);	
				if (CO2ppm>1000)
				{
					 len=sprintf((char*)buf,"main.tm1.en=1");
					 SendCmd_HMI(buf,len);
				}
				else
				{
					 len=sprintf((char*)buf,"main.tm1.en=0");
					 SendCmd_HMI(buf,len);
					 len=sprintf((char*)buf,"main.nCO2.pco=65483");
					 SendCmd_HMI(buf,len);
				}				
			}
			USART3_RX_STA=0;
		}		

		if(UART4_RX_STA&0x8000)
		{
			if(cur_screen==0)
			{
				len=sprintf((char*)buf,"main.nPM1.val=%d",PM1_0);
				SendCmd_HMI(buf,len);	
				len=sprintf((char*)buf,"main.nPM25.val=%d",PM2_5);
				SendCmd_HMI(buf,len);	
				
				if (PM2_5>150)
					{
						len=sprintf((char*)buf,"main.tm0.en=1");
					 SendCmd_HMI(buf,len);
				}
				else
				{
					 len=sprintf((char*)buf,"main.tm0.en=0");
					 SendCmd_HMI(buf,len);
					 len=sprintf((char*)buf,"main.nPM1.pco=65483");
					 SendCmd_HMI(buf,len);
					len=sprintf((char*)buf,"main.nPM25.pco=65483");
					 SendCmd_HMI(buf,len);
					len=sprintf((char*)buf,"main.nPM10.pco=65483");
					 SendCmd_HMI(buf,len);
				}
				len=sprintf((char*)buf,"main.nPM10.val=%d",PM10);
				SendCmd_HMI(buf,len);	
				len=sprintf((char*)buf,"main.nDQPM1.val=%d",DQPM1_0);
				SendCmd_HMI(buf,len);	
				len=sprintf((char*)buf,"main.nDQPM25.val=%d",DQPM2_5);
				SendCmd_HMI(buf,len);	
				len=sprintf((char*)buf,"main.nDQPM10.val=%d",DQPM10);
				SendCmd_HMI(buf,len);					
			}
			if(cur_screen==2)
			{
				len=sprintf((char*)buf,"pm.nPM1.val=%d",PM1_0);
				SendCmd_HMI(buf,len);	
				len=sprintf((char*)buf,"pm.nPM25.val=%d",PM2_5);
				SendCmd_HMI(buf,len);	
				len=sprintf((char*)buf,"pm.nPM10.val=%d",PM10);
				SendCmd_HMI(buf,len);	
				len=sprintf((char*)buf,"pm.nDQPM1.val=%d",DQPM1_0);
				SendCmd_HMI(buf,len);	
				len=sprintf((char*)buf,"pm.nDQPM25.val=%d",DQPM2_5);
				SendCmd_HMI(buf,len);	
				len=sprintf((char*)buf,"pm.nDQPM10.val=%d",DQPM10);
				SendCmd_HMI(buf,len);		
				len=sprintf((char*)buf,"pm.nPM3UP.val=%d",P03UP);
				SendCmd_HMI(buf,len);	
				len=sprintf((char*)buf,"pm.nPM5UP.val=%d",P05UP);
				SendCmd_HMI(buf,len);	
				len=sprintf((char*)buf,"pm.nPM10UP.val=%d",P10UP);
				SendCmd_HMI(buf,len);	
				len=sprintf((char*)buf,"pm.nPM25UP.val=%d",P25UP);
				SendCmd_HMI(buf,len);	
				len=sprintf((char*)buf,"pm.nPM50UP.val=%d",P50UP);
				SendCmd_HMI(buf,len);	
				len=sprintf((char*)buf,"pm.nPM100UP.val=%d",P100UP);
				SendCmd_HMI(buf,len);
			}
			UART4_RX_STA=0;
		}	

		if(UART5_RX_STA&0X8000)		//接收到一次数据了
		{ 
			rlen=UART5_RX_STA&0X7FFF;	//得到本次接收到的数据长度
			UART5_RX_BUF[rlen]=0;		//添加结束符 
			if((UART5_RX_BUF[0]==0xaa)&&(UART5_RX_BUF[1]==0xaa)&&(UART5_RX_BUF[2]==0xaa)&&(UART5_RX_BUF[3]==0xaa))
			{
				cur_screen=0;
				printf("Set timer\r\n");
				SetTime(rlen);	
			}
			if((UART5_RX_BUF[0]==0xaa)&&(UART5_RX_BUF[1]==0xa0)&&(UART5_RX_BUF[2]==0xaa)&&(UART5_RX_BUF[3]==0xa0))
			{
				cur_screen=0;
			}
			if((UART5_RX_BUF[0]==0xaa)&&(UART5_RX_BUF[1]==0xa1)&&(UART5_RX_BUF[2]==0xaa)&&(UART5_RX_BUF[3]==0xa1))
			{
				cur_screen=1;
				len=sprintf((char*)buf,"time.nyear.txt=\"%d\"",calendar.w_year);
				SendCmd_HMI(buf,len);	
				len=sprintf((char*)buf,"time.nmonth.txt=\"%d\"",calendar.w_month);
				SendCmd_HMI(buf,len);	
				len=sprintf((char*)buf,"time.nday.txt=\"%d\"",calendar.w_date);
				SendCmd_HMI(buf,len);	
				len=sprintf((char*)buf,"time.nhour.txt=\"%d\"",calendar.hour);
				SendCmd_HMI(buf,len);	
				len=sprintf((char*)buf,"time.nminute.txt=\"%d\"",calendar.min);
				SendCmd_HMI(buf,len);	
				len=sprintf((char*)buf,"time.nsecond.txt=\"%d\"",calendar.sec);
				SendCmd_HMI(buf,len);	
			}
			if((UART5_RX_BUF[0]==0xaa)&&(UART5_RX_BUF[1]==0xa2)&&(UART5_RX_BUF[2]==0xaa)&&(UART5_RX_BUF[3]==0xa2))
			{
				cur_screen=2;
			}
			if((UART5_RX_BUF[0]==0xaa)&&(UART5_RX_BUF[1]==0xa3)&&(UART5_RX_BUF[2]==0xaa)&&(UART5_RX_BUF[3]==0xa3))
			{
				cur_screen=3;
				len=sprintf((char*)buf,"network.sta_ssid.txt=\"%s\"",wifista_ssid);
				SendCmd_HMI(buf,len);	
				len=sprintf((char*)buf,"network.ap_ssid.txt=\"%s\"",wifiap_ssid);
				SendCmd_HMI(buf,len);	
				len=sprintf((char*)buf,"network.nID.val=%d",deviceid);
				SendCmd_HMI(buf,len);	
				switch(link_mode)
				{
					case 0:
					  len=sprintf((char*)buf,"network.r0.val=1");
					  SendCmd_HMI(buf,len);	
					len=sprintf((char*)buf,"network.r1.val=0");
					  SendCmd_HMI(buf,len);	
					len=sprintf((char*)buf,"network.r2.val=0");
					  SendCmd_HMI(buf,len);	
						break;
					case 1:
					len=sprintf((char*)buf,"network.r0.val=0");
					  SendCmd_HMI(buf,len);	
					len=sprintf((char*)buf,"network.r1.val=1");
					  SendCmd_HMI(buf,len);	
					len=sprintf((char*)buf,"network.r2.val=0");
					  SendCmd_HMI(buf,len);	
						break;
					case 3:
					len=sprintf((char*)buf,"network.r0.val=0");
					  SendCmd_HMI(buf,len);	
					len=sprintf((char*)buf,"network.r1.val=0");
					  SendCmd_HMI(buf,len);	
					len=sprintf((char*)buf,"network.r2.val=1");
					  SendCmd_HMI(buf,len);	
						break;
				}
			}
			if((UART5_RX_BUF[0]==0xaa)&&(UART5_RX_BUF[1]==0xa3)&&(UART5_RX_BUF[2]==0xaa)&&(UART5_RX_BUF[3]==0x00))
			{
				cur_screen=3;
				deviceid=UART5_RX_BUF[4];
				link_mode=0;
				SaveParamToEEPROM();
			}
			if((UART5_RX_BUF[0]==0xaa)&&(UART5_RX_BUF[1]==0xa3)&&(UART5_RX_BUF[2]==0xaa)&&(UART5_RX_BUF[3]==0x01))
			{
				cur_screen=3;
				deviceid=UART5_RX_BUF[4];
				link_mode=1;
				SaveParamToEEPROM();
			}
			if((UART5_RX_BUF[0]==0xaa)&&(UART5_RX_BUF[1]==0xa3)&&(UART5_RX_BUF[2]==0xaa)&&(UART5_RX_BUF[3]==0x02))
			{
				cur_screen=3;
				deviceid=UART5_RX_BUF[4];
				link_mode=3;
				SaveParamToEEPROM();
				
			}
			if((UART5_RX_BUF[0]==0xaa)&&(UART5_RX_BUF[1]==0xa4)&&(UART5_RX_BUF[2]==0xaa)&&(UART5_RX_BUF[3]==0xa4))
			{
				cur_screen=4;

			}
 			UART5_RX_STA=0;
		}  	

    if(secs>9)
		{
			secs=0;
			if (connect_network)
			{

				len=sprintf((char*)buf,
					"AirInspection:%d|%d|%d|%d|%2.1f|%2.1f|%d|%d-%d-%d %d:%d:%d\r\n",
					deviceid,PM1_0,PM2_5,PM10,temperature,humidity,CO2ppm,
						calendar.w_year,calendar.w_month,calendar.w_date,calendar.hour,calendar.min,calendar.sec);//测试数据
				if(link_mode==3)
					ESP8266_send_apsta(buf);
				else if(link_mode==1)
					ESP8266_send_sta(buf);
				if(tcpconnect)
					ESP8266_send_ap(buf);
			}
		}
	 
		delay_ms(10);			
	}
	
}

u8 ESP8266_wifiapsta(u8 retry)
{
	u8 buf[128];
	u8 count=0;
		delay_ms(1000);  
  ESP8266_send_cmd("AT+CWMODE=3","OK",50);		//设置WIFI STA+AP模式
	ESP8266_send_cmd("AT+RST","OK",20);		//DHCP服务器关闭(仅AP模式有效) 
	delay_ms(1000);         //延时3S等待重启成功
	delay_ms(1000);	
	delay_ms(1000);
	ESP8266_send_cmd("AT+CWQAP","OK",50);		//退出AP连接
	delay_ms(1000);
	
	//设置连接到的WIFI网络名称/加密方式/密码,这几个参数需要根据您自己的路由器设置进行修改!! 
	sprintf((char*)buf,"AT+CWJAP=\"%s\",\"%s\"",wifista_ssid,wifista_password);//设置无线参数:ssid,密码
	count=0;
	while(ESP8266_send_cmd(buf,"CONNECTED",1000))
	{
		count ++;
		if (count>retry)
			return 0;
	}
	delay_ms(1000);
	delay_ms(1000);
	delay_ms(1000);	
	delay_ms(1000);	
	delay_ms(1000);
	ESP8266_send_cmd("AT+CIPMUX=1","OK",50);  //多链接模式
	delay_ms(200);
	//设置模块AP模式的WIFI网络名称/加密方式/密码
	sprintf((char*)buf,"AT+CWSAP=\"%s\",\"%s\",1,4",wifiap_ssid,wifiap_password);//设置无线参数:ssid,密码
	ESP8266_send_cmd(buf,"OK",200);					//设置AP模式参数
	delay_ms(1000);

	ESP8266_send_cmd("AT+CIPMUX=1","OK",50);  //多链接模式
	delay_ms(200);
	
	sprintf((char*)buf,"AT+CIPSTART=0,\"UDP\",\"%s\",%d",server_ip,portnum);    //配置目标UDP服务器,及ID号
	count=0;
	while(ESP8266_send_cmd(buf,"CONNECT",1000))
	{
		count ++;
		if (count>=retry)
			return 0;
	}
	delay_ms(200);
	


	sprintf((char*)buf,"AT+CIPSERVER=1,%d",portnum);
	ESP8266_send_cmd(buf,"OK",50);     //开启Server模式，端口号为8080
	delay_ms(500);

	count=0;
	while(ESP8266_send_cmd("AT+CIFSR","OK",1000))
	{
		count ++;
		if (count>=retry)
			return 0;
	}
	return 1;
}
u8 ESP8266_wifiap(u8 retry)
{
	u8 buf[128];
	u8 count=0;
  ESP8266_send_cmd("AT+CWMODE=2","OK",50);		//设置WIFI STA模式
	ESP8266_send_cmd("AT+RST","OK",20);		//DHCP服务器关闭(仅AP模式有效) 
	delay_ms(1000);
	delay_ms(1000);
  ESP8266_send_cmd("AT+CWMODE=2","OK",50);		//设置WIFI STA+AP模式
	ESP8266_send_cmd("AT+RST","OK",20);		//DHCP服务器关闭(仅AP模式有效) 
	delay_ms(1000);         //延时3S等待重启成功
	delay_ms(1000);
	delay_ms(1000);
		//设置模块AP模式的WIFI网络名称/加密方式/密码，这几个参数看自己喜好设置
	sprintf((char*)buf,"AT+CWSAP=\"%s_%d\",\"%s\",1,4",wifiap_ssid,deviceid,wifiap_password);//设置无线参数:ssid,密码
	ESP8266_send_cmd(buf,"OK",200);					//设置AP模式参数
	delay_ms(1000);
	ESP8266_send_cmd("AT+CIPMUX=1","OK",100);  //多链接模式
	delay_ms(200);
	sprintf((char*)buf,"AT+CIPSERVER=1,%d",portnum);
	ESP8266_send_cmd(buf,"OK",50);     //开启Server模式，端口号为8080
	delay_ms(500);
	ESP8266_send_cmd("AT+CIPSTO=1200","OK",50);     //设置服务器超时时间	
	delay_ms(500);
	count=0;
	while(ESP8266_send_cmd("AT+CIFSR","OK",1000))
	{
		count ++;
		if (count>=retry)
			return 0;
	}
	return 1;
}

u8 ESP8266_wifista(u8 retry)
{
	u8 buf[128];
	u8 count=0;
	
  ESP8266_send_cmd("AT+CWMODE=1","OK",50);		//设置WIFI STA模式
	ESP8266_send_cmd("AT+RST","OK",20);		//DHCP服务器关闭(仅AP模式有效) 
	delay_ms(1000);         //延时3S等待重启成功
	delay_ms(1000);
	delay_ms(1000);
	//设置连接到的WIFI网络名称/加密方式/密码,
	sprintf((char*)buf,"AT+CWJAP=\"%s\",\"%s\"",wifiap_ssid,wifiap_password);//设置无线参数:ssid,密码
	while(ESP8266_send_cmd(buf,"CONNECTED",2000))
	{
		count ++;
		if (count>=retry)
			return 0;
	}					//连接目标路由器,并且获得IP
	delay_ms(1000);	
	delay_ms(1000);
	delay_ms(1000);
	ESP8266_send_cmd("AT+CIPMUX=0","OK",20);  //单链接模式
	delay_ms(200);
	sprintf((char*)buf,"AT+CIPSTART=\"TCP\",\"192.168.4.1\",%d",portnum);    //配置目标UDP服务器
	delay_ms(200);

	count=0;
	while(ESP8266_send_cmd(buf,"OK",500))
	{
		count ++;
		if (count>=retry)
			return 0;
	}
	return 1;
}
void SetTime(u16 rlen)
{
		u16 nYear;
		u8  nMonth,nDay,nHour,nMinute,nSecond;	
		nYear=2010+UART5_RX_BUF[5];
    nMonth=UART5_RX_BUF[8];
		nDay=UART5_RX_BUF[12];
		nHour=UART5_RX_BUF[16];
		nMinute=UART5_RX_BUF[20];
		nSecond=UART5_RX_BUF[24];
		RTC_Set(nYear,nMonth,nDay,nHour,nMinute,nSecond);
}
void ESP8266_send_sta(u8* str)
{
	u16 len;
	u8	buf[128];
	u8	netcmd[32];
	len=sprintf((char*)buf,"%s",str);

	sprintf((char*)netcmd,"AT+CIPSEND=%d",len);
	ESP8266_send_cmd(netcmd,"OK",20);  //发送指定长度的数据
	delay_ms(100);
	ESP8266_send_data(buf,"OK",100);  //发送指定长度的数据		
}
void ESP8266_send_apsta(u8* str)
{
	u16 len;
	u8	buf[128];
	u8	netcmd[32];
	len=sprintf((char*)buf,"%s",str);

	sprintf((char*)netcmd,"AT+CIPSEND=0,%d",len);
	ESP8266_send_cmd(netcmd,"OK",20);  //发送指定长度的数据
	delay_ms(100);
	ESP8266_send_data(buf,"OK",100);  //发送指定长度的数据		
}
void ESP8266_send_ap(u8* str)
{
	u16 len;
	u8	buf[128];
	u8	netcmd[32];
	len=sprintf((char*)buf,"%s",str);

	sprintf((char*)netcmd,"AT+CIPSEND=1,%d",len);
	ESP8266_send_cmd(netcmd,"OK",20);  //发送指定长度的数据
	delay_ms(100);
	ESP8266_send_data(buf,"OK",100);  //发送指定长度的数据		
}



