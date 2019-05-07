#ifndef __SHT2X_H
#define __SHT2X_H			 
#include "stm32f10x.h"

/* Includes ------------------------------------------------------------------*/


typedef enum{
	ACK = 0,
	NO_ACK = 1,
}etI2cAck;

typedef enum{
ACK_ERROR = 0x01,
TIME_OUT_ERROR = 0x02,
CHECKSUM_ERROR = 0x04,
UNIT_ERROR = 0x08
}etError;


// sensor command
typedef enum{
  TRIG_T_MEASUREMENT_HM    = 0xE3, // command trig. temp meas. hold master
  TRIG_RH_MEASUREMENT_HM   = 0xE5, // command trig. humidity meas. hold master
  TRIG_T_MEASUREMENT_POLL  = 0xF3, // command trig. temp meas. no hold master
  TRIG_RH_MEASUREMENT_POLL = 0xF5, // command trig. humidity meas. no hold master
  USER_REG_W               = 0xE6, // command writing user register
  USER_REG_R               = 0xE7, // command reading user register
  SOFT_RESET               = 0xFE  // command soft reset
}etSHT2xCommand;

typedef enum {
  SHT2x_RES_12_14BIT       = 0x00, // RH=12bit, T=14bit
  SHT2x_RES_8_12BIT        = 0x01, // RH= 8bit, T=12bit
  SHT2x_RES_10_13BIT       = 0x80, // RH=10bit, T=13bit
  SHT2x_RES_11_11BIT       = 0x81, // RH=11bit, T=11bit
  SHT2x_RES_MASK           = 0x81  // Mask for res. bits (7,0) in user reg.
} etSHT2xResolution;

typedef enum {
  SHT2x_EOB_ON             = 0x40, // end of battery
  SHT2x_EOB_MASK           = 0x40, // Mask for EOB bit(6) in user reg.
} etSHT2xEob;

typedef enum {
  SHT2x_HEATER_ON          = 0x04, // heater on
  SHT2x_HEATER_OFF         = 0x00, // heater off
  SHT2x_HEATER_MASK        = 0x04, // Mask for Heater bit(2) in user reg.
} etSHT2xHeater;

// measurement signal selection
typedef enum{
  HUMIDITY,
  TEMP
}etSHT2xMeasureType;

typedef enum{
  I2C_ADR_W                = 128,   // sensor I2C address + write bit
  I2C_ADR_R                = 129    // sensor I2C address + read bit
}etI2cHeader;

#define SHT2X_SCK_PIN      					 	  GPIO_Pin_0   
#define SHT2X_SCK_GPIO_PORT   	       	GPIOB  
#define SHT2X_SCK_GPIO_RCC      			  RCC_APB2Periph_GPIOB  
 
#define SHT2X_DATA_PIN      					 	GPIO_Pin_1  
#define SHT2X_DATA_GPIO_PORT   	       	GPIOB  
#define SHT2X_DATA_GPIO_RCC      			  RCC_APB2Periph_GPIOB  

#define SHT2X_SCK_H         	  GPIO_SetBits(SHT2X_SCK_GPIO_PORT , SHT2X_SCK_PIN)   /*GPIOB->BSRR = GPIO_Pin_0*/
#define SHT2X_SCK_L             GPIO_ResetBits(SHT2X_SCK_GPIO_PORT , SHT2X_SCK_PIN) /*GPIOB->BRR  = GPIO_Pin_0 */
   
#define SHT2X_DATA_H         	  GPIO_SetBits(SHT2X_DATA_GPIO_PORT , SHT2X_DATA_PIN)   /*GPIOB->BSRR = GPIO_Pin_1*/
#define SHT2X_DATA_L         	  GPIO_ResetBits(SHT2X_DATA_GPIO_PORT , SHT2X_DATA_PIN) /*GPIOB->BRR  = GPIO_Pin_1*/

#define SHT2X_SCK_read()        	GPIO_ReadInputDataBit(SHT2X_SCK_GPIO_PORT , SHT2X_SCK_PIN)/* GPIOB->IDR  & GPIO_Pin_0   */
#define SHT2X_DATA_read()       	GPIO_ReadInputDataBit(SHT2X_DATA_GPIO_PORT , SHT2X_DATA_PIN)/*GPIOB->IDR  & GPIO_Pin_1	  */



void SHT2X_Configuration(void);
void I2c_Init (void);
void I2c_StartCondition (void);
void I2c_StopCondition (void);
u8 I2c_WriteByte (u8 txByte);
u8 I2c_ReadByte (etI2cAck ack);

u8 SHT2x_CheckCrc(u8 *data, u8 nbrOfBytes, u8 checksum);
u8 SHT2x_WriteUserRegister(u8 *pRegisterValue);
u8 SHT2x_ReadUserRegister(u8 *pRegisterValue);
u8 SHT2x_MeasurePoll(etSHT2xMeasureType eSHT2xMeasureType, u16 *pMeasurand);
u8 SHT2x_MeasureHM(etSHT2xMeasureType eSHT2xMeasureType, u16 *pMeasurand);
u8 SHT2x_SoftReset(void);
float SHT2x_CalcRH(u16 u16sRH);
float SHT2x_CalcTemperatureC(u16 u16sT);
u8 SHT2x_GetSerialNumber(u8 u8SerialNumber[]);

#endif 
/*********************************************************************************************************
      END FILE
*********************************************************************************************************/
