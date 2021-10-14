`include "macro.vh"

module exe_mem(
    input clk,
    input rst,
    //input data signal
    input wire _zero,
    input wire[31:0] _pc,
    input wire[31:0] _alu_res,
    input wire[31:0] _reg_rd2,//data2 read from regfile
    input wire[4:0] _reg_wa,//data address written to regfile
    //input control signal
    input wire _reg_src,//data written to regfile from alu0 or mem1
    input wire _pc_src,
    input wire _en_reg_write,
    input wire _en_mem_write,
    //output data signal
    output reg[31:0] pc_,
    output reg[31:0] alu_res_,
    output reg[31:0] reg_rd2_,
    output reg[4:0] reg_wa_,
    //output control signal
    output reg reg_src_,//data written to regfile from alu0 or mem1
    output reg pc_src_,
    output reg en_reg_write_,
    output reg en_mem_write_
);

    always @(posedge clk) begin
        if(!rst) begin    
            pc_             <= `INIT_32;
            alu_res_        <= `INIT_32;
            reg_rd2_        <= `INIT_32;
            reg_wa_         <= `INIT_5;
            reg_src_        <= 0;
            pc_src_         <= 0;
            en_reg_write_   <= 0;
            en_mem_write_   <= 0;
        end
        else begin
            pc_             <= _pc;
            alu_res_        <= _alu_res;
            reg_rd2_        <= _reg_rd2;
            reg_wa_         <= _reg_wa;
            reg_src_        <= _reg_src;
            pc_src_         <= _pc_src;
            en_reg_write_   <= _en_reg_write;
            en_mem_write_   <= _en_mem_write;
        end
    end
    

endmodule