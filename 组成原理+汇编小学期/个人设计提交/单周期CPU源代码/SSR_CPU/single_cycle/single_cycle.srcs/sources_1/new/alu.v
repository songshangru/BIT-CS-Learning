`timescale 1ns / 1ps
`include "head.vh"

module alu(
    input  wire       clk,
    input  wire       rst,
    
    input  wire[3:0]  alu_op,
    input  wire[31:0] alu_in1,
    input  wire[31:0] alu_in2,
    
    output reg [31:0] alu_out,
    output wire       alu_zero
    
    );
    reg zero;
    
    wire [31:0] in1   = alu_in1;
    wire [31:0] in2   = alu_in2;
    
    wire [32:0] in1_e = {alu_in1[31], alu_in1};
    wire [32:0] in2_e = {alu_in2[31], alu_in2};
    wire [32:0] o_add = in1_e + in2_e;
    wire [32:0] o_sub = in1_e - in2_e;
    
    always @(*) begin
        case (alu_op)
            `ALU_ADD    : alu_out <= o_add;
            `ALU_SUB    : alu_out <= o_sub;
            `ALU_LUI    : alu_out <= {alu_in2[15:0], 16'b0};
            default     : alu_out = `INITIAL_VAL;
        endcase
    end
    
    assign alu_zero = (alu_out == 0) ? 1 : 0;
    
endmodule
