/******************** (C) COPYRIGHT  源地工作室 ********************************
 * 文件名  ：sht2x.c
 * 描述    ：sht20温湿度传感器的操作
 * 作者    ：zhuoyingxingyu
 * 淘宝    ：源地工作室http://vcc-gnd.taobao.com/
 * 论坛地址：极客园地-嵌入式开发论坛http://vcc-gnd.com/
 * 版本更新: 2016-04-08
 * 硬件连接: PB6-I2C1_SCL、PB7-I2C1_SDA
 * 调试方式：J-Link-OB
**********************************************************************************/

//头文件
#include "SHT2X.h"
#include "usart.h"
#include "math.h"

const u16 POLYNOMIAL = 0x131;  //P(x)=x^8+x^5+x^4+1 = 100110001
 /**
  * @file   Delay_us(不精确)
  * @brief  微妙延时 time_ms ms
  * @param  time_us 延时时间
  * @retval NO
  */
void Delay_us( uint16_t time_us )
{
  uint16_t i,j;
  for( i=0;i<time_us;i++ )
  {
		for( j=0;j<12;j++ );//1us
  }
}


/**
  * @file   I2C_Configuration
  * @brief  EEPROM管脚配置
  * @param  无
  * @retval 无
  */
void SHT2X_Configuration(void)
{
  GPIO_InitTypeDef  GPIO_InitStructure; 
  /* Configure I2C1 pins: PB6->SCL and PB7->SDA */
  RCC_APB2PeriphClockCmd(SHT2X_SCK_GPIO_RCC|SHT2X_DATA_GPIO_RCC, ENABLE);
	
	GPIO_InitStructure.GPIO_Pin =  SHT2X_SCK_PIN ;
	GPIO_InitStructure.GPIO_Speed = GPIO_Speed_50MHz;
	GPIO_InitStructure.GPIO_Mode = GPIO_Mode_Out_OD;  
	GPIO_Init(SHT2X_SCK_GPIO_PORT, &GPIO_InitStructure);

	GPIO_InitStructure.GPIO_Pin =  SHT2X_DATA_PIN;
	GPIO_InitStructure.GPIO_Speed = GPIO_Speed_50MHz;
	GPIO_InitStructure.GPIO_Mode = GPIO_Mode_Out_OD;  
	GPIO_Init(SHT2X_DATA_GPIO_PORT, &GPIO_InitStructure);
}
/**
  * @file   I2c_StartCondition
  * @brief  writes a start condition on I2C-bus
  * @param  
	* 			input : -
	* 			output: -
	* 			return: -
	* @return: -
	* @note  : timing (delay) may have to be changed for different microcontroller
	*       _____
	* @SDA:       |_____
	*       _______
	* @SCL :        |___
  */
void I2c_StartCondition ()
{
  SHT2X_DATA_H;
	SHT2X_SCK_H;
	Delay_us(5);
	SHT2X_DATA_L;
	Delay_us(5);
	SHT2X_SCK_L;
	Delay_us(5);
}

/**
  * @file   I2c_StopCondition
  * @brief  writes a stop condition on I2C-bus
  * @param  
	* 			input : -
	* 			output: -
	* 			return: -
	* @note  : timing (delay) may have to be changed for different microcontroller
  *   					  _____
	*	@SDA:   _____|
	*	    	       _______
	*	@SCL :  ___|
  */
void I2c_StopCondition ()
{
	SHT2X_SCK_L;
	SHT2X_DATA_L;
	Delay_us(5);
	SHT2X_SCK_H;
	Delay_us(5);
	SHT2X_DATA_H;
	Delay_us(5);
}

/**
  * @file   I2c_WriteByte
  * @brief  writes a byte to I2C-bus and checks acknowledge
  * @param  
						input:  txByte  transmit byte
						output: -
  * @retval error
    @note: timing (delay) may have to be changed for different microcontroller
  */

u8 I2c_WriteByte (u8 txByte)
{
  u8 mask,error=0;
  for (mask=0x80; mask>0; mask/=2) //shift bit for masking (8 times)
  { 
		if ((mask & txByte) == 0) 
			SHT2X_DATA_L;									//masking txByte, write bit to SDA-Line
    else 
			SHT2X_DATA_H;
		
    Delay_us(1);          				  //data set-up time (t_SU;DAT)
    SHT2X_SCK_H;                    //generate clock pulse on SCL
    Delay_us(5);             				//SCL high time (t_HIGH)
    SHT2X_SCK_L;
		Delay_us(1);             				//data hold time(t_HD;DAT)
  }
  SHT2X_DATA_H;                     //release SDA-line
  SHT2X_SCK_H;                      //clk #9 for ack
  Delay_us(1);               				//data set-up time (t_SU;DAT)
  if(SHT2X_DATA_read()==1) 
		error=ACK_ERROR;       					//check ack from i2c slave
  SHT2X_SCK_L;
  Delay_us(20);              				//wait time to see byte package on scope
  return error;                     //return error code
}

/**
  * @file   I2c_ReadByte
  * @brief  reads a byte on I2C-bus
  * @param  
						input:  rxByte  receive byte
						output: rxByte
  * @retval error
    @note: timing (delay) may have to be changed for different microcontroller
  */
u8 I2c_ReadByte (etI2cAck ack)
{
  u8 mask,rxByte=0;
  SHT2X_DATA_H;                        //release SDA-line
  for (mask=0x80; mask>0; mask/=2)   //shift bit for masking (8 times)
  { 
		SHT2X_SCK_H;                      //start clock on SCL-line
    Delay_us(5);                      //data set-up time (t_SU;DAT)//SCL high time (t_HIGH)
    if (SHT2X_DATA_read() ==1) 
			rxByte=(rxByte | mask);        //read bit
    SHT2X_SCK_L;
    Delay_us(1);            	       //data hold time(t_HD;DAT)
  }
	if(ack)
		SHT2X_DATA_H;
	else
		SHT2X_DATA_L;                   //send acknowledge if necessary
  Delay_us(1);              	      //data set-up time (t_SU;DAT)
  SHT2X_SCK_H;                     //clk #9 for ack
  Delay_us(5);              	     //SCL high time (t_HIGH)
  SHT2X_SCK_L;
  SHT2X_DATA_H;             	     //release SDA-line
  Delay_us(20);                   	//wait time to see byte package on scope
  return rxByte;            	      //return error code
}

/**
  * @file   SHT2x_CheckCrc
  * @brief  calculates checksum for n bytes of data and compares it with expected
  * @param  
	*					input:   data[]				checksum is built based on this data
	*									 nbrOfBytes   checksum is built for n bytes of data
	*										checksum    expected checksum
	*					output: rxByte
	* @retval error:   CHECKSUM_ERROR = checksum does not match
	*										0             = checksum matches
  */
u8 SHT2x_CheckCrc(u8 *data, u8 nbrOfBytes, u8 checksum)
{
  u8 crc = 0;	
  u8 byteCtr;
	u8 bit=0;
  //calculates 8-Bit checksum with given polynomial
  for (byteCtr = 0; byteCtr < nbrOfBytes; ++byteCtr)
  { 
		crc ^= (*data++);
    for (bit = 8; bit > 0; --bit)
    { if (crc & 0x80) crc = (crc << 1) ^ POLYNOMIAL;
      else crc = (crc << 1);
    }
  }
  if (crc != checksum) return CHECKSUM_ERROR;
  else return 0;
}

/**
  * @file   SHT2x_ReadUserRegister
  * @brief   reads the SHT2x user register (8bit)
  * @param  
	*					input:  -
	*					output: *pRegisterValue
	* @retval error:  
  */
u8 SHT2x_ReadUserRegister(u8 *pRegisterValue)
{
  u8 checksum;   //variable for checksum byte
  u8 error=0;    //variable for error code

  I2c_StartCondition();
  error |= I2c_WriteByte (I2C_ADR_W);
  error |= I2c_WriteByte (USER_REG_R);
  I2c_StartCondition();
  error |= I2c_WriteByte (I2C_ADR_R);
  *pRegisterValue = I2c_ReadByte(ACK);
  checksum=I2c_ReadByte(NO_ACK);
  error |= SHT2x_CheckCrc (pRegisterValue,1,checksum);
  I2c_StopCondition();
  return error;
}
/**
  * @file   SHT2x_WriteUserRegister
  * @brief   writes the SHT2x user register (8bit)
  * @param  
	*					input:  *pRegisterValue
	*					output: -
	* @retval error:  
  */
u8 SHT2x_WriteUserRegister(u8 *pRegisterValue)
{
  u8 error=0;   //variable for error code

  I2c_StartCondition();
  error |= I2c_WriteByte (I2C_ADR_W);
  error |= I2c_WriteByte (USER_REG_W);
  error |= I2c_WriteByte (*pRegisterValue);
  I2c_StopCondition();
  return error;
}
/**
  * @file   SHT2x_MeasureHM
  * @brief   measures humidity or temperature. This function polls every 10ms until  measurement is ready.
  * @param  
	*					input:   eSHT2xMeasureType
	*					output:  *pMeasurand:  humidity / temperature as raw value
	* @retval error: 
  * @note:   timing for timeout may be changed
  */
u8 SHT2x_MeasureHM(etSHT2xMeasureType eSHT2xMeasureType, u16 *pMeasurand)
{
  u8  checksum;   //checksum
  u8  data[2];    //data array for checksum verification
  u8  error=0;    //error variable
  u16 i;          //counting variable

  //-- write I2C sensor address and command --
  I2c_StartCondition();
  error |= I2c_WriteByte (I2C_ADR_W); // I2C Adr
  switch(eSHT2xMeasureType)
  { 
		case HUMIDITY: error |= I2c_WriteByte (TRIG_RH_MEASUREMENT_HM); break;
    case TEMP    : error |= I2c_WriteByte (TRIG_T_MEASUREMENT_HM);  break;
    default: break;
  }
  //-- wait until hold master is released --
  I2c_StartCondition();
  error |= I2c_WriteByte (I2C_ADR_R);
  SHT2X_SCK_H;                     // set SCL I/O port as input
  for(i=0; i<1000; i++)         // wait until master hold is released or
  { 
		Delay_us(1000);    // a timeout (~1s) is reached
    if (SHT2X_SCK_read()==1) break;
  }
  //-- check for timeout --
  if(SHT2X_SCK_read()==0) error |= TIME_OUT_ERROR;

		data[0] = I2c_ReadByte(ACK);
		data[1] = I2c_ReadByte(ACK);
	  *pMeasurand=((data[0]<<8)+data[1]);
  checksum=I2c_ReadByte(NO_ACK);

  //-- verify checksum --
  error |= SHT2x_CheckCrc (data,2,checksum);
  I2c_StopCondition();
  return error;
}
/**
  * @file   SHT2x_MeasurePoll
  * @brief   measures humidity or temperature. This function waits for a hold master until measurement is ready or a timeout occurred.
  * @param  
	*					input:   eSHT2xMeasureType
	*					output:  *pMeasurand:  humidity / temperature as raw value
	* @retval error: 
  * @note:   timing for timeout may be changed
  */
u8 SHT2x_MeasurePoll(etSHT2xMeasureType eSHT2xMeasureType, u16 *pMeasurand)
{
  u8  checksum;   //checksum
  u8  data[2];    //data array for checksum verification
  u8  error=0;    //error variable
  u16 i=0;        //counting variable

  //-- write I2C sensor address and command --
  I2c_StartCondition();
  error |= I2c_WriteByte (I2C_ADR_W); // I2C Adr
  switch(eSHT2xMeasureType)
  { case HUMIDITY: error |= I2c_WriteByte (TRIG_RH_MEASUREMENT_POLL); break;
    case TEMP    : error |= I2c_WriteByte (TRIG_T_MEASUREMENT_POLL);  break;
    default: break;
  }
  //-- poll every 10ms for measurement ready. Timeout after 20 retries (200ms)--
  do
  { 
		I2c_StartCondition();
    Delay_us(10000);  //delay 10ms
    if(i++ >= 20) break;
  } while(I2c_WriteByte (I2C_ADR_R) == ACK_ERROR);
  if (i>=20) error |= TIME_OUT_ERROR;

		data[0] = I2c_ReadByte(ACK);
		data[1] = I2c_ReadByte(ACK);
	   *pMeasurand=((data[0]<<8)+data[1]);
  checksum=I2c_ReadByte(NO_ACK);

  //-- verify checksum --
  error |= SHT2x_CheckCrc (data,2,checksum);
//				printf("error=%d\r\n",error);
//	printf("checksum=%d\r\n",checksum);
  I2c_StopCondition();
  return error;
}

/**
  * @file   SHT2x_SoftReset
  * @brief  performs a reset
  * @param  
	*					input:  -
	*					output: -
	* @retval error:  
  */
u8 SHT2x_SoftReset()
{
  u8  error=0;           //error variable

  I2c_StartCondition();
  error |= I2c_WriteByte (I2C_ADR_W); // I2C Adr
  error |= I2c_WriteByte (SOFT_RESET);                            // Command
  I2c_StopCondition();
  Delay_us(15000); // wait till sensor has restarted
  return error;
}

/**
  * @file   SHT2x_CalcRH
  * @brief  calculates the relative humidity
  * @param  
	*					input:  sRH: humidity raw value (16bit scaled)
	*					output: -
	* @retval pHumidity relative humidity [%RH]  
  */
float SHT2x_CalcRH(u16 u16sRH)
{
  float humidityRH;              // variable for result
	u16sRH &= ~0x0003;          // clear bits [1..0] (status bits)
  humidityRH = -6.0 + 125.0/65536 * (float)u16sRH; // RH= -6 + 125 * SRH/2^16
  return humidityRH;
}

/**
  * @file   SHT2x_CalcTemperatureC
  * @brief  calculates temperature
  * @param  
	*					input:   sT: temperature raw value (16bit scaled)
	*					output: -
	* @retval temperature [] 
  */
float SHT2x_CalcTemperatureC(u16 u16sT)
{
  float temperatureC;            // variable for result
	u16sT &= ~0x0003;           // clear bits [1..0] (status bits)
  temperatureC= -46.85 + 175.72/65536 *(float)u16sT; //T= -46.85 + 175.72 * ST/2^16
  return temperatureC;
}

/**
  * @file  SHT2x_GetSerialNumber
  * @brief  gets serial number of SHT2x according application note "How To Read-Out the Serial Number"
  * @param  
	*					input:   -
	*					output:  
	*										u8SerialNumber: Array of 8 bytes (64Bits)
	*										MSB                                         LSB
	* 						      u8SerialNumber[7]             u8SerialNumber[0]
	*  						      SNA_1 SNA_0 SNB_3 SNB_2 SNB_1 SNB_0 SNC_1 SNC_0
	* @retval error: 
  * @note:  readout of this function is not CRC checked
  */
u8 SHT2x_GetSerialNumber(u8 u8SerialNumber[])
{
  u8  error=0;                          //error variable
  I2c_StartCondition();
  error |= I2c_WriteByte (I2C_ADR_W);    //I2C address
  error |= I2c_WriteByte (0xFA);         //Command for readout on-chip memory
  error |= I2c_WriteByte (0x0F);         //on-chip memory address
  I2c_StartCondition();
  error |= I2c_WriteByte (I2C_ADR_R);    //I2C address
  u8SerialNumber[5] = I2c_ReadByte(ACK); //Read SNB_3
  I2c_ReadByte(ACK);                     //Read CRC SNB_3 (CRC is not analyzed)
  u8SerialNumber[4] = I2c_ReadByte(ACK); //Read SNB_2
  I2c_ReadByte(ACK);                     //Read CRC SNB_2 (CRC is not analyzed)
  u8SerialNumber[3] = I2c_ReadByte(ACK); //Read SNB_1
  I2c_ReadByte(ACK);                     //Read CRC SNB_1 (CRC is not analyzed)
  u8SerialNumber[2] = I2c_ReadByte(ACK); //Read SNB_0
  I2c_ReadByte(NO_ACK);                  //Read CRC SNB_0 (CRC is not analyzed)
  I2c_StopCondition();

  //Read from memory location 2
  I2c_StartCondition();
  error |= I2c_WriteByte (I2C_ADR_W);    //I2C address
  error |= I2c_WriteByte (0xFC);         //Command for readout on-chip memory
  error |= I2c_WriteByte (0xC9);         //on-chip memory address
  I2c_StartCondition();
  error |= I2c_WriteByte (I2C_ADR_R);    //I2C address
  u8SerialNumber[1] = I2c_ReadByte(ACK); //Read SNC_1
  u8SerialNumber[0] = I2c_ReadByte(ACK); //Read SNC_0
  I2c_ReadByte(ACK);                     //Read CRC SNC0/1 (CRC is not analyzed)
  u8SerialNumber[7] = I2c_ReadByte(ACK); //Read SNA_1
  u8SerialNumber[6] = I2c_ReadByte(ACK); //Read SNA_0
  I2c_ReadByte(NO_ACK);                  //Read CRC SNA0/1 (CRC is not analyzed)
  I2c_StopCondition();

  return error;
}

