/*
*********************************************************************************************************
*
*	模块名称 : 汉字点阵字库。有效显示区 高11x宽11, 最右一列留白
*	文件名称 : hz12.c
*	版    本 : V1.0
*	说    明 : 只包含本程序用到汉字字库
*	修改记录 :
*		版本号  日期       作者    说明
*		v1.0    2011-09-08 armfly  ST固件库V3.5.0版本。
*
*	Copyright (C), 2010-2011, 安富莱电子 www.armfly.com
*
*********************************************************************************************************
*/


/*
	FLASH中内嵌小字库，只包括本程序用到的汉字点阵
	每行点阵数据，头2字节是汉子的内码，后面32字节是16点阵汉子的字模数据。
*/

unsigned char const g_Hz12[] = {
0xB1,0xB8, 0x08,0x80,0x0F,0xC0,0x18,0x80,0x25,0x00,0x46,0x00,0x19,0x80,0x20,0x70,0xDF,0xC0,//备//
           0x12,0x40,0x1F,0xC0,0x12,0x40,0x1F,0xC0,

0xB5,0xD8, 0x01,0x00,0x21,0x00,0x25,0x20,0x25,0x70,0xF5,0xA0,0x2F,0x20,0x25,0x20,0x25,0x60,//地//
           0x35,0x00,0x64,0x10,0x84,0x10,0x03,0xF0,

0xB9,0xAB, 0x0A,0x00,0x09,0x00,0x11,0x00,0x10,0x80,0x20,0x40,0x44,0x30,0x84,0x20,0x08,0x00,//公//
           0x11,0x00,0x20,0x80,0x3F,0xC0,0x00,0x40,

0xC6,0xF7, 0x79,0xE0,0x49,0x20,0x79,0xE0,0x49,0x20,0x04,0x80,0xFF,0xF0,0x10,0x80,0x20,0x40,//器//
           0xFD,0xF0,0x25,0x20,0x3D,0xE0,0x25,0x20,

0xC9,0xE8, 0x47,0xC0,0x24,0x40,0x24,0x40,0x04,0x40,0xE8,0x30,0x27,0xC0,0x24,0x40,0x22,0x80,//设 //
           0x2A,0x80,0x31,0x00,0x26,0xC0,0x18,0x30,

0xCB,0xBE, 0x7F,0xE0,0x00,0x20,0x00,0x20,0x7F,0xA0,0x00,0x20,0x3E,0x20,0x22,0x20,0x22,0x20,//司//
           0x3E,0x20,0x22,0x20,0x00,0xA0,0x00,0x40,

0xCF,0xDE, 0x00,0x00,0xF7,0xE0,0x94,0x20,0xA7,0xE0,0xA4,0x20,0x97,0xE0,0x94,0x00,0xD5,0x60,//限//
           0xA4,0x80,0x85,0x40,0x86,0x20,0x84,0x10,

0xD2,0xC7, 0x12,0x00,0x11,0x20,0x21,0x20,0x28,0x40,0x64,0x40,0xA4,0x40,0x22,0x80,0x21,0x00,//仪//
           0x21,0x00,0x22,0x80,0x24,0x40,0x28,0x30,

0xD3,0xD0, 0x04,0x00,0x04,0x20,0xFF,0xF0,0x08,0x00,0x1F,0xC0,0x30,0x40,0x5F,0xC0,0x90,0x40,//有//
           0x1F,0xC0,0x10,0x40,0x11,0x40,0x10,0x80,

0xD4,0xB4, 0x00,0x10,0x4F,0xF0,0x29,0x00,0x8B,0xE0,0x4A,0x20,0x2B,0xE0,0x2A,0x20,0x4B,0xE0,//源//
           0x49,0x80,0x52,0xA0,0x54,0x90,0x61,0x90,
		   
0xB7,0xD6, 0x09,0x00,0x09,0x00,0x11,0x00,0x10,0x80,0x20,0x40,0x7F,0xB0,0x88,0x80,0x08,0x80,// 分 //
           0x08,0x80,0x10,0x80,0x12,0x80,0x61,0x00,

0xC3,0xEB, 0x18,0x80,0xE0,0x80,0x22,0xC0,0xFA,0xA0,0x22,0x90,0x62,0x80,0x74,0xB0,0xA0,0xA0,// 秒 //
           0x20,0x40,0x20,0x80,0x23,0x00,0x2C,0x00,

0xC4,0xEA, 0x10,0x40,0x1F,0xF0,0x22,0x00,0x42,0x00,0x9F,0xE0,0x12,0x00,0x12,0x00,0xFF,0xF0,// 年 //
           0x02,0x00,0x02,0x00,0x02,0x00,0x02,0x00,

0xC8,0xD5, 0x00,0x40,0x1F,0xE0,0x10,0x40,0x10,0x40,0x10,0x40,0x1F,0xC0,0x10,0x40,0x10,0x40,// 日 //
           0x10,0x40,0x1F,0xC0,0x10,0x40,0x00,0x00,

0xCA,0xB1, 0x00,0x40,0x00,0x40,0xF8,0x40,0x8F,0xF0,0x88,0x40,0xFA,0x40,0x89,0x40,0x89,0x40,// 时 //
           0xF8,0x40,0x88,0x40,0x01,0x40,0x00,0xC0,

0xD4,0xC2, 0x1F,0xC0,0x10,0x40,0x10,0x40,0x1F,0xC0,0x10,0x40,0x10,0x40,0x1F,0xC0,0x10,0x40,// 月 //
           0x10,0x40,0x20,0x40,0x42,0x40,0x81,0x80,
0xB6,0xC8, 0x02,0x00,0x3F,0xE0,0x24,0x80,0x3F,0xE0,0x24,0x80,0x27,0x80,0x20,0x00,0x2F,0x80,// 度 //
           0x25,0x00,0x42,0x00,0x8D,0x80,0xB0,0x70,

0xB9,0xE2, 0x02,0x00,0x22,0x40,0x12,0x40,0x12,0x80,0x02,0x20,0xFF,0xF0,0x09,0x00,0x09,0x00,// 光 //
           0x09,0x10,0x11,0x10,0x21,0x10,0xC0,0xF0,

0xC6,0xF8, 0x10,0x00,0x10,0x40,0x3F,0xE0,0x40,0x00,0x9F,0x80,0x00,0x00,0x7F,0x80,0x00,0x80,// 气 //
           0x00,0x80,0x00,0x90,0x00,0x50,0x00,0x30,

0xC7,0xBF, 0xF7,0xE0,0x14,0x20,0x14,0x20,0xF7,0xE0,0x81,0x00,0x87,0xE0,0xF5,0x20,0x17,0xE0,// 强 //
           0x15,0x00,0x11,0x20,0xAF,0xF0,0x40,0x10,

0xCA,0xAA, 0x4F,0xE0,0x28,0x20,0x0F,0xE0,0x88,0x20,0x4F,0xE0,0x28,0x20,0x42,0x90,0xD2,0xA0,// 湿 //
           0x4A,0xC0,0x4A,0x80,0x42,0x80,0x7F,0xF0,

0xCE,0xC2, 0x4F,0xC0,0x28,0x40,0x0F,0xC0,0x88,0x40,0x4F,0xC0,0x28,0x40,0x40,0x00,0xDF,0xE0,// 温 //
           0x54,0xA0,0x54,0xA0,0x54,0xA0,0x7F,0xF0,

0xD1,0xB9, 0x00,0x20,0x3F,0xF0,0x20,0x00,0x22,0x00,0x22,0x40,0x2F,0xE0,0x22,0x00,0x22,0x80,// 压 //
           0x42,0x40,0x42,0x20,0x82,0x00,0xBF,0xF0,

0xA1,0xE6, 0x00,0x00,0x67,0x00,0x68,0xC0,0x10,0x40,0x30,0x00,0x30,0x00,0x30,0x00,0x30,0x00,// ℃ //
           0x10,0x40,0x08,0x80,0x07,0x00,0x00,0x00,




/* 最后一行必须用0xFF,0xFF结束，这是字库数组结束标志 */
0xFF,0xFF

};
