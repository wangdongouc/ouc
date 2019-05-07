#ifndef __esp8266_H__
#define __esp8266_H__
#include "stdio.h"	
#include "sys.h" 
#include "malloc.h"
#include "tjc3224t024_11.h"


#define USART2_MAX_RECV_LEN		256				//最大接收缓存字节数
#define USART2_MAX_SEND_LEN		256				//最大发送缓存字节数
#define USART2_RX_EN 			1					//0,不接收;1,接收.



void USART2_Init(u32 bound);				//串口2初始化 
void TIM4_Set(u8 sta);
void TIM4_Init(u16 arr,u16 psc);
void UART_DMA_Config(DMA_Channel_TypeDef*DMA_CHx,u32 cpar,u32 cmar);
void UART_DMA_Enable(DMA_Channel_TypeDef*DMA_CHx,u8 len);
void u2_printf(char* fmt, ...);




u8 ESP8266_mode_cofig(u8 netpro);
void ESP8266_at_response(u8 mode);
u8* ESP8266_check_cmd(u8 *str);
u8 ESP8266_apsta_check(void);
u8 ESP8266_send_data(u8 *data,u8 *ack,u16 waittime);
u8 ESP8266_send_cmd(u8 *cmd,u8 *ack,u16 waittime);
u8 ESP8266_quit_trans(void);
u8 ESP8266_consta_check(void);

void ESP8266_get_wanip(u8* ipbuf);
void ESP8266_get_ip(u8* apip,u8* staip);
void ESP8266_msg_show(u16 x,u16 y,u8 wanip);
void ESP8266_wificonf_show(u8* ssid,u8* password);
u8 ESP8266_netpro_sel(u16 x,u16 y,u8* name);
void ESP8266_mtest_ui(u16 x,u16 y);
u8 ESP8266_ip_set(u8* title,u8* mode,u8* port,u8* ip);
u8 ESP8266_test(void);


#endif
