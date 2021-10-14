`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/09/02 09:42:55
// Design Name: 
// Module Name: cpu
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module cpu(
    input clk,
    input rst,
    input [31:0] imem_rd,
    input [31:0] dmem_rd,
    
    output dmem_wen,
    output [31:0] dmem_wd,
    output [31:0] dmem_ra,
    output [31:0] imem_ra
    );
    
    wire [31:0] pc_out;
    wire [31:0] pc_in;
    wire [31:0] pc_ds;
    wire pause;
    wire drop;
    
    assign pc_ds = pc_out+4;
    assign pc_in = (exe_mem_pc_src)? exe_mem_pc:pc_ds;
    
    pc pc(
        .rst(rst),
        .clk(clk),
        .pause(pause),
        .pc_in(pc_in),
        
        .pc_out(pc_out)
        );
    assign imem_ra = pc_out;
    
    wire [31:0] instr_;
    wire [31:0] if_id_pc;
    
    if_id if_id(
        .clk(clk),
        .rst(rst),
        ._pc(pc_ds),
        ._instr(imem_rd),
        .pause(pause),
        .drop(drop),
        
        .instr_(instr_),
        .pc_(if_id_pc)
    );
    
    wire [31:0] reg_rd1;
    wire [31:0] reg_rd2;
    wire [31:0] reg_wd;
    wire [31:0] mem_wb_reg_wa;
    wire mem_wb_en_reg_write;
    
    regfile regfile(
        .clk(clk),
        .rst(rst),
        .ra1(instr_[25:21]),
        .ra2(instr_[20:16]),
        .en_write(mem_wb_en_reg_write),
        .wd(reg_wd),
        .wa(mem_wb_reg_wa),
        
        .rd1(reg_rd1),
        .rd2(reg_rd2)
    );
    
    wire [`ALU_OP_LEN-1:0] alu_op;
    wire alu_src;
    wire reg_dst;
    wire reg_src;
    wire pc_src;
    wire en_reg_write;
    wire en_mem_write;
    wire sign_extend_type;
    
    control control(
        .instr(instr_[31:26]),
        .func(instr_[5:0]),
        
        .alu_op(alu_op),
        .alu_src(alu_src),
        .reg_dst(reg_dst),
        .reg_src(reg_src),
        .pc_src(pc_src),
        .en_reg_write(en_reg_write),
        .en_mem_write(en_mem_write),
        .sign_extend_type(sign_extend_type)
    );
    
    wire [31:0] id_exe_pc;
    wire [31:0] id_exe_rd1;
    wire [31:0] id_exe_rd2;
    wire [4:0] id_exe_rt;
    wire [4:0] id_exe_rd;
    wire [31:0] id_exe_imm;
    
    wire [`ALU_OP_LEN-1:0] id_exe_alu_op;
    wire id_exe_alu_src;
    wire id_exe_reg_dst;
    wire id_exe_pc_src;
    wire id_exe_en_reg_write;
    wire id_exe_en_mem_write;
    wire [31:0] id_exe_imm_in;
    
    assign id_exe_imm_in = (sign_extend_type)? {{16{instr_[15]}},instr_[15:0]}:{16'b0,instr_[15:0]};
    
    id_exe id_exe(
        .clk(clk),
        .rst(rst),
        
        .pause(pause),
        ._pc(if_id_pc),
        ._rd1(reg_rd1),
        ._rd2(reg_rd2),
        ._rt(instr_[20:16]),
        ._rd(instr_[15:11]),
        ._imm(id_exe_imm_in),
        
        ._alu_op(alu_op),
        ._alu_src(alu_src),
        ._reg_dst(reg_dst),
        ._reg_src(reg_src),
        ._pc_src(pc_src),
        ._en_reg_write(en_reg_write),
        ._en_mem_write(en_mem_write),
        
        .pc_(id_exe_pc),
        .rd1_(id_exe_rd1),
        .rd2_(id_exe_rd2),
        .rt_(id_exe_rt),
        .rd_(id_exe_rd),
        .imm_(id_exe_imm),
        
        .alu_op_(id_exe_alu_op),
        .alu_src_(id_exe_alu_src),
        .reg_dst_(id_exe_reg_dst),
        .reg_src_(id_exe_reg_src),
        .pc_src_(id_exe_pc_src),
        .en_reg_write_(id_exe_en_reg_write),
        .en_mem_write_(id_exe_en_mem_write)
    );
    
    wire [31:0] alu_res;
    wire error;
    wire [31:0] alu_num2_in;
    assign alu_num2_in = (id_exe_alu_src)? id_exe_rd2:id_exe_imm;
    
    alu alu(
        .num1(id_exe_rd1),
        .num2(alu_num2_in),
        .alu_op(id_exe_alu_op),
        
        .alu_res(alu_res),
        .error(error)
    );
    
    wire [31:0] exe_mem_pc;
    wire [31:0] exe_mem_alu_res;
    wire [31:0] exe_mem_reg_wa;
    
    wire exe_mem_reg_src;
    wire exe_mem_pc_src;
    wire exe_mem_en_reg_write;
    wire [4:0] reg_wa_in;
    wire [31:0] pc_exe_mem_in;
    
    assign reg_wa_in = (id_exe_reg_dst)? id_exe_rt:id_exe_rd;
    assign pc_exe_mem_in = {id_exe_pc[31:28],id_exe_imm[25:0],2'b00};
    
    exe_mem exe_mem(
        .clk(clk),
        .rst(rst),
        
        ._pc(pc_exe_mem_in),
        ._alu_res(alu_res),
        ._reg_rd2(id_exe_rd2),
        ._reg_wa(reg_wa_in),
        
        ._reg_src(id_exe_reg_src),
        ._pc_src(id_exe_pc_src),
        ._en_reg_write(id_exe_en_reg_write),
        ._en_mem_write(id_exe_en_mem_write),
        
        .pc_(exe_mem_pc),
        .alu_res_(exe_mem_alu_res),
        .reg_rd2_(dmem_wd),
        .reg_wa_(exe_mem_reg_wa),
        
        .reg_src_(exe_mem_reg_src),
        .pc_src_(exe_mem_pc_src),
        .en_reg_write_(exe_mem_en_reg_write),
        .en_mem_write_(dmem_wen)
    );
    
    assign dmem_ra = exe_mem_alu_res;
    
    wire [31:0] mem_wb_mem_rd;
    wire [31:0] mem_wb_alu_res;
    
    wire mem_wb_reg_src;
    
    mem_wb mem_wb(
        .clk(clk),
        .rst(rst),
        
        ._mem_rd(dmem_rd),
        ._reg_wa(exe_mem_reg_wa),
        ._alu_res(exe_mem_alu_res),
        
        ._reg_src(exe_mem_reg_src),
        ._en_reg_write(exe_mem_en_reg_write),
        
        .mem_rd_(mem_wb_mem_rd),
        .alu_res_(mem_wb_alu_res),
        .reg_wa_(mem_wb_reg_wa),
        
        .reg_src_(mem_wb_reg_src),
        .en_reg_write_(mem_wb_en_reg_write)
    );
    
    assign reg_wd = (mem_wb_reg_src)? mem_wb_mem_rd:mem_wb_alu_res;
    
    
    stall stall(
        .clk(clk),
        .rst(rst),
        .instr(instr_),
        
        .pause(pause),
        .drop(drop)
    );


endmodule
