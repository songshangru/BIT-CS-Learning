`timescale 1ns / 1ps
include "macro.vh";

// 放在第二个周期，根据译码结果得出是否要加空指令
module stall(
    input clk,
    input rst,
    input [31:0] instr, // current instruction
    
    output pause, //  pause==1 stop the if_id, id_exe barriers and pc (in case of raw)
    output drop //  drop==1 drop the instruction on if_id barrier (in case of jump)
);

    wire [5:0] opcode;
    wire [5:0] func;
    wire [4:0] ra1;  // read address 1
    wire [4:0] ra2;  // read address 2
    wire [4:0] wa;  // write back address
    
    assign opcode = instr[31:26];
    assign func = instr[5:0];
    assign ra1 = (opcode == `INSTR_ADDI) ? instr[25:21] :
                 (opcode == `INSTR_ADDIU) ? instr[25:21] :
                (opcode == `INSTR_ORI) ? instr[25:21] :
                (opcode == `INSTR_XORI) ? instr[25:21] :
                (opcode == `INSTR_ANDI) ? instr[25:21] :
                (opcode == `INSTR_LW) ? instr[25:21] :
                (opcode == `INSTR_SW) ? instr[25:21] :
                (opcode == `INSTR_LUI) ? 0 :
                (opcode == `INSTR_J) ? 0 :
                (opcode == `SPECIAL) ? (
                    (func == `FUNC_ADD) ? instr[25:21] :
                    (func == `FUNC_ADDU) ? instr[25:21] :
                    (func == `FUNC_SUB) ? instr[25:21] :
                    (func == `FUNC_SUBU) ? instr[25:21] :
                    (func == `FUNC_AND) ? instr[25:21] :
                    (func == `FUNC_OR) ? instr[25:21] :
                    (func == `FUNC_NOR) ? instr[25:21] :
                    (func == `FUNC_XOR) ? instr[25:21] :
                    0) :
                0;
                 
    assign ra2 = (opcode == `INSTR_ADDI) ? 0 :
                 (opcode == `INSTR_ADDIU) ? 0 :
                (opcode == `INSTR_ORI) ? 0 :
                (opcode == `INSTR_XORI) ? 0 :
                (opcode == `INSTR_ANDI) ? 0 :
                (opcode == `INSTR_LW) ? 0 :
                (opcode == `INSTR_SW) ? instr[20:16] :
                (opcode == `INSTR_LUI) ? 0 :
                (opcode == `INSTR_J) ? 0 :
                (opcode == `SPECIAL) ? (
                    (func == `FUNC_ADD) ? instr[20:16] :
                    (func == `FUNC_ADDU) ? instr[20:16] :
                    (func == `FUNC_SUB) ? instr[20:16] :
                    (func == `FUNC_SUBU) ? instr[20:16] :
                    (func == `FUNC_AND) ? instr[20:16] :
                    (func == `FUNC_OR) ? instr[20:16] :
                    (func == `FUNC_NOR) ? instr[20:16] :
                    (func == `FUNC_XOR) ? instr[20:16] :
                    0) :
                0;
                
    assign wa = (opcode == `INSTR_ADDI) ? instr[20:16] :
                (opcode == `INSTR_ADDIU) ? instr[20:16] :
                (opcode == `INSTR_ORI) ? instr[20:16] :
                (opcode == `INSTR_XORI) ? instr[20:16] :
                (opcode == `INSTR_ANDI) ? instr[20:16] :
                (opcode == `INSTR_LW) ? instr[20:16] :
                (opcode == `INSTR_SW) ? 0 :
                (opcode == `INSTR_LUI) ? instr[20:16] :
                (opcode == `INSTR_J) ? 0 :
                (opcode == `SPECIAL) ? (
                    (func == `FUNC_ADD) ? instr[15:11] :
                    (func == `FUNC_ADDU) ? instr[15:11] :
                    (func == `FUNC_SUB) ? instr[15:11] :
                    (func == `FUNC_SUBU) ? instr[15:11] :
                    (func == `FUNC_AND) ? instr[15:11] :
                    (func == `FUNC_OR) ? instr[15:11] :
                    (func == `FUNC_NOR) ? instr[15:11] :
                    (func == `FUNC_XOR) ? instr[15:11] :
                    0) :
                0;
    
    reg [4:0] buff1; // previous wa
    reg [4:0] buff2; // previous previous wa
    reg [4:0] buff3; // previous previous previous wa
    always @(posedge clk or negedge rst) begin
        if (!rst) begin
            buff1 <= 0;
            buff2 <= 0;
            buff3 <= 0;
        end
        else begin
            buff1 <= wa & {5{(!pause)}};
            buff2 <= buff1;
            buff3 <= buff2;
        end
    end
    
    assign pause = (opcode == `SPECIAL) ? (
                        (func == `FUNC_ADD || func == `FUNC_ADDU || func == `FUNC_SUB || func == `FUNC_SUBU || func == `FUNC_AND || func == `FUNC_OR || func == `FUNC_NOR || func == `FUNC_XOR) ? (
                            ((buff1 == ra1 || buff2 == ra1 || buff3 == ra1) && ra1 != 0) ? 1 :
                            ((buff1 == ra2 || buff2 == ra2 || buff3 == ra2) && ra2 != 0) ? 1 :
                            0) :
                        0) :
                   (opcode == `INSTR_ADDI || opcode == `INSTR_ADDIU || opcode == `INSTR_ORI || opcode == `INSTR_XORI || opcode == `INSTR_ANDI || opcode == `INSTR_LW || opcode == `INSTR_LUI) ? (
                        ((buff1 == ra1 || buff2 == ra1 || buff3 == ra1) && ra1 != 0) ? 1 :
                        ((buff1 == ra2 || buff2 == ra2 || buff3 == ra2) && ra2 != 0) ? 1 :
                        0) :
                   (opcode == `INSTR_SW || opcode == `INSTR_J) ? (
                        ((buff1 == ra1 || buff2 == ra1 || buff3 == ra1) && ra1 != 0) ? 1 :
                        ((buff1 == ra2 || buff2 == ra2 || buff3 == ra2) && ra2 != 0) ? 1 :
                        0) :
                   0;
    
    assign drop = (opcode == `INSTR_J) ? 1 : 0;
    
endmodule