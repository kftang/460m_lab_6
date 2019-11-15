`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/14/2019 04:06:59 PM
// Design Name: 
// Module Name: tb_mac_unit
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


module tb_mac_unit;

    reg clk;
    reg en;
    reg [7:0] f1;
    reg [7:0] f2;
    wire [7:0] acc;
    wire overflow;
    wire underflow;
    wire nan;
    
    mac_unit mac_unit(
        .clk(clk),
        .en(en),
        .f1(f1),
        .f2(f2),
        .acc(acc),
        .overflow(overflow),
        .underflow(underflow),
        .nan(nan)
    );
    
    always
        #10 clk = ~clk;
    
    initial begin
        clk = 0;
        en = 1;
        f1 = 8'b00110000; // 1 = 0x30
        f2 = 8'b00110000; // 1
        #80;
        f2 = 8'b01000000; // 2 = 0x40
        // 3 = 11.000 = 0 100 1000 = 0x48
        // 4 = 100.00 = 0 101 0000 = 0x50
        // 6 = 110.00 = 0 101 1000 = 0x58
        // 8 = 1000.0 = 0 110 0000 = 0x60
        #40;
    end
endmodule
