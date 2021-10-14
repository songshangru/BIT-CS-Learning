
`define SPECIAL 6'b000000
`define INSTR_ADDI 6'b001000
`define INSTR_ADDIU 6'b001001
`define INSTR_ORI 6'b001101
`define INSTR_XORI 6'b001110
`define INSTR_ANDI 6'b001100
`define INSTR_LW 6'b100011
`define INSTR_SW 6'b101011
`define INSTR_LUI 6'b001111
`define INSTR_J 6'b000010

`define FUNC_ADD 6'b100000
`define FUNC_ADDU 6'b100001
`define FUNC_SUB 6'b100010
`define FUNC_SUBU 6'b100011
`define FUNC_AND 6'b100100
`define FUNC_OR 6'b100101
`define FUNC_NOR 6'b100111
`define FUNC_XOR 6'b100110

//op_id in cu
`define ID_NULL 0
`define ID_ADDI 1
`define ID_ADDIU 2
`define ID_ADD 3
`define ID_ADDU 4
`define ID_ORI 5
`define ID_XORI 6
`define ID_ANDI 7
`define ID_SUB 8
`define ID_SUBU 9
`define ID_AND 10
`define ID_OR 11
`define ID_NOR 12
`define ID_XOR 13
`define ID_LW 14
`define ID_SW 15
`define ID_LUI 16
`define ID_J 17

//alu_op signal from cu to alu
`define ALU_NULL 0
`define ALU_ADD 1
`define ALU_ADDU 2
`define ALU_SUB 3
`define ALU_SUBU 4
`define ALU_AND 5
`define ALU_OR 6
`define ALU_XOR 7
`define ALU_NOR 8
`define ALU_LUI 9

//init value
`define INIT_32 32'h00000000
`define INIT_16 16'h0000
`define INIT_5  5'b00000
`define INIT_4 4'b0000
`define INIT_3 3'b000

`define ALU_OP_LEN 4
`define OP_ID_LEN 5
`define NUM_OF_INSTR 17