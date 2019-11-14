`timescale 1ns / 1ps

module fp_adder(
    input [7:0] f1,
    input [7:0] f2,
    output reg [7:0] fout,
    output reg overflow,
    output reg underflow
    );

    reg [11:0] shf_sum;
    reg [4:0] f1_frac;
    reg [4:0] f2_frac;
    wire [2:0] f1_exp;
    wire [2:0] f2_exp;
    
    assign f1_exp = f1[6:4]; // get exponents
    assign f2_exp = f2[6:4];
        
    always@(*) begin
        if(f1[6:4] == 3'b000) f1_frac = {1'b0,f1[3:0]}; // check for 0 or else create the "fraction"
            else f1_frac = {1'b1,f1[3:0]};
        if(f2[6:4] == 3'b000) f2_frac = {1'b0,f2[3:0]};
                else f2_frac = {1'b1,f2[3:0]};   
             
        if(f1_exp >= f2_exp) begin // how are we going to shift?
            case({f1[7],f2[7]})
                2'b00: begin 
                    shf_sum = (f1_frac << f1_exp) + (f2_frac << f2_exp); 
                    fout[7] = 0; 
                end
                2'b01: begin 
                    shf_sum = (f1_frac << f1_exp) - (f2_frac << f2_exp); 
                    fout[7] = 0;
                end 
                2'b10: begin 
                    shf_sum = (f1_frac << f1_exp) - (f2_frac << f2_exp); 
                    fout[7] = 1;
                end
                2'b11: begin 
                    shf_sum = (f1_frac << f1_exp) + (f2_frac << f2_exp); 
                    fout[7] = 1;
                end 
            endcase      
        end else begin
            case({f1[7],f2[7]})
                2'b00: begin 
                    shf_sum = (f2_frac << f2_exp) + (f1_frac << f1_exp); 
                    fout[7] = 0;
                end
                2'b01: begin 
                    shf_sum = (f2_frac << f2_exp) - (f1_frac << f1_exp); 
                    fout[7] = 1;
                end 
                2'b10: begin 
                    shf_sum = (f2_frac << f2_exp) - (f1_frac << f1_exp); 
                    fout[7] = 0;
                end
                2'b11: begin 
                    shf_sum = (f2_frac << f2_exp) + (f1_frac << f1_exp); 
                    fout[7] = 1;
                end 
            endcase
        end
        if(shf_sum[11]) begin 
            overflow = 1;
        end
        else if(shf_sum[10]) begin 
            fout[6:4] = 6; 
            fout[3:0] = shf_sum[9:6]; 
        end
        else if(shf_sum[9]) begin 
            fout[6:4] = 5; 
            fout[3:0] = shf_sum[8:5];
        end
        else if(shf_sum[8]) begin 
            fout[6:4] = 4; 
            fout[3:0] = shf_sum[7:4];
        end
        else if(shf_sum[7]) begin 
            fout[6:4] = 3; 
            fout[3:0] = shf_sum[6:3];
        end
        else if(shf_sum[6]) begin 
            fout[6:4] = 2; 
            fout[3:0] = shf_sum[5:2];
        end
        else if(shf_sum[5]) begin 
            fout[6:4] = 1; 
            fout[3:0] = shf_sum[4:1];
        end
        else begin 
            fout[6:4] = 0; 
            fout[3:0] = shf_sum[3:0];
        end                                          
    end
    
endmodule