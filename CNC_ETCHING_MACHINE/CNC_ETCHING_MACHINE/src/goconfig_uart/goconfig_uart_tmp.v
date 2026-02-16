//Copyright (C)2014-2025 Gowin Semiconductor Corporation.
//All rights reserved.
//File Title: Template file for instantiation
//Tool Version: V1.9.12 (64-bit)
//Part Number: GW1NR-LV9QN88C6/I5
//Device: GW1NR-9
//Device Version: C
//Created Time: Wed Feb 11 23:20:57 2026

//Change the instance name and port connections to the signal names
//--------Copy here to design--------

	goConfig_UART_Top your_instance_name(
		.GW_BACKGROUND_INT_SCLK(GW_BACKGROUND_INT_SCLK), //output GW_BACKGROUND_INT_SCLK
		.GW_BACKGROUND_INT_CS_N(GW_BACKGROUND_INT_CS_N), //output GW_BACKGROUND_INT_CS_N
		.GW_BACKGROUND_INT_MOSI(GW_BACKGROUND_INT_MOSI), //output GW_BACKGROUND_INT_MOSI
		.GW_BACKGROUND_INT_MISO(GW_BACKGROUND_INT_MISO), //input GW_BACKGROUND_INT_MISO
		.GW_BACKGROUND_EXT_RX(GW_BACKGROUND_EXT_RX), //input GW_BACKGROUND_EXT_RX
		.GW_BACKGROUND_EXT_TX(GW_BACKGROUND_EXT_TX), //output GW_BACKGROUND_EXT_TX
		.GW_BACKGROUND_RECONFIG_N(GW_BACKGROUND_RECONFIG_N), //output GW_BACKGROUND_RECONFIG_N
		.GW_RSTN(GW_RSTN), //input GW_RSTN
		.GW_OSC_CLK(GW_OSC_CLK) //input GW_OSC_CLK
	);

//--------Copy end-------------------
