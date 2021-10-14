`timescale 1ns / 1ps
`include "head.vh"

module cpu(
    input       rstn,
    input       clk,
    //指令接口
    output [31:0] inst_rom_addr,
    input  [31:0] inst_rom_rdata,
    //数据接口
    output [31:0] data_ram_addr,
    output [31:0] data_ram_wdata,
    output        data_ram_wen,
    input  [31:0] data_ram_rdata    
    );

    //pc
    wire        pc_jmp;
    wire        pc_beq;
    wire [31:0] pc_off;
    wire [31:0] pc_tar;
    wire [31:0] pc_val;
    pc ssr_pc(
        .clk(clk),
        .rst(rstn),
        .pc_jmp(pc_jmp),
        .pc_beq(pc_beq),
        .pc_off(pc_off),
        .pc_tar(pc_tar),
        .pc_val(pc_val)
    );
    
    //regfile
    wire [4:0]  reg_ra1;
    wire [4:0]  reg_ra2;
    wire        reg_we;
    wire [4:0]  reg_wa;
    wire [31:0] reg_wd;
    wire [31:0] reg_rd1;
    wire [31:0] reg_rd2;
    regfile ssr_regfile(
        .clk(clk),
        .rst(rstn),
        .reg_we(reg_we),
        .reg_ra1(reg_ra1),
        .reg_ra2(reg_ra2),
        .reg_wa(reg_wa),
        .reg_wd(reg_wd),
        .reg_rd1(reg_rd1),
        .reg_rd2(reg_rd2)
    );
    
    //alu
    wire [3:0]  alu_op;
    wire [31:0] alu_in1;
    wire [31:0] alu_in2;
    wire [31:0] alu_out; 
    wire        alu_zero;
    alu ssr_alu(
        .clk(clk),
        .rst(rstn),
        .alu_op(alu_op),
        .alu_in1(alu_in1),
        .alu_in2(alu_in2),
        .alu_out(alu_out),
        .alu_zero(alu_zero)
    );
    
    //cu
    wire [5:0]  opcode;
    wire [5:0]  func;
    wire        d_we;
    wire        cu_alu_src;
    wire        cu_wd_dst;
    wire        cu_unsign_ext;
    wire        cu_wd_src;
    wire        cu_br;
    control ssr_cu(
        .opcode(opcode),
        .func(func),
        .cu_cA(alu_op),
        .cu_jmp(pc_jmp),
        .cu_br(cu_br),
        .d_we(d_we),
        .reg_we(reg_we),
        .cu_alu_src(cu_alu_src),
        .cu_wd_dst(cu_wd_dst),
        .cu_unsign_ext(cu_unsign_ext),
        .cu_wd_src(cu_wd_src)
    );
    
    //link inst_rom
    wire [31:0] instr; 
    assign inst_rom_addr = pc_val;
    assign instr = inst_rom_rdata;
    assign opcode   = instr[31:26];
    assign func     = instr[5:0];
    
    //link data_ram
    wire [31:0] d_rdata;
    assign data_ram_addr = alu_out;
    assign data_ram_wdata = reg_rd2;
    assign data_ram_wen = d_we;
    assign d_rdata = data_ram_rdata;
    
    //sign_extend
    wire [31:0] imm_e;
    assign imm_e    = (cu_unsign_ext) ? {16'b0,instr[15:0]}:{{16{instr[15]}}, instr[15:0]};
    
    //link pc
    assign pc_tar   = instr[25:0];
    assign pc_off   = instr[15:0];
    assign pc_beq   = cu_br & alu_zero;
    
    //link regfile
    assign reg_ra1  = instr[25:21];
    assign reg_ra2  = instr[20:16];
    assign reg_wa   = (cu_wd_dst == 1) ? instr[15:11] : instr[20:16];
    assign reg_wd   = (cu_wd_src == 1) ? d_rdata : alu_out;
    
    //link alu
    assign alu_in1  = reg_rd1;
    assign alu_in2  = (cu_alu_src == 1) ? imm_e : reg_rd2;
    
endmodule
