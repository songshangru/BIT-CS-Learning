`timescale 1ns / 1ps

`include "head.vh"

module control(
    input   [5:0]   opcode,
    input   [5:0]   func,
    
    output  [3:0]   cu_cA,
    output          cu_jmp,
    output          cu_br,
    output          d_we,
    output          reg_we,
    output          cu_alu_src,
    output          cu_wd_dst,
    output          cu_unsign_ext,
    output          cu_wd_src
    );
    
    wire [3:0] inst_id = get_inst_id(opcode, func);
    function [3:0] get_inst_id(input [5:0] opcode, input [5:0] func);
    begin
        case (opcode)
            `INST_ADDI  : get_inst_id = `ID_ADDI;
            `INST_ADDIU : get_inst_id = `ID_ADDIU;
            `INST_LUI   : get_inst_id = `ID_LUI;
            `INST_SW    : get_inst_id = `ID_SW;
            `INST_LW    : get_inst_id = `ID_LW;
            `INST_BEQ   : get_inst_id = `ID_BEQ;
            `INST_J     : get_inst_id = `ID_J;
            `INST_FUNC  : begin
                case (func)
                    `FUNC_ADD   : get_inst_id = `ID_ADD;
                    `FUNC_ADDU  : get_inst_id = `ID_ADDU;
                    default     : get_inst_id = `ID_NULL;
                endcase
            end
            default     : get_inst_id = `ID_NULL;
        endcase
    end
    endfunction
    
    assign cu_cA  = get_alu_op(inst_id);
    function [3:0] get_alu_op(input [3:0] inst_id);
    begin
        case (inst_id)
            `ID_ADDI, `ID_ADDIU, `ID_ADD, `ID_ADDU, `ID_SW, `ID_LW   : get_alu_op = `ALU_ADD;
            `ID_BEQ                              : get_alu_op = `ALU_SUB;
            `ID_LUI                              : get_alu_op = `ALU_LUI;
            default                              : get_alu_op = `ALU_NULL;
        endcase
    end
    endfunction
    
    assign cu_br  = (inst_id == `ID_BEQ) ? 1 : 0;
    
    assign cu_jmp = (inst_id == `ID_J  ) ? 1 : 0;
                   
    assign d_we   = (inst_id == `ID_SW ) ? 1 : 0;
    
    reg [9:0] mask_reg_we = 10'b0001011111;
    assign reg_we = mask_reg_we[inst_id];
    
    reg [9:0] mask_alu_src = 10'b0001101101;
    assign cu_alu_src = mask_alu_src[inst_id];
    
    reg [9:0] mask_wd_dst = 10'b0000010010;
    assign cu_wd_dst  = mask_wd_dst[inst_id];
    
    assign cu_unsign_ext  = (inst_id == `ID_ADDIU || inst_id == `ID_ADDU ) ? 1 : 0;
    
    assign cu_wd_src  = (inst_id == `ID_LW ) ? 1 : 0;
   
endmodule
