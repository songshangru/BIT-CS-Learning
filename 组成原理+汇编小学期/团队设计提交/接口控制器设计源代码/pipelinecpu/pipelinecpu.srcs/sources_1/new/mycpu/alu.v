`include "macro.vh"

module alu(
    input wire[31:0] num1,
    input wire[31:0] num2,
    input wire[`ALU_OP_LEN - 1:0] alu_op,
    output wire zero,
    output wire[31:0] alu_res,
    output wire error
);

reg[32:0] alu_res_tmp;
wire[32:0] num1_tmp;
wire[32:0] num2_tmp;
assign alu_res = alu_res_tmp[31:0];
assign num1_tmp = {num1[31], num1};
assign num2_tmp = {num2[31], num2};

//error detection
assign error = (alu_res_tmp[32] != alu_res[31]) ? 1 : 0;

always @ (*) begin
    case (alu_op)
        `ALU_LUI:
            alu_res_tmp <= {num2[15:0] , `INIT_16};
            
        // normal arithmetic operations
        `ALU_ADD,`ALU_ADDU:
            alu_res_tmp <= num1_tmp + num2_tmp;
        `ALU_SUB,`ALU_SUBU:
            alu_res_tmp <= num1_tmp - num2_tmp;

        // bit operations
        `ALU_AND:
            alu_res_tmp <= num1_tmp & num2_tmp;
        `ALU_OR :
            alu_res_tmp <= num1_tmp | num2_tmp;
        `ALU_NOR:
            alu_res_tmp <= ~(num1_tmp | num2_tmp);
        `ALU_XOR:
            alu_res_tmp <= num1_tmp ^ num2_tmp;
        `ALU_NULL:
            alu_res_tmp <= num2_tmp;
    endcase
end

endmodule