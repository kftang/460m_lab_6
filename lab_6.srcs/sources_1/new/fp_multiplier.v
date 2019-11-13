`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/12/2019 07:18:38 PM
// Design Name: 
// Module Name: fp_multiplier
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


module fp_multiplier(
    input [7:0] f1,
    input [7:0] f2,
    output [7:0] fout,
    output overflow,
    output underflow
);
    wire f1_sign;
    wire f2_sign;
    wire [4:0] f1_frac;
    wire [4:0] f2_frac;
    wire [2:0] f1_exp;
    wire [2:0] f2_exp;
    
    assign f1_sign = f1[7];
    assign f2_sign = f2[7];
    assign f1_frac = {1'b1, f1[3:0]};
    assign f2_frac = {1'b1, f2[3:0]};
    assign f1_exp = f1[6:4];
    assign f2_exp = f2[6:4];
    
    wire [4:0] line_1;
    wire [5:0] line_2;
    wire [6:0] line_3;
    wire [7:0] line_4;
    wire [8:0] line_5;
    assign line_1 = f2_frac[0] ? f1_frac : 5'b0;
    assign line_2 = f2_frac[1] ? {f1_frac, 1'b0} : 6'b0;
    assign line_3 = f2_frac[2] ? {f1_frac, 2'b0} : 7'b0;
    assign line_4 = f2_frac[3] ? {f1_frac, 3'b0} : 8'b0;
    assign line_5 = f2_frac[4] ? {f1_frac, 4'b0} : 9'b0;
    
    wire [9:0] mult_sum;
    wire [3:0] mult_frac;
    assign mult_sum = line_1 + line_2 + line_3 + line_4 + line_5;
    assign mult_frac = mult_sum[8:5];
    
    wire [3:0] mult_exp;
    assign mult_exp = f1_exp + f2_exp - 3;
    assign overflow = f1_exp > 7;
    assign underflow = f1_exp + f2_exp < 4;
    
    wire mult_sign;
    assign mult_sign = f1_sign ^ f2_sign;
    assign fout = {mult_sign, mult_exp[2:0], mult_frac};
    
endmodule
