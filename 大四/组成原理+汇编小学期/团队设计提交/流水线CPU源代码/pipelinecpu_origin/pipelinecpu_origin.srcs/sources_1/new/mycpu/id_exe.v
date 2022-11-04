`include "macro.vh"

module id_exe(
    input clk,
    input rst,
    
    input wire[31:0] _pc,
    input wire[31:0] _rd1,
    input wire[31:0] _rd2,
    input wire[4:0] _rt,//20-16
    input wire[4:0] _rd,//15-11
    input wire[31:0] _imm,
    
    //input control signal
    input wire[`ALU_OP_LEN-1:0] _alu_op,
    input wire _alu_src,//alu num2 from rs or rt:0-rs,1-rt
    input wire _reg_dst,//write to rt or rd:0-rt,1-rd
    input wire _reg_src,//data written to regfile from alu0 or mem1
    input wire _pc_src,
    input wire _en_reg_write,
    input wire _en_mem_write,
    input wire pause,
    
    //output data signal
    output reg[31:0] pc_,
    output reg[31:0] rd1_,
    output reg[31:0] rd2_,
    output reg[4:0] rt_,//20-16
    output reg[4:0] rd_,//15-11
    output reg[31:0] imm_,
    //output control signal
    output reg[`ALU_OP_LEN-1:0] alu_op_,
    output reg alu_src_,//alu num2 from rs or rt:0-rs,1-rt
    output reg reg_dst_,//write to rt or rd:0-rt,1-rd
    output reg reg_src_,//data written to regfile from alu0 or mem1
    output reg pc_src_,
    output reg en_reg_write_,
    output reg en_mem_write_
);
    always @(posedge clk) begin
        if(!rst) begin    
            pc_             <= `INIT_32;
            rd1_            <= `INIT_32;
            rd2_            <= `INIT_32;
            rt_             <= `INIT_5;
            rd_             <= `INIT_5;
            imm_            <= `INIT_32;
            alu_op_         <= `INIT_4;
            alu_src_        <= 0;
            reg_dst_        <= 0;
            reg_src_        <= 0;
            pc_src_         <= 0;
            en_reg_write_   <= 0;
            en_mem_write_   <= 0;
        end
        else if(pause) begin
            pc_             <= `INIT_32;
            rd1_            <= `INIT_32;
            rd2_            <= `INIT_32;
            rt_             <= `INIT_5;
            rd_             <= `INIT_5;
            imm_            <= `INIT_32;
            alu_op_         <= `INIT_4;
            alu_src_        <= 0;
            reg_dst_        <= 0;
            reg_src_        <= 0;
            pc_src_         <= 0;
            en_reg_write_   <= 0;
            en_mem_write_   <= 0;
        end
        else begin
            pc_             <= _pc;
            rd1_            <= _rd1;
            rd2_            <= _rd2;
            rt_             <= _rt;
            rd_             <= _rd;
            imm_            <= _imm;
            alu_op_         <= _alu_op;
            alu_src_        <= _alu_src;
            reg_dst_        <= _reg_dst;
            reg_src_        <= _reg_src;
            pc_src_         <= _pc_src;
            en_reg_write_   <= _en_reg_write;
            en_mem_write_   <= _en_mem_write;
        end
    end
    
endmodule