`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/13/2019 03:03:03 AM
// Design Name: 
// Module Name: tb_fp_multiplier
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


module tb_fp_multiplier;

    reg [7:0] f1;
    reg [7:0] f2;
    wire [7:0] fout;
    wire overflow;
    wire underflow;
    
    fp_multiplier fp_multiplier(
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
        // fout should = .25 (0 001 0000) = 0x10
        #20;
        f2 = 8'b00010000; // 0 001 0000 (.25) 1.0000 * 2^(1 - 3)
        // fout should = .125 (0 000 000) 1.0000 * 2^(0 - 3) which is underflow
        #20;
        f2 = 8'b01000101; // 0 100 0101 (2 5/8) 1.0101 * 2^(4 - 3) = 10.101
        // fout should be 1 5/16 = 1.0101 = 0 011 0101 = 0x35
        #20;
        f1 = 8'b11011101; // 1 101 1101 (7 1/4) 1.1101 * 2^(5 - 3) = 111.01
        // f1 fraction = 0xD
        // f2 fraction = 0x5
        // fout should be -19 1/32 = 10011.00001 = 1.0011 * 2^(7 - 3) = 1 111 0011 = 0xF3
        #20;
        f1 = 8'b10111100; // 1 011 1100 (-1.75) 1.1100 * 2^(3 - 3) = 1.1100
        f2 = 8'b11100100; // 1 110 0100 (-10) 1.0100 * 2^(6 - 3) = 1010.0
        // fout should be 17.5 10001.1 = 1.00011 * 2^(7 - 3) = 0 111 0001 = 0x71
        #20;
        f1 = 8'b01100100; // 0 110 0100 (10)
        // fout should overflow
        #20;
        f1 = 8'b00100000; // 0 010 0000 (.5) 1.0000 * 2^(2 - 3)
        f2 = 8'b01001000; // 0 100 1000 (3) 1.1000 * 2^(4 - 3)
        // fout should be 1.5 1.1000 = 1.1000 * 2^(3-3) = 0 011 1000 = 0x38
    end
endmodule
