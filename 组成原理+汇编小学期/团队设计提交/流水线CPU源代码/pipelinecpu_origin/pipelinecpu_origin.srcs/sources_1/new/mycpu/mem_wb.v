`include "macro.vh"

module mem_wb(
    input clk,
    input rst,
    //data
    input wire[31:0] _mem_rd,//data read from memory
    input wire[4:0] _reg_wa,//data address written to regfile
    input wire[31:0] _alu_res,
    //control
    input wire _reg_src,
    input wire _en_reg_write,
    //data
    output reg[31:0] mem_rd_,
    output reg[31:0] alu_res_,
    output reg[4:0] reg_wa_,
    //control
    output reg reg_src_,
    output reg en_reg_write_
);
    always @(posedge clk) begin
        if(!rst) begin    
            mem_rd_         <= `INIT_32;
            alu_res_        <= `INIT_32;
            reg_wa_         <= `INIT_5;
            reg_src_        <= 0;
            en_reg_write_   <= 0;
        end
        else begin
            mem_rd_         <= _mem_rd;
            alu_res_        <= _alu_res;
            reg_src_        <= _reg_src;
            reg_wa_         <= _reg_wa;
            en_reg_write_   <= _en_reg_write;
        end
    end

endmodule
