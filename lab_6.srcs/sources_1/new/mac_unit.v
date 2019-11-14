`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/12/2019 07:18:38 PM
// Design Name: 
// Module Name: mac_unit
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


module mac_unit(
    input clk,
    input en,
    input [7:0] f1,
    input [7:0] f2,
    output reg [7:0] acc,
    output overflow,
    output underflow,
    output nan
);
    
    wire [7:0] fout;
    wire overflow_mult;
    wire underflow_mult;
    
    reg [7:0] f1_add;
    reg [7:0] f2_add;
    wire [7:0] fout_add;
    wire overflow_add;
    wire underflow_add;
    
    assign overflow = overflow_mult | overflow_add;
    assign underflow = underflow_mult | underflow_add;

    initial
        acc = 0;
    
    fp_multiplier fp_multiplier(
        .f1(f1),
        .f2(f2),
        .fout(fout),
        .overflow(overflow_mult),
        .underflow(underflow_mult),
        .nan(nan)
    );
    
    fp_adder fp_adder(
        .f1(f1_add),
        .f2(f2_add),
        .fout(fout_add),
        .overflow(overflow_add),
        .underflow(underflow_add)
    );
    
    always @(posedge clk) begin
        if (en) begin
            if (overflow || underflow || nan)
                acc = 0;
            else begin
                if (f1 != 0 && f2 != 0) begin
                    f1_add = acc;
                    f2_add = fout;
                    acc = fout_add;
                end
                // multiply by 0 doesn't change acc
            end
        end
    end
endmodule
