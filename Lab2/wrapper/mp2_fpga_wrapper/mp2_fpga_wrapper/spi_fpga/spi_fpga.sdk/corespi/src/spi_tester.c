/******************************************************************************
*
* Copyright (C) 2009 - 2014 Xilinx, Inc.  All rights reserved.
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files (the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions:
*
* The above copyright notice and this permission notice shall be included in
* all copies or substantial portions of the Software.
*
* Use of the Software is limited solely to applications:
* (a) running on a Xilinx device, or
* (b) that interact with a Xilinx device through a bus or interconnect.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
* XILINX  BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
* WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF
* OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
* SOFTWARE.
*
* Except as contained in this notice, the name of the Xilinx shall not be used
* in advertising or otherwise to promote the sale, use or other dealings in
* this Software without prior written authorization from Xilinx.
*
******************************************************************************/

/*
 * spi_tester.c: Will test send/receive functions of SPI module
 *
 * This application configures UART 16550 to baud rate 9600.
 * PS7 UART (Zynq) is not initialized by this application, since
 * bootrom/bsp configures it to baud rate 115200
 *
 * ------------------------------------------------
 * | UART TYPE   BAUD RATE                        |
 * ------------------------------------------------
 *   uartns550   9600
 *   uartlite    Configurable only in HW design
 *   ps7_uart    115200 (configured by bootrom/bsp)
 */
#define SPI_DEVICE_ID       XPAR_SPI_0_DEVICE_ID
#define GPIO_DEVICE_ID      XPAR_AXI_GPIO_0_DEVICE_ID
#define LED_CHANNEL         0x1

#include <stdio.h>
#include "platform.h"
#include "xparameters.h"
#include "xspi.h"
#include "xgpio.h"
#include "xil_printf.h"

static XSpi SpiInstance;
static XGpio GpioInstance;

int init_spi(XSpi *SpiInstancePtr);
void spi_write(XSpi *SpiInstancePtr, u8 addr, u8 value);
u8 spi_read(XSpi *SpiInstancePtr, u8 addr);
int init_gpio(XGpio *GpioInstancePtr);
void delay(int n);

int main()
{
    xil_printf("Program Started...\n\r");
    init_platform();
    init_spi(&SpiInstance);
    init_gpio(&GpioInstance);
    u8 LED_data = 0x1;
    xil_printf("Writing LED data");
    XGpio_DiscreteWrite(&GpioInstance, LED_CHANNEL, LED_data);
    xil_printf("Tests started.\n\r");
    LED_data |= 0x1<<1;
    XGpio_DiscreteWrite(&GpioInstance, LED_CHANNEL, LED_data);

//    u8 addr = 0;
//    u8 value = 10;
//    spi_write(&SpiInstance, addr, value);
//    u8 res = spi_read(&SpiInstance, addr);
//    xil_printf("Wrote to %X. \"%X\" transmitted. \"%X\" readback.\n\r", addr, value, res);

    int ad = 0;
	int test_value = 0;
	int dutpassed = 1;
    for (ad; ad<127; ad+=1){
    	 for (test_value = 0; test_value<255; test_value+=1){
    		 u8 write_value = test_value;
    		 u8 write_addr = ad;
    		 // Write this value to this address
    		 spi_write(&SpiInstance, write_addr, write_value);
    		 // xil_printf("Writing 0x%X to address 0x%X...\n\r", write_value, write_addr);
    		 // Read value from this address
    		 u8 this_res = spi_read(&SpiInstance, write_addr);
    		 // xil_printf("Reading address 0x%X, received 0x%X, expected 0x%X.\n\r", write_addr, this_res, write_value);
    		 if (this_res != write_value) {
    			 xil_printf("ERROR: Reading address 0x%X, expecting 0x%X, but received 0x%X...\n\r", write_addr, write_value, this_res);
    			 dutpassed = 0;
    		 }
    	 }
    }

    int test2address = 0;
    int test2value = 0;

    for (test2address; test2address<127; test2address+=1){
    	spi_write(&SpiInstance, test2address, 255 - test2address);
    }

    int test2res = 0;
    for (test2address = 0; test2address<127; test2address+=1){
    	test2res = spi_read(&SpiInstance, test2address);
    	xil_printf("0x%X\n\r", test2res);
    }

    if (dutpassed = 1){
    	xil_printf("All tests passed\n\r");
    } else {
    	xil_printf("Device failed\n\r");
    }

    LED_data |= 0x1<<2;
    xil_printf("Tests complete.");

    XGpio_DiscreteWrite(&GpioInstance, LED_CHANNEL, LED_data);
    LED_data |= 0x1<<3;
    XGpio_DiscreteWrite(&GpioInstance, LED_CHANNEL, LED_data);
    cleanup_platform();
    return 0;
}

void spi_write(XSpi *SpiInstancePtr, u8 addr, u8 value){
    u8 send[2];             //an array of 2 bytes (8 bits each)
    send[0] = (addr<<1);    //fill the first half with the address bits shifted over 1
    send[1] = value;        //fill the second half with the value
    XSpi_Transfer(SpiInstancePtr, send, NULL, 2);   //see piazza for explanation of this; we only want to send, don't care about receive
}

u8 spi_read(XSpi *SpiInstancePtr, u8 addr){
    u8 rec[2];      //array of 2 bytes (8 bits each); used for final read
    u8 send2[2];    //same as above; used for sending
    send2[0] = (addr<<1);       //fill the first half with the address bits shifted over 1
    send2[0] |= 0x01;           //OR the LSB of the address with 1; always want this bit to be 1 to indicate a READ operation
    send2[1] = addr;            //bc we are only reading using the first address, this is junk, fill it with anything
    XSpi_Transfer(SpiInstancePtr, send2, rec, 2);     //see piazza; we want to send an address and receive data
    return rec[1];      //we want the second element which cooresponds to the data at the address of send2; the first element is junk
}

int init_gpio(XGpio *GpioInstancePtr){
    int Status;
    Status = XGpio_Initialize(GpioInstancePtr, GPIO_DEVICE_ID);
    if (Status != XST_SUCCESS) {
        return XST_FAILURE;
    }
    XGpio_SetDataDirection(GpioInstancePtr, LED_CHANNEL, 0x0);
    return XST_SUCCESS;
}

int init_spi(XSpi *SpiInstancePtr){
    int Status;
    XSpi_Config *ConfigPtr; /* Pointer to Configuration data */

    ConfigPtr = XSpi_LookupConfig(SPI_DEVICE_ID);
    if (ConfigPtr == NULL) {
        return XST_DEVICE_NOT_FOUND;
    }
    Status = XSpi_CfgInitialize(SpiInstancePtr, ConfigPtr,
                  ConfigPtr->BaseAddress);
    if (Status != XST_SUCCESS) {
        return XST_FAILURE;
    }
    Status = XSpi_SelfTest(SpiInstancePtr);
    if (Status != XST_SUCCESS) {
        return XST_FAILURE;
    }
    if (SpiInstancePtr->SpiMode != XSP_STANDARD_MODE) {
        return XST_SUCCESS;
    }
    Status = XSpi_SetOptions(SpiInstancePtr, XSP_MASTER_OPTION);
    if (Status != XST_SUCCESS) {
        return XST_FAILURE;
    }
    XSpi_Start(SpiInstancePtr);
    XSpi_IntrGlobalDisable(SpiInstancePtr);
    return XST_SUCCESS;
}

void delay(int n){
    int i;
    volatile int k;
    for(i = 0; i < n; i++){
        k++;
    }
}
