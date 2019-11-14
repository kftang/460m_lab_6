`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/12/2019 07:18:38 PM
// Design Name: 
// Module Name: matrix_multiplier
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module matrix_multiplier(
    input [7:0] a00,
    input [7:0] a01,
    input [7:0] a02,
    input [7:0] a10,
    input [7:0] a11,
    input [7:0] a12,
    input [7:0] a20,
    input [7:0] a21,
    input [7:0] a22,
    input [7:0] b00,
    input [7:0] b01,
    input [7:0] b02,
    input [7:0] b10,
    input [7:0] b11,
    input [7:0] b12,
    input [7:0] b20,
    input [7:0] b21,
    input [7:0] b22,
    output [7:0] ab00,
    output [7:0] ab01,
    output [7:0] ab02,
    output [7:0] ab10,
    output [7:0] ab11,
    output [7:0] ab12,
    output [7:0] ab20,
    output [7:0] ab21,
    output [7:0] ab22
);
    
    mac_unit mac1();
    mac_unit mac2();
    mac_unit mac3();
    mac_unit mac4();
    mac_unit mac5();
    mac_unit mac6();
    mac_unit mac7();
    mac_unit mac8();
    mac_unit mac9();
endmodule
