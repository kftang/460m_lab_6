`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/14/2019 03:48:33 PM
// Design Name: 
// Module Name: tb_fp_adder
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


module tb_fp_adder;

    reg [7:0] f1;
    reg [7:0] f2;
    wire [7:0] fout;
    wire overflow;
    wire underflow;
    
    fp_adder fp_adder(
        .f1(f1),
        .f2(f2),
        .fout(fout),
        .overflow(overflow),
        .underflow(underflow)
    );
    
    initial begin
        f1 = 0;
        f2 = 0;
        #10;
        f1 = 8'b00100000; // 0 010 0000 (.5)
        f2 = 8'b00100000; // 0 010 0000 (.5) 1.0000 * 2^(2 - 3)
        // fout should = 1 (0 011 0000) = 0x30
        #20;
        f2 = 8'b00010000; // 0 001 0000 (.25) 1.0000 * 2^(1 - 3)
        // fout should = .75 0.1100 (0 010 1000) = 0x28 = 1.1000 * 2^(2 - 3)
        #20;
        f2 = 8'b01000101; // 0 100 0101 (2 5/8) 1.0101 * 2^(4 - 3) = 10.101
        // fout should be 3 1/8 = 11.001 = 1.1001 * 2^(4 - 3) = 0 100 1001 = 0x49
        #20;
        f1 = 8'b11011101; // 1 101 1101 (-7 1/4) 1.1101 * 2^(5 - 3) = 111.01
        // f1 fraction = 0xD
        // f2 fraction = 0x5
        // fout should be -4 5/8 = 100.101 = 1.00101 * 2^(5 - 3) = 1 101 0010 = 0xD2
        #20;
        f1 = 8'b10111100; // 1 011 1100 (-1.75) 1.1100 * 2^(3 - 3) = 1.1100
        f2 = 8'b11100100; // 1 110 0100 (-10) 1.0100 * 2^(6 - 3) = 1010.0
        // fout should be -11.75 1011.11 = 1.01111 * 2^(6 - 3) = 1 110 0111 = 0xE7
        #20;
        f1 = 8'b01100100; // 0 110 0100 (10)
        // fout should be 0 = 0x00
        #20;
        f1 = 8'b00100000; // 0 010 0000 (.5) 1.0000 * 2^(2 - 3)
        f2 = 8'b01001000; // 0 100 1000 (3) 1.1000 * 2^(4 - 3)
        // fout should be 3.5 11.100 = 1.1100 * 2^(4-3) = 0 100 1100 = 0x4C
    end
endmodule
