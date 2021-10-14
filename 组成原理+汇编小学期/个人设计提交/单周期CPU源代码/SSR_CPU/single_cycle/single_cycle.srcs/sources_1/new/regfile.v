`timescale 1ns / 1ps
`include "head.vh"

module regfile(
    input  wire       clk,
    input  wire       rst,

    input  wire[4:0]  reg_ra1,
    input  wire[4:0]  reg_ra2,
    
    input  wire       reg_we,
    input  wire[4:0]  reg_wa,
    input  wire[31:0] reg_wd,
    
    output wire[31:0] reg_rd1,
    output wire[31:0] reg_rd2
    );
    reg [31:0] regs[31:0];
    
    assign reg_rd1 = ( (reg_ra1 == 0) ? `INITIAL_VAL : regs[reg_ra1] );
    assign reg_rd2 = ( (reg_ra2 == 0) ? `INITIAL_VAL : regs[reg_ra2] );
    
    integer i;
    always @(posedge clk or negedge rst) begin
        if (!rst) begin
            for (i = 0; i <= 31; i = i + 1) regs[i] <= `INITIAL_VAL;
        end
        else if (reg_we == 1'b1 && reg_wa != 5'b0) regs[reg_wa] <= reg_wd;
    end
    
endmodule
