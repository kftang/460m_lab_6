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
    input clk,
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
    output [7:0] ab22,
    output done
);
    reg [7:0] mac1_f1;
    reg [7:0] mac1_f2;
    reg [7:0] mac2_f1;
    reg [7:0] mac2_f2;
    reg [7:0] mac3_f1;
    reg [7:0] mac3_f2;
    reg [7:0] mac4_f1;
    reg [7:0] mac4_f2;
    reg [7:0] mac5_f1;
    reg [7:0] mac5_f2;
    reg [7:0] mac6_f1;
    reg [7:0] mac6_f2;
    reg [7:0] mac7_f1;
    reg [7:0] mac7_f2;
    reg [7:0] mac8_f1;
    reg [7:0] mac8_f2;
    reg [7:0] mac9_f1;
    reg [7:0] mac9_f2;
    reg [8:0] mac_ens;
    wire [8:0] overflows;
    wire [8:0] underflows;
    wire [8:0] nans;
    
    mac_unit mac1(
        .clk(clk),
        .en(mac_ens[0]),
        .f1(mac1_f1),
        .f2(mac1_f2),
        .acc(ab00),
        .overflow(overflows[0]),
        .underflow(underflows[0]),
        .nan(nans[0])
    );
    mac_unit mac2(
        .clk(clk),
        .en(mac_ens[1]),
        .f1(mac2_f1),
        .f2(mac2_f2),
        .acc(ab01),
        .overflow(overflows[1]),
        .underflow(underflows[1]),
        .nan(nans[1])
    );
    mac_unit mac3(
        .clk(clk),
        .en(mac_ens[2]),
        .f1(mac3_f1),
        .f2(mac3_f2),
        .acc(ab02),
        .overflow(overflows[2]),
        .underflow(underflows[2]),
        .nan(nans[2])
    );
    mac_unit mac4(
        .clk(clk),
        .en(mac_ens[3]),
        .f1(mac4_f1),
        .f2(mac4_f2),
        .acc(ab10),
        .overflow(overflows[3]),
        .underflow(underflows[3]),
        .nan(nans[3])
    );
    mac_unit mac5(
        .clk(clk),
        .en(mac_ens[4]),
        .f1(mac5_f1),
        .f2(mac5_f2),
        .acc(ab11),
        .overflow(overflows[4]),
        .underflow(underflows[4]),
        .nan(nans[4])
    );
    mac_unit mac6(
        .clk(clk),
        .en(mac_ens[5]),
        .f1(mac6_f1),
        .f2(mac6_f2),
        .acc(ab12),
        .overflow(overflows[5]),
        .underflow(underflows[5]),
        .nan(nans[5])
    );
    mac_unit mac7(
        .clk(clk),
        .en(mac_ens[6]),
        .f1(mac7_f1),
        .f2(mac7_f2),
        .acc(ab20),
        .overflow(overflows[6]),
        .underflow(underflows[6]),
        .nan(nans[6])
    );
    mac_unit mac8(
        .clk(clk),
        .en(mac_ens[7]),
        .f1(mac8_f1),
        .f2(mac8_f2),
        .acc(ab21),
        .overflow(overflows[7]),
        .underflow(underflows[7]),
        .nan(nans[7])
    );
    mac_unit mac9(
        .clk(clk),
        .en(mac_ens[8]),
        .f1(mac9_f1),
        .f2(mac9_f2),
        .acc(ab22),
        .overflow(overflows[8]),
        .underflow(underflows[8]),
        .nan(nans[8])
    );
    
    reg [3:0] counter;
    assign done = counter > 6;
    
    initial
        counter = 0;
        
    always @(posedge clk) begin
        case (counter)
            0: begin
                mac1_f1 = a00;
                mac1_f2 = b00;
                // mac1
                mac_ens = 9'b000000001;
            end
            1: begin
                mac2_f1 = mac1_f1;
                mac2_f2 = b01;
                mac4_f1 = a10;
                mac4_f2 = mac1_f2;
                
                mac1_f1 = a01;
                mac1_f2 = b10;
                // mac1, mac2, mac4
                mac_ens = 9'b000001011;
            end
            2: begin
                mac3_f1 = mac2_f1;
                mac3_f2 = b02;
                mac5_f1 = mac4_f1;
                mac5_f2 = mac2_f2;
                mac7_f1 = a20;
                mac7_f2 = mac4_f2;
                
                mac1_f1 = a02;
                mac1_f2 = b20;
                mac2_f1 = mac1_f1;
                mac2_f2 = b11;
                mac4_f1 = a11;
                mac4_f2 = mac1_f2;
                // mac1, mac2, mac4, mac3, mac5, mac7
                mac_ens = 9'b001011111;
            end
            3: begin
                mac6_f1 = mac5_f1;
                mac6_f2 = mac3_f2;
                mac8_f1 = mac7_f1;
                mac8_f2 = mac4_f2;
                
                mac3_f1 = mac2_f1;
                mac3_f2 = b12;
                mac5_f1 = mac4_f1;
                mac5_f2 = mac2_f2;
                mac7_f1 = a21;
                mac7_f2 = mac4_f2;
                
                mac2_f1 = mac1_f1;
                mac2_f2 = b21;
                mac4_f1 = a12;
                mac4_f2 = mac1_f2;
                // mac1 (done), mac2, mac4, mac3, mac5, mac7, mac6, mac8
                mac_ens = 9'b111111110;
            end
            4: begin
                mac9_f1 = mac8_f1;
                mac9_f2 = mac6_f2;
                
                mac6_f1 = mac5_f1;
                mac6_f2 = mac3_f2;
                mac8_f1 = mac7_f1;
                mac8_f2 = mac4_f2;
                
                mac3_f1 = mac2_f1;
                mac3_f2 = b22;
                mac5_f1 = mac4_f1;
                mac5_f2 = mac2_f2;
                mac7_f1 = a22;
                mac7_f2 = mac4_f2;
                
                // mac1 (done), mac2 (done), mac4 (done), mac3, mac5, mac7, mac6, mac8, mac9
                mac_ens = 9'b111110100;
            end
            5: begin
                mac9_f1 = mac8_f1;
                mac9_f2 = mac6_f2;
                
                mac6_f1 = mac5_f1;
                mac6_f2 = mac3_f2;
                mac8_f1 = mac7_f1;
                mac8_f2 = mac4_f2;
                                
                // mac1 (done), mac2 (done), mac4 (done), mac3 (done), mac5 (done), mac7 (done), mac6, mac8, mac9
                mac_ens = 9'b110100000;
            end
            6: begin
                mac9_f1 = mac8_f1;
                mac9_f2 = mac6_f2;
                mac_ens = 9'b100000000;
            end
            7: mac_ens = 9'b000000000;
        endcase
        counter = counter + 1;
    end
endmodule
