`timescale 1ns / 1ps
`include "head.vh"

module pc(
    input       clk,
    input       rst,
    input       pc_jmp,
    input       pc_beq,
    //beq
    input   [31:0] pc_off,
    //jmp
    input   [31:0] pc_tar,
    output  [31:0] pc_val
    );
    reg     [31:0]  pc_reg;
    wire    [31:0]  pc_ds;
    assign pc_ds = pc_reg + 32'h4;
    
    always @(posedge clk or negedge rst) begin
        if(!rst) pc_reg <= `INITIAL_VAL;
        else if(pc_jmp) pc_reg <= {pc_ds[31:28],pc_tar[25:0],2'b00};
        else if(pc_beq) pc_reg <= pc_ds + (pc_off << 2);
        else pc_reg <= pc_ds;
    end
    
    assign pc_val = pc_reg;
    
endmodule
