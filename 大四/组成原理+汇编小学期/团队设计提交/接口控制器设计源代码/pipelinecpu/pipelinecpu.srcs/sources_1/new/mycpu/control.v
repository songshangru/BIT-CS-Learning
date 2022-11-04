`timescale 1ns / 1ps
`include "macro.vh"

module control(
    input [5:0] instr,
    input [5:0] func,
    
    output [`ALU_OP_LEN-1:0] alu_op,//add,sub,and,or,xor,nor,lui,null
    output alu_src,//alu num2 from rs or rt:0-rs,1-rt
    output reg_dst,//write to rt or rd:0-rt,1-rd
    output reg_src,//data written to regfile from alu0 or mem1
    output pc_src,
    output en_reg_write,
    output en_mem_write,
    output sign_extend_type
);

    function [`OP_ID_LEN-1:0] get_op_id(input [5:0] instr,input [5:0] func);
    begin
        case(instr)
            `INSTR_ADDI: get_op_id = `ID_ADDI;
            `INSTR_ORI: get_op_id = `ID_ORI;
            `INSTR_XORI: get_op_id = `ID_XORI;
            `INSTR_ANDI: get_op_id = `ID_ANDI;
            `INSTR_LW: get_op_id = `ID_LW;
            `INSTR_SW: get_op_id = `ID_SW;
            `INSTR_LUI: get_op_id = `ID_LUI;
            `INSTR_ADDIU: get_op_id = `ID_ADDIU;
            `INSTR_J: get_op_id = `ID_J;
            `SPECIAL: begin
                case(func)
                    `FUNC_ADD: get_op_id = `ID_ADD;
                    `FUNC_ADDU: get_op_id = `ID_ADDU;
                    `FUNC_SUB: get_op_id = `ID_SUB;
                    `FUNC_SUBU: get_op_id = `ID_SUBU;
                    `FUNC_AND: get_op_id = `ID_AND;
                    `FUNC_OR: get_op_id = `ID_OR;
                    `FUNC_NOR: get_op_id = `ID_NOR;
                    `FUNC_XOR: get_op_id = `ID_XOR;
                    default: get_op_id = `ID_NULL;
                endcase
            end
            default: get_op_id = `ID_NULL;
        endcase
    end
    endfunction
    
    wire [`OP_ID_LEN-1:0] op_id = get_op_id(instr,func);
    
    assign sign_extend_type = (op_id==`ID_ADDU||op_id==`ID_ADDIU||op_id==`ID_ORI||op_id==`ID_ANDI||op_id==`ID_XORI)? 0:1;
    
    assign alu_op = (op_id==`ID_ADDI||op_id==`ID_ADD)? `ALU_ADD:
                    (op_id==`ID_ADDIU||op_id==`ID_ADDU||op_id==`ID_LW||op_id==`ID_SW)? `ALU_ADDU:
                    (op_id==`ID_SUB)? `ALU_SUB:
                    (op_id==`ID_SUBU)? `ALU_SUBU:
                    (op_id==`ID_ANDI||op_id==`ID_AND)? `ALU_AND:
                    (op_id==`ID_ORI||op_id==`ID_OR)? `ALU_OR:
                    (op_id==`ID_XOR||op_id==`ID_XORI)? `ALU_XOR:
                    (op_id==`ID_NOR)? `ALU_NOR:
                    (op_id==`ID_LUI)? `ALU_LUI:`ALU_NULL;
    
    wire [`NUM_OF_INSTR:0] array1 = 18'b010111111111111110;
    assign en_reg_write = array1[op_id];
    
    wire [`NUM_OF_INSTR:0] array2 = 18'b001000000000000000;
    assign en_mem_write = array2[op_id];
    
    wire [`NUM_OF_INSTR:0] array3 = 18'b000011111100011000;
    assign alu_src = array3[op_id];
    
    wire [`NUM_OF_INSTR:0] array4 = 18'b010100000011100110;
    assign reg_dst = array4[op_id];
    
    wire [`NUM_OF_INSTR:0] array5 = 18'b000100000000000000;
    assign reg_src = array5[op_id];
    
    wire [`NUM_OF_INSTR:0] array6 = 18'b100000000000000000;
    assign pc_src = array6[op_id];
    
endmodule
