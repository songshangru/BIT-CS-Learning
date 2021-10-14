//I-Type
`define INST_LUI        6'b001111  // LUI
`define INST_ADDIU      6'b001001  // ADDIU
`define INST_ADDI       6'b001000  // ADDI
`define INST_LW         6'b100011  // LW
`define INST_SW         6'b101011  // SW
`define INST_BEQ        6'b000100  // BEQ

//J-Type
`define INST_J          6'b000010  // J

//R-Type
`define INST_FUNC       6'b000000
`define FUNC_ADD        6'b100000  // ADD func code
`define FUNC_ADDU       6'b100001  // ADDU func code

// init register data
`define INITIAL_VAL     32'h00000000

// alu cmd def
`define ALU_ADD     0
`define ALU_SUB     1
`define ALU_LUI     2
`define ALU_NULL    3

// inst_type id def
`define ID_ADDI     0
`define ID_ADD      1
`define ID_LUI      2
`define ID_ADDIU    3
`define ID_ADDU     4
`define ID_SW       5
`define ID_LW       6
`define ID_BEQ      7
`define ID_J        8
`define ID_NULL     9
