// Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2019.2 (win64) Build 2708876 Wed Nov  6 21:40:23 MST 2019
// Date        : Wed Sep 22 19:47:52 2021
// Host        : LAPTOP-MU8B2MRR running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim -rename_top decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix -prefix
//               decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ data_ram_sim_netlist.v
// Design      : data_ram
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7a35tcsg324-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "data_ram,dist_mem_gen_v8_0_13,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "dist_mem_gen_v8_0_13,Vivado 2019.2" *) 
(* NotValidForBitStream *)
module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix
   (a,
    d,
    clk,
    we,
    spo);
  input [9:0]a;
  input [31:0]d;
  input clk;
  input we;
  output [31:0]spo;

  wire [9:0]a;
  wire clk;
  wire [31:0]d;
  wire [31:0]spo;
  wire we;
  wire [31:0]NLW_U0_dpo_UNCONNECTED;
  wire [31:0]NLW_U0_qdpo_UNCONNECTED;
  wire [31:0]NLW_U0_qspo_UNCONNECTED;

  (* C_FAMILY = "artix7" *) 
  (* C_HAS_CLK = "1" *) 
  (* C_HAS_D = "1" *) 
  (* C_HAS_DPO = "0" *) 
  (* C_HAS_DPRA = "0" *) 
  (* C_HAS_QDPO = "0" *) 
  (* C_HAS_QDPO_CE = "0" *) 
  (* C_HAS_QDPO_CLK = "0" *) 
  (* C_HAS_QDPO_RST = "0" *) 
  (* C_HAS_QDPO_SRST = "0" *) 
  (* C_HAS_WE = "1" *) 
  (* C_MEM_TYPE = "1" *) 
  (* C_QCE_JOINED = "0" *) 
  (* C_REG_DPRA_INPUT = "0" *) 
  (* c_addr_width = "10" *) 
  (* c_default_data = "0" *) 
  (* c_depth = "1024" *) 
  (* c_elaboration_dir = "./" *) 
  (* c_has_i_ce = "0" *) 
  (* c_has_qspo = "0" *) 
  (* c_has_qspo_ce = "0" *) 
  (* c_has_qspo_rst = "0" *) 
  (* c_has_qspo_srst = "0" *) 
  (* c_has_spo = "1" *) 
  (* c_mem_init_file = "no_coe_file_loaded" *) 
  (* c_parser_type = "1" *) 
  (* c_pipeline_stages = "0" *) 
  (* c_qualify_we = "0" *) 
  (* c_read_mif = "0" *) 
  (* c_reg_a_d_inputs = "0" *) 
  (* c_sync_enable = "1" *) 
  (* c_width = "32" *) 
  decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_dist_mem_gen_v8_0_13 U0
       (.a(a),
        .clk(clk),
        .d(d),
        .dpo(NLW_U0_dpo_UNCONNECTED[31:0]),
        .dpra({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .i_ce(1'b1),
        .qdpo(NLW_U0_qdpo_UNCONNECTED[31:0]),
        .qdpo_ce(1'b1),
        .qdpo_clk(1'b0),
        .qdpo_rst(1'b0),
        .qdpo_srst(1'b0),
        .qspo(NLW_U0_qspo_UNCONNECTED[31:0]),
        .qspo_ce(1'b1),
        .qspo_rst(1'b0),
        .qspo_srst(1'b0),
        .spo(spo),
        .we(we));
endmodule

(* C_ADDR_WIDTH = "10" *) (* C_DEFAULT_DATA = "0" *) (* C_DEPTH = "1024" *) 
(* C_ELABORATION_DIR = "./" *) (* C_FAMILY = "artix7" *) (* C_HAS_CLK = "1" *) 
(* C_HAS_D = "1" *) (* C_HAS_DPO = "0" *) (* C_HAS_DPRA = "0" *) 
(* C_HAS_I_CE = "0" *) (* C_HAS_QDPO = "0" *) (* C_HAS_QDPO_CE = "0" *) 
(* C_HAS_QDPO_CLK = "0" *) (* C_HAS_QDPO_RST = "0" *) (* C_HAS_QDPO_SRST = "0" *) 
(* C_HAS_QSPO = "0" *) (* C_HAS_QSPO_CE = "0" *) (* C_HAS_QSPO_RST = "0" *) 
(* C_HAS_QSPO_SRST = "0" *) (* C_HAS_SPO = "1" *) (* C_HAS_WE = "1" *) 
(* C_MEM_INIT_FILE = "no_coe_file_loaded" *) (* C_MEM_TYPE = "1" *) (* C_PARSER_TYPE = "1" *) 
(* C_PIPELINE_STAGES = "0" *) (* C_QCE_JOINED = "0" *) (* C_QUALIFY_WE = "0" *) 
(* C_READ_MIF = "0" *) (* C_REG_A_D_INPUTS = "0" *) (* C_REG_DPRA_INPUT = "0" *) 
(* C_SYNC_ENABLE = "1" *) (* C_WIDTH = "32" *) 
module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_dist_mem_gen_v8_0_13
   (a,
    d,
    dpra,
    clk,
    we,
    i_ce,
    qspo_ce,
    qdpo_ce,
    qdpo_clk,
    qspo_rst,
    qdpo_rst,
    qspo_srst,
    qdpo_srst,
    spo,
    dpo,
    qspo,
    qdpo);
  input [9:0]a;
  input [31:0]d;
  input [9:0]dpra;
  input clk;
  input we;
  input i_ce;
  input qspo_ce;
  input qdpo_ce;
  input qdpo_clk;
  input qspo_rst;
  input qdpo_rst;
  input qspo_srst;
  input qdpo_srst;
  output [31:0]spo;
  output [31:0]dpo;
  output [31:0]qspo;
  output [31:0]qdpo;

  wire \<const0> ;
  wire [9:0]a;
  wire clk;
  wire [31:0]d;
  wire [31:0]spo;
  wire we;

  assign dpo[31] = \<const0> ;
  assign dpo[30] = \<const0> ;
  assign dpo[29] = \<const0> ;
  assign dpo[28] = \<const0> ;
  assign dpo[27] = \<const0> ;
  assign dpo[26] = \<const0> ;
  assign dpo[25] = \<const0> ;
  assign dpo[24] = \<const0> ;
  assign dpo[23] = \<const0> ;
  assign dpo[22] = \<const0> ;
  assign dpo[21] = \<const0> ;
  assign dpo[20] = \<const0> ;
  assign dpo[19] = \<const0> ;
  assign dpo[18] = \<const0> ;
  assign dpo[17] = \<const0> ;
  assign dpo[16] = \<const0> ;
  assign dpo[15] = \<const0> ;
  assign dpo[14] = \<const0> ;
  assign dpo[13] = \<const0> ;
  assign dpo[12] = \<const0> ;
  assign dpo[11] = \<const0> ;
  assign dpo[10] = \<const0> ;
  assign dpo[9] = \<const0> ;
  assign dpo[8] = \<const0> ;
  assign dpo[7] = \<const0> ;
  assign dpo[6] = \<const0> ;
  assign dpo[5] = \<const0> ;
  assign dpo[4] = \<const0> ;
  assign dpo[3] = \<const0> ;
  assign dpo[2] = \<const0> ;
  assign dpo[1] = \<const0> ;
  assign dpo[0] = \<const0> ;
  assign qdpo[31] = \<const0> ;
  assign qdpo[30] = \<const0> ;
  assign qdpo[29] = \<const0> ;
  assign qdpo[28] = \<const0> ;
  assign qdpo[27] = \<const0> ;
  assign qdpo[26] = \<const0> ;
  assign qdpo[25] = \<const0> ;
  assign qdpo[24] = \<const0> ;
  assign qdpo[23] = \<const0> ;
  assign qdpo[22] = \<const0> ;
  assign qdpo[21] = \<const0> ;
  assign qdpo[20] = \<const0> ;
  assign qdpo[19] = \<const0> ;
  assign qdpo[18] = \<const0> ;
  assign qdpo[17] = \<const0> ;
  assign qdpo[16] = \<const0> ;
  assign qdpo[15] = \<const0> ;
  assign qdpo[14] = \<const0> ;
  assign qdpo[13] = \<const0> ;
  assign qdpo[12] = \<const0> ;
  assign qdpo[11] = \<const0> ;
  assign qdpo[10] = \<const0> ;
  assign qdpo[9] = \<const0> ;
  assign qdpo[8] = \<const0> ;
  assign qdpo[7] = \<const0> ;
  assign qdpo[6] = \<const0> ;
  assign qdpo[5] = \<const0> ;
  assign qdpo[4] = \<const0> ;
  assign qdpo[3] = \<const0> ;
  assign qdpo[2] = \<const0> ;
  assign qdpo[1] = \<const0> ;
  assign qdpo[0] = \<const0> ;
  assign qspo[31] = \<const0> ;
  assign qspo[30] = \<const0> ;
  assign qspo[29] = \<const0> ;
  assign qspo[28] = \<const0> ;
  assign qspo[27] = \<const0> ;
  assign qspo[26] = \<const0> ;
  assign qspo[25] = \<const0> ;
  assign qspo[24] = \<const0> ;
  assign qspo[23] = \<const0> ;
  assign qspo[22] = \<const0> ;
  assign qspo[21] = \<const0> ;
  assign qspo[20] = \<const0> ;
  assign qspo[19] = \<const0> ;
  assign qspo[18] = \<const0> ;
  assign qspo[17] = \<const0> ;
  assign qspo[16] = \<const0> ;
  assign qspo[15] = \<const0> ;
  assign qspo[14] = \<const0> ;
  assign qspo[13] = \<const0> ;
  assign qspo[12] = \<const0> ;
  assign qspo[11] = \<const0> ;
  assign qspo[10] = \<const0> ;
  assign qspo[9] = \<const0> ;
  assign qspo[8] = \<const0> ;
  assign qspo[7] = \<const0> ;
  assign qspo[6] = \<const0> ;
  assign qspo[5] = \<const0> ;
  assign qspo[4] = \<const0> ;
  assign qspo[3] = \<const0> ;
  assign qspo[2] = \<const0> ;
  assign qspo[1] = \<const0> ;
  assign qspo[0] = \<const0> ;
  GND GND
       (.G(\<const0> ));
  decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_dist_mem_gen_v8_0_13_synth \synth_options.dist_mem_inst 
       (.a(a),
        .clk(clk),
        .d(d),
        .spo(spo),
        .we(we));
endmodule

module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_dist_mem_gen_v8_0_13_synth
   (spo,
    clk,
    d,
    a,
    we);
  output [31:0]spo;
  input clk;
  input [31:0]d;
  input [9:0]a;
  input we;

  wire [9:0]a;
  wire clk;
  wire [31:0]d;
  wire [31:0]spo;
  wire we;

  decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_spram \gen_sp_ram.spram_inst 
       (.a(a),
        .clk(clk),
        .d(d),
        .spo(spo),
        .we(we));
endmodule

module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_spram
   (spo,
    clk,
    d,
    a,
    we);
  output [31:0]spo;
  input clk;
  input [31:0]d;
  input [9:0]a;
  input we;

  wire [9:0]a;
  wire clk;
  wire [31:0]d;
  (* RTL_KEEP = "true" *) wire [31:0]qspo_int;
  wire ram_reg_0_255_0_0_i_1_n_0;
  wire ram_reg_0_255_0_0_n_0;
  wire ram_reg_0_255_10_10_n_0;
  wire ram_reg_0_255_11_11_n_0;
  wire ram_reg_0_255_12_12_n_0;
  wire ram_reg_0_255_13_13_n_0;
  wire ram_reg_0_255_14_14_n_0;
  wire ram_reg_0_255_15_15_n_0;
  wire ram_reg_0_255_16_16_n_0;
  wire ram_reg_0_255_17_17_n_0;
  wire ram_reg_0_255_18_18_n_0;
  wire ram_reg_0_255_19_19_n_0;
  wire ram_reg_0_255_1_1_n_0;
  wire ram_reg_0_255_20_20_n_0;
  wire ram_reg_0_255_21_21_n_0;
  wire ram_reg_0_255_22_22_n_0;
  wire ram_reg_0_255_23_23_n_0;
  wire ram_reg_0_255_24_24_n_0;
  wire ram_reg_0_255_25_25_n_0;
  wire ram_reg_0_255_26_26_n_0;
  wire ram_reg_0_255_27_27_n_0;
  wire ram_reg_0_255_28_28_n_0;
  wire ram_reg_0_255_29_29_n_0;
  wire ram_reg_0_255_2_2_n_0;
  wire ram_reg_0_255_30_30_n_0;
  wire ram_reg_0_255_31_31_n_0;
  wire ram_reg_0_255_3_3_n_0;
  wire ram_reg_0_255_4_4_n_0;
  wire ram_reg_0_255_5_5_n_0;
  wire ram_reg_0_255_6_6_n_0;
  wire ram_reg_0_255_7_7_n_0;
  wire ram_reg_0_255_8_8_n_0;
  wire ram_reg_0_255_9_9_n_0;
  wire ram_reg_256_511_0_0_i_1_n_0;
  wire ram_reg_256_511_0_0_n_0;
  wire ram_reg_256_511_10_10_n_0;
  wire ram_reg_256_511_11_11_n_0;
  wire ram_reg_256_511_12_12_n_0;
  wire ram_reg_256_511_13_13_n_0;
  wire ram_reg_256_511_14_14_n_0;
  wire ram_reg_256_511_15_15_n_0;
  wire ram_reg_256_511_16_16_n_0;
  wire ram_reg_256_511_17_17_n_0;
  wire ram_reg_256_511_18_18_n_0;
  wire ram_reg_256_511_19_19_n_0;
  wire ram_reg_256_511_1_1_n_0;
  wire ram_reg_256_511_20_20_n_0;
  wire ram_reg_256_511_21_21_n_0;
  wire ram_reg_256_511_22_22_n_0;
  wire ram_reg_256_511_23_23_n_0;
  wire ram_reg_256_511_24_24_n_0;
  wire ram_reg_256_511_25_25_n_0;
  wire ram_reg_256_511_26_26_n_0;
  wire ram_reg_256_511_27_27_n_0;
  wire ram_reg_256_511_28_28_n_0;
  wire ram_reg_256_511_29_29_n_0;
  wire ram_reg_256_511_2_2_n_0;
  wire ram_reg_256_511_30_30_n_0;
  wire ram_reg_256_511_31_31_n_0;
  wire ram_reg_256_511_3_3_n_0;
  wire ram_reg_256_511_4_4_n_0;
  wire ram_reg_256_511_5_5_n_0;
  wire ram_reg_256_511_6_6_n_0;
  wire ram_reg_256_511_7_7_n_0;
  wire ram_reg_256_511_8_8_n_0;
  wire ram_reg_256_511_9_9_n_0;
  wire ram_reg_512_767_0_0_i_1_n_0;
  wire ram_reg_512_767_0_0_n_0;
  wire ram_reg_512_767_10_10_n_0;
  wire ram_reg_512_767_11_11_n_0;
  wire ram_reg_512_767_12_12_n_0;
  wire ram_reg_512_767_13_13_n_0;
  wire ram_reg_512_767_14_14_n_0;
  wire ram_reg_512_767_15_15_n_0;
  wire ram_reg_512_767_16_16_n_0;
  wire ram_reg_512_767_17_17_n_0;
  wire ram_reg_512_767_18_18_n_0;
  wire ram_reg_512_767_19_19_n_0;
  wire ram_reg_512_767_1_1_n_0;
  wire ram_reg_512_767_20_20_n_0;
  wire ram_reg_512_767_21_21_n_0;
  wire ram_reg_512_767_22_22_n_0;
  wire ram_reg_512_767_23_23_n_0;
  wire ram_reg_512_767_24_24_n_0;
  wire ram_reg_512_767_25_25_n_0;
  wire ram_reg_512_767_26_26_n_0;
  wire ram_reg_512_767_27_27_n_0;
  wire ram_reg_512_767_28_28_n_0;
  wire ram_reg_512_767_29_29_n_0;
  wire ram_reg_512_767_2_2_n_0;
  wire ram_reg_512_767_30_30_n_0;
  wire ram_reg_512_767_31_31_n_0;
  wire ram_reg_512_767_3_3_n_0;
  wire ram_reg_512_767_4_4_n_0;
  wire ram_reg_512_767_5_5_n_0;
  wire ram_reg_512_767_6_6_n_0;
  wire ram_reg_512_767_7_7_n_0;
  wire ram_reg_512_767_8_8_n_0;
  wire ram_reg_512_767_9_9_n_0;
  wire ram_reg_768_1023_0_0_i_1_n_0;
  wire ram_reg_768_1023_0_0_n_0;
  wire ram_reg_768_1023_10_10_n_0;
  wire ram_reg_768_1023_11_11_n_0;
  wire ram_reg_768_1023_12_12_n_0;
  wire ram_reg_768_1023_13_13_n_0;
  wire ram_reg_768_1023_14_14_n_0;
  wire ram_reg_768_1023_15_15_n_0;
  wire ram_reg_768_1023_16_16_n_0;
  wire ram_reg_768_1023_17_17_n_0;
  wire ram_reg_768_1023_18_18_n_0;
  wire ram_reg_768_1023_19_19_n_0;
  wire ram_reg_768_1023_1_1_n_0;
  wire ram_reg_768_1023_20_20_n_0;
  wire ram_reg_768_1023_21_21_n_0;
  wire ram_reg_768_1023_22_22_n_0;
  wire ram_reg_768_1023_23_23_n_0;
  wire ram_reg_768_1023_24_24_n_0;
  wire ram_reg_768_1023_25_25_n_0;
  wire ram_reg_768_1023_26_26_n_0;
  wire ram_reg_768_1023_27_27_n_0;
  wire ram_reg_768_1023_28_28_n_0;
  wire ram_reg_768_1023_29_29_n_0;
  wire ram_reg_768_1023_2_2_n_0;
  wire ram_reg_768_1023_30_30_n_0;
  wire ram_reg_768_1023_31_31_n_0;
  wire ram_reg_768_1023_3_3_n_0;
  wire ram_reg_768_1023_4_4_n_0;
  wire ram_reg_768_1023_5_5_n_0;
  wire ram_reg_768_1023_6_6_n_0;
  wire ram_reg_768_1023_7_7_n_0;
  wire ram_reg_768_1023_8_8_n_0;
  wire ram_reg_768_1023_9_9_n_0;
  wire [31:0]spo;
  wire we;

  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \qspo_int_reg[0] 
       (.C(clk),
        .CE(1'b1),
        .D(spo[0]),
        .Q(qspo_int[0]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \qspo_int_reg[10] 
       (.C(clk),
        .CE(1'b1),
        .D(spo[10]),
        .Q(qspo_int[10]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \qspo_int_reg[11] 
       (.C(clk),
        .CE(1'b1),
        .D(spo[11]),
        .Q(qspo_int[11]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \qspo_int_reg[12] 
       (.C(clk),
        .CE(1'b1),
        .D(spo[12]),
        .Q(qspo_int[12]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \qspo_int_reg[13] 
       (.C(clk),
        .CE(1'b1),
        .D(spo[13]),
        .Q(qspo_int[13]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \qspo_int_reg[14] 
       (.C(clk),
        .CE(1'b1),
        .D(spo[14]),
        .Q(qspo_int[14]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \qspo_int_reg[15] 
       (.C(clk),
        .CE(1'b1),
        .D(spo[15]),
        .Q(qspo_int[15]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \qspo_int_reg[16] 
       (.C(clk),
        .CE(1'b1),
        .D(spo[16]),
        .Q(qspo_int[16]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \qspo_int_reg[17] 
       (.C(clk),
        .CE(1'b1),
        .D(spo[17]),
        .Q(qspo_int[17]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \qspo_int_reg[18] 
       (.C(clk),
        .CE(1'b1),
        .D(spo[18]),
        .Q(qspo_int[18]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \qspo_int_reg[19] 
       (.C(clk),
        .CE(1'b1),
        .D(spo[19]),
        .Q(qspo_int[19]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \qspo_int_reg[1] 
       (.C(clk),
        .CE(1'b1),
        .D(spo[1]),
        .Q(qspo_int[1]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \qspo_int_reg[20] 
       (.C(clk),
        .CE(1'b1),
        .D(spo[20]),
        .Q(qspo_int[20]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \qspo_int_reg[21] 
       (.C(clk),
        .CE(1'b1),
        .D(spo[21]),
        .Q(qspo_int[21]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \qspo_int_reg[22] 
       (.C(clk),
        .CE(1'b1),
        .D(spo[22]),
        .Q(qspo_int[22]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \qspo_int_reg[23] 
       (.C(clk),
        .CE(1'b1),
        .D(spo[23]),
        .Q(qspo_int[23]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \qspo_int_reg[24] 
       (.C(clk),
        .CE(1'b1),
        .D(spo[24]),
        .Q(qspo_int[24]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \qspo_int_reg[25] 
       (.C(clk),
        .CE(1'b1),
        .D(spo[25]),
        .Q(qspo_int[25]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \qspo_int_reg[26] 
       (.C(clk),
        .CE(1'b1),
        .D(spo[26]),
        .Q(qspo_int[26]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \qspo_int_reg[27] 
       (.C(clk),
        .CE(1'b1),
        .D(spo[27]),
        .Q(qspo_int[27]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \qspo_int_reg[28] 
       (.C(clk),
        .CE(1'b1),
        .D(spo[28]),
        .Q(qspo_int[28]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \qspo_int_reg[29] 
       (.C(clk),
        .CE(1'b1),
        .D(spo[29]),
        .Q(qspo_int[29]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \qspo_int_reg[2] 
       (.C(clk),
        .CE(1'b1),
        .D(spo[2]),
        .Q(qspo_int[2]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \qspo_int_reg[30] 
       (.C(clk),
        .CE(1'b1),
        .D(spo[30]),
        .Q(qspo_int[30]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \qspo_int_reg[31] 
       (.C(clk),
        .CE(1'b1),
        .D(spo[31]),
        .Q(qspo_int[31]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \qspo_int_reg[3] 
       (.C(clk),
        .CE(1'b1),
        .D(spo[3]),
        .Q(qspo_int[3]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \qspo_int_reg[4] 
       (.C(clk),
        .CE(1'b1),
        .D(spo[4]),
        .Q(qspo_int[4]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \qspo_int_reg[5] 
       (.C(clk),
        .CE(1'b1),
        .D(spo[5]),
        .Q(qspo_int[5]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \qspo_int_reg[6] 
       (.C(clk),
        .CE(1'b1),
        .D(spo[6]),
        .Q(qspo_int[6]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \qspo_int_reg[7] 
       (.C(clk),
        .CE(1'b1),
        .D(spo[7]),
        .Q(qspo_int[7]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \qspo_int_reg[8] 
       (.C(clk),
        .CE(1'b1),
        .D(spo[8]),
        .Q(qspo_int[8]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \qspo_int_reg[9] 
       (.C(clk),
        .CE(1'b1),
        .D(spo[9]),
        .Q(qspo_int[9]),
        .R(1'b0));
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-5 {cell *THIS*}}" *) 
  (* RTL_RAM_BITS = "32768" *) 
  (* RTL_RAM_NAME = "synth_options.dist_mem_inst/gen_sp_ram.spram_inst/ram" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "255" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "0" *) 
  (* ram_slice_end = "0" *) 
  RAM256X1S #(
    .INIT(256'h0000000000000000000000000000000000000000000000000000000000000000)) 
    ram_reg_0_255_0_0
       (.A(a[7:0]),
        .D(d[0]),
        .O(ram_reg_0_255_0_0_n_0),
        .WCLK(clk),
        .WE(ram_reg_0_255_0_0_i_1_n_0));
  LUT3 #(
    .INIT(8'h02)) 
    ram_reg_0_255_0_0_i_1
       (.I0(we),
        .I1(a[8]),
        .I2(a[9]),
        .O(ram_reg_0_255_0_0_i_1_n_0));
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-5 {cell *THIS*}}" *) 
  (* RTL_RAM_BITS = "32768" *) 
  (* RTL_RAM_NAME = "synth_options.dist_mem_inst/gen_sp_ram.spram_inst/ram" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "255" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "10" *) 
  (* ram_slice_end = "10" *) 
  RAM256X1S #(
    .INIT(256'h0000000000000000000000000000000000000000000000000000000000000000)) 
    ram_reg_0_255_10_10
       (.A(a[7:0]),
        .D(d[10]),
        .O(ram_reg_0_255_10_10_n_0),
        .WCLK(clk),
        .WE(ram_reg_0_255_0_0_i_1_n_0));
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-5 {cell *THIS*}}" *) 
  (* RTL_RAM_BITS = "32768" *) 
  (* RTL_RAM_NAME = "synth_options.dist_mem_inst/gen_sp_ram.spram_inst/ram" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "255" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "11" *) 
  (* ram_slice_end = "11" *) 
  RAM256X1S #(
    .INIT(256'h0000000000000000000000000000000000000000000000000000000000000000)) 
    ram_reg_0_255_11_11
       (.A(a[7:0]),
        .D(d[11]),
        .O(ram_reg_0_255_11_11_n_0),
        .WCLK(clk),
        .WE(ram_reg_0_255_0_0_i_1_n_0));
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-5 {cell *THIS*}}" *) 
  (* RTL_RAM_BITS = "32768" *) 
  (* RTL_RAM_NAME = "synth_options.dist_mem_inst/gen_sp_ram.spram_inst/ram" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "255" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "12" *) 
  (* ram_slice_end = "12" *) 
  RAM256X1S #(
    .INIT(256'h0000000000000000000000000000000000000000000000000000000000000000)) 
    ram_reg_0_255_12_12
       (.A(a[7:0]),
        .D(d[12]),
        .O(ram_reg_0_255_12_12_n_0),
        .WCLK(clk),
        .WE(ram_reg_0_255_0_0_i_1_n_0));
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-5 {cell *THIS*}}" *) 
  (* RTL_RAM_BITS = "32768" *) 
  (* RTL_RAM_NAME = "synth_options.dist_mem_inst/gen_sp_ram.spram_inst/ram" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "255" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "13" *) 
  (* ram_slice_end = "13" *) 
  RAM256X1S #(
    .INIT(256'h0000000000000000000000000000000000000000000000000000000000000000)) 
    ram_reg_0_255_13_13
       (.A(a[7:0]),
        .D(d[13]),
        .O(ram_reg_0_255_13_13_n_0),
        .WCLK(clk),
        .WE(ram_reg_0_255_0_0_i_1_n_0));
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-5 {cell *THIS*}}" *) 
  (* RTL_RAM_BITS = "32768" *) 
  (* RTL_RAM_NAME = "synth_options.dist_mem_inst/gen_sp_ram.spram_inst/ram" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "255" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "14" *) 
  (* ram_slice_end = "14" *) 
  RAM256X1S #(
    .INIT(256'h0000000000000000000000000000000000000000000000000000000000000000)) 
    ram_reg_0_255_14_14
       (.A(a[7:0]),
        .D(d[14]),
        .O(ram_reg_0_255_14_14_n_0),
        .WCLK(clk),
        .WE(ram_reg_0_255_0_0_i_1_n_0));
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-5 {cell *THIS*}}" *) 
  (* RTL_RAM_BITS = "32768" *) 
  (* RTL_RAM_NAME = "synth_options.dist_mem_inst/gen_sp_ram.spram_inst/ram" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "255" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "15" *) 
  (* ram_slice_end = "15" *) 
  RAM256X1S #(
    .INIT(256'h0000000000000000000000000000000000000000000000000000000000000000)) 
    ram_reg_0_255_15_15
       (.A(a[7:0]),
        .D(d[15]),
        .O(ram_reg_0_255_15_15_n_0),
        .WCLK(clk),
        .WE(ram_reg_0_255_0_0_i_1_n_0));
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-5 {cell *THIS*}}" *) 
  (* RTL_RAM_BITS = "32768" *) 
  (* RTL_RAM_NAME = "synth_options.dist_mem_inst/gen_sp_ram.spram_inst/ram" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "255" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "16" *) 
  (* ram_slice_end = "16" *) 
  RAM256X1S #(
    .INIT(256'h0000000000000000000000000000000000000000000000000000000000000000)) 
    ram_reg_0_255_16_16
       (.A(a[7:0]),
        .D(d[16]),
        .O(ram_reg_0_255_16_16_n_0),
        .WCLK(clk),
        .WE(ram_reg_0_255_0_0_i_1_n_0));
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-5 {cell *THIS*}}" *) 
  (* RTL_RAM_BITS = "32768" *) 
  (* RTL_RAM_NAME = "synth_options.dist_mem_inst/gen_sp_ram.spram_inst/ram" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "255" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "17" *) 
  (* ram_slice_end = "17" *) 
  RAM256X1S #(
    .INIT(256'h0000000000000000000000000000000000000000000000000000000000000000)) 
    ram_reg_0_255_17_17
       (.A(a[7:0]),
        .D(d[17]),
        .O(ram_reg_0_255_17_17_n_0),
        .WCLK(clk),
        .WE(ram_reg_0_255_0_0_i_1_n_0));
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-5 {cell *THIS*}}" *) 
  (* RTL_RAM_BITS = "32768" *) 
  (* RTL_RAM_NAME = "synth_options.dist_mem_inst/gen_sp_ram.spram_inst/ram" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "255" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "18" *) 
  (* ram_slice_end = "18" *) 
  RAM256X1S #(
    .INIT(256'h0000000000000000000000000000000000000000000000000000000000000000)) 
    ram_reg_0_255_18_18
       (.A(a[7:0]),
        .D(d[18]),
        .O(ram_reg_0_255_18_18_n_0),
        .WCLK(clk),
        .WE(ram_reg_0_255_0_0_i_1_n_0));
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-5 {cell *THIS*}}" *) 
  (* RTL_RAM_BITS = "32768" *) 
  (* RTL_RAM_NAME = "synth_options.dist_mem_inst/gen_sp_ram.spram_inst/ram" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "255" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "19" *) 
  (* ram_slice_end = "19" *) 
  RAM256X1S #(
    .INIT(256'h0000000000000000000000000000000000000000000000000000000000000000)) 
    ram_reg_0_255_19_19
       (.A(a[7:0]),
        .D(d[19]),
        .O(ram_reg_0_255_19_19_n_0),
        .WCLK(clk),
        .WE(ram_reg_0_255_0_0_i_1_n_0));
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-5 {cell *THIS*}}" *) 
  (* RTL_RAM_BITS = "32768" *) 
  (* RTL_RAM_NAME = "synth_options.dist_mem_inst/gen_sp_ram.spram_inst/ram" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "255" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "1" *) 
  (* ram_slice_end = "1" *) 
  RAM256X1S #(
    .INIT(256'h0000000000000000000000000000000000000000000000000000000000000000)) 
    ram_reg_0_255_1_1
       (.A(a[7:0]),
        .D(d[1]),
        .O(ram_reg_0_255_1_1_n_0),
        .WCLK(clk),
        .WE(ram_reg_0_255_0_0_i_1_n_0));
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-5 {cell *THIS*}}" *) 
  (* RTL_RAM_BITS = "32768" *) 
  (* RTL_RAM_NAME = "synth_options.dist_mem_inst/gen_sp_ram.spram_inst/ram" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "255" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "20" *) 
  (* ram_slice_end = "20" *) 
  RAM256X1S #(
    .INIT(256'h0000000000000000000000000000000000000000000000000000000000000000)) 
    ram_reg_0_255_20_20
       (.A(a[7:0]),
        .D(d[20]),
        .O(ram_reg_0_255_20_20_n_0),
        .WCLK(clk),
        .WE(ram_reg_0_255_0_0_i_1_n_0));
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-5 {cell *THIS*}}" *) 
  (* RTL_RAM_BITS = "32768" *) 
  (* RTL_RAM_NAME = "synth_options.dist_mem_inst/gen_sp_ram.spram_inst/ram" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "255" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "21" *) 
  (* ram_slice_end = "21" *) 
  RAM256X1S #(
    .INIT(256'h0000000000000000000000000000000000000000000000000000000000000000)) 
    ram_reg_0_255_21_21
       (.A(a[7:0]),
        .D(d[21]),
        .O(ram_reg_0_255_21_21_n_0),
        .WCLK(clk),
        .WE(ram_reg_0_255_0_0_i_1_n_0));
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-5 {cell *THIS*}}" *) 
  (* RTL_RAM_BITS = "32768" *) 
  (* RTL_RAM_NAME = "synth_options.dist_mem_inst/gen_sp_ram.spram_inst/ram" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "255" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "22" *) 
  (* ram_slice_end = "22" *) 
  RAM256X1S #(
    .INIT(256'h0000000000000000000000000000000000000000000000000000000000000000)) 
    ram_reg_0_255_22_22
       (.A(a[7:0]),
        .D(d[22]),
        .O(ram_reg_0_255_22_22_n_0),
        .WCLK(clk),
        .WE(ram_reg_0_255_0_0_i_1_n_0));
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-5 {cell *THIS*}}" *) 
  (* RTL_RAM_BITS = "32768" *) 
  (* RTL_RAM_NAME = "synth_options.dist_mem_inst/gen_sp_ram.spram_inst/ram" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "255" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "23" *) 
  (* ram_slice_end = "23" *) 
  RAM256X1S #(
    .INIT(256'h0000000000000000000000000000000000000000000000000000000000000000)) 
    ram_reg_0_255_23_23
       (.A(a[7:0]),
        .D(d[23]),
        .O(ram_reg_0_255_23_23_n_0),
        .WCLK(clk),
        .WE(ram_reg_0_255_0_0_i_1_n_0));
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-5 {cell *THIS*}}" *) 
  (* RTL_RAM_BITS = "32768" *) 
  (* RTL_RAM_NAME = "synth_options.dist_mem_inst/gen_sp_ram.spram_inst/ram" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "255" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "24" *) 
  (* ram_slice_end = "24" *) 
  RAM256X1S #(
    .INIT(256'h0000000000000000000000000000000000000000000000000000000000000000)) 
    ram_reg_0_255_24_24
       (.A(a[7:0]),
        .D(d[24]),
        .O(ram_reg_0_255_24_24_n_0),
        .WCLK(clk),
        .WE(ram_reg_0_255_0_0_i_1_n_0));
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-5 {cell *THIS*}}" *) 
  (* RTL_RAM_BITS = "32768" *) 
  (* RTL_RAM_NAME = "synth_options.dist_mem_inst/gen_sp_ram.spram_inst/ram" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "255" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "25" *) 
  (* ram_slice_end = "25" *) 
  RAM256X1S #(
    .INIT(256'h0000000000000000000000000000000000000000000000000000000000000000)) 
    ram_reg_0_255_25_25
       (.A(a[7:0]),
        .D(d[25]),
        .O(ram_reg_0_255_25_25_n_0),
        .WCLK(clk),
        .WE(ram_reg_0_255_0_0_i_1_n_0));
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-5 {cell *THIS*}}" *) 
  (* RTL_RAM_BITS = "32768" *) 
  (* RTL_RAM_NAME = "synth_options.dist_mem_inst/gen_sp_ram.spram_inst/ram" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "255" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "26" *) 
  (* ram_slice_end = "26" *) 
  RAM256X1S #(
    .INIT(256'h0000000000000000000000000000000000000000000000000000000000000000)) 
    ram_reg_0_255_26_26
       (.A(a[7:0]),
        .D(d[26]),
        .O(ram_reg_0_255_26_26_n_0),
        .WCLK(clk),
        .WE(ram_reg_0_255_0_0_i_1_n_0));
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-5 {cell *THIS*}}" *) 
  (* RTL_RAM_BITS = "32768" *) 
  (* RTL_RAM_NAME = "synth_options.dist_mem_inst/gen_sp_ram.spram_inst/ram" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "255" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "27" *) 
  (* ram_slice_end = "27" *) 
  RAM256X1S #(
    .INIT(256'h0000000000000000000000000000000000000000000000000000000000000000)) 
    ram_reg_0_255_27_27
       (.A(a[7:0]),
        .D(d[27]),
        .O(ram_reg_0_255_27_27_n_0),
        .WCLK(clk),
        .WE(ram_reg_0_255_0_0_i_1_n_0));
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-5 {cell *THIS*}}" *) 
  (* RTL_RAM_BITS = "32768" *) 
  (* RTL_RAM_NAME = "synth_options.dist_mem_inst/gen_sp_ram.spram_inst/ram" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "255" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "28" *) 
  (* ram_slice_end = "28" *) 
  RAM256X1S #(
    .INIT(256'h0000000000000000000000000000000000000000000000000000000000000000)) 
    ram_reg_0_255_28_28
       (.A(a[7:0]),
        .D(d[28]),
        .O(ram_reg_0_255_28_28_n_0),
        .WCLK(clk),
        .WE(ram_reg_0_255_0_0_i_1_n_0));
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-5 {cell *THIS*}}" *) 
  (* RTL_RAM_BITS = "32768" *) 
  (* RTL_RAM_NAME = "synth_options.dist_mem_inst/gen_sp_ram.spram_inst/ram" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "255" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "29" *) 
  (* ram_slice_end = "29" *) 
  RAM256X1S #(
    .INIT(256'h0000000000000000000000000000000000000000000000000000000000000000)) 
    ram_reg_0_255_29_29
       (.A(a[7:0]),
        .D(d[29]),
        .O(ram_reg_0_255_29_29_n_0),
        .WCLK(clk),
        .WE(ram_reg_0_255_0_0_i_1_n_0));
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-5 {cell *THIS*}}" *) 
  (* RTL_RAM_BITS = "32768" *) 
  (* RTL_RAM_NAME = "synth_options.dist_mem_inst/gen_sp_ram.spram_inst/ram" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "255" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "2" *) 
  (* ram_slice_end = "2" *) 
  RAM256X1S #(
    .INIT(256'h0000000000000000000000000000000000000000000000000000000000000000)) 
    ram_reg_0_255_2_2
       (.A(a[7:0]),
        .D(d[2]),
        .O(ram_reg_0_255_2_2_n_0),
        .WCLK(clk),
        .WE(ram_reg_0_255_0_0_i_1_n_0));
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-5 {cell *THIS*}}" *) 
  (* RTL_RAM_BITS = "32768" *) 
  (* RTL_RAM_NAME = "synth_options.dist_mem_inst/gen_sp_ram.spram_inst/ram" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "255" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "30" *) 
  (* ram_slice_end = "30" *) 
  RAM256X1S #(
    .INIT(256'h0000000000000000000000000000000000000000000000000000000000000000)) 
    ram_reg_0_255_30_30
       (.A(a[7:0]),
        .D(d[30]),
        .O(ram_reg_0_255_30_30_n_0),
        .WCLK(clk),
        .WE(ram_reg_0_255_0_0_i_1_n_0));
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-5 {cell *THIS*}}" *) 
  (* RTL_RAM_BITS = "32768" *) 
  (* RTL_RAM_NAME = "synth_options.dist_mem_inst/gen_sp_ram.spram_inst/ram" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "255" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "31" *) 
  (* ram_slice_end = "31" *) 
  RAM256X1S #(
    .INIT(256'h0000000000000000000000000000000000000000000000000000000000000000)) 
    ram_reg_0_255_31_31
       (.A(a[7:0]),
        .D(d[31]),
        .O(ram_reg_0_255_31_31_n_0),
        .WCLK(clk),
        .WE(ram_reg_0_255_0_0_i_1_n_0));
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-5 {cell *THIS*}}" *) 
  (* RTL_RAM_BITS = "32768" *) 
  (* RTL_RAM_NAME = "synth_options.dist_mem_inst/gen_sp_ram.spram_inst/ram" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "255" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "3" *) 
  (* ram_slice_end = "3" *) 
  RAM256X1S #(
    .INIT(256'h0000000000000000000000000000000000000000000000000000000000000000)) 
    ram_reg_0_255_3_3
       (.A(a[7:0]),
        .D(d[3]),
        .O(ram_reg_0_255_3_3_n_0),
        .WCLK(clk),
        .WE(ram_reg_0_255_0_0_i_1_n_0));
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-5 {cell *THIS*}}" *) 
  (* RTL_RAM_BITS = "32768" *) 
  (* RTL_RAM_NAME = "synth_options.dist_mem_inst/gen_sp_ram.spram_inst/ram" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "255" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "4" *) 
  (* ram_slice_end = "4" *) 
  RAM256X1S #(
    .INIT(256'h0000000000000000000000000000000000000000000000000000000000000000)) 
    ram_reg_0_255_4_4
       (.A(a[7:0]),
        .D(d[4]),
        .O(ram_reg_0_255_4_4_n_0),
        .WCLK(clk),
        .WE(ram_reg_0_255_0_0_i_1_n_0));
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-5 {cell *THIS*}}" *) 
  (* RTL_RAM_BITS = "32768" *) 
  (* RTL_RAM_NAME = "synth_options.dist_mem_inst/gen_sp_ram.spram_inst/ram" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "255" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "5" *) 
  (* ram_slice_end = "5" *) 
  RAM256X1S #(
    .INIT(256'h0000000000000000000000000000000000000000000000000000000000000000)) 
    ram_reg_0_255_5_5
       (.A(a[7:0]),
        .D(d[5]),
        .O(ram_reg_0_255_5_5_n_0),
        .WCLK(clk),
        .WE(ram_reg_0_255_0_0_i_1_n_0));
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-5 {cell *THIS*}}" *) 
  (* RTL_RAM_BITS = "32768" *) 
  (* RTL_RAM_NAME = "synth_options.dist_mem_inst/gen_sp_ram.spram_inst/ram" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "255" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "6" *) 
  (* ram_slice_end = "6" *) 
  RAM256X1S #(
    .INIT(256'h0000000000000000000000000000000000000000000000000000000000000000)) 
    ram_reg_0_255_6_6
       (.A(a[7:0]),
        .D(d[6]),
        .O(ram_reg_0_255_6_6_n_0),
        .WCLK(clk),
        .WE(ram_reg_0_255_0_0_i_1_n_0));
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-5 {cell *THIS*}}" *) 
  (* RTL_RAM_BITS = "32768" *) 
  (* RTL_RAM_NAME = "synth_options.dist_mem_inst/gen_sp_ram.spram_inst/ram" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "255" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "7" *) 
  (* ram_slice_end = "7" *) 
  RAM256X1S #(
    .INIT(256'h0000000000000000000000000000000000000000000000000000000000000000)) 
    ram_reg_0_255_7_7
       (.A(a[7:0]),
        .D(d[7]),
        .O(ram_reg_0_255_7_7_n_0),
        .WCLK(clk),
        .WE(ram_reg_0_255_0_0_i_1_n_0));
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-5 {cell *THIS*}}" *) 
  (* RTL_RAM_BITS = "32768" *) 
  (* RTL_RAM_NAME = "synth_options.dist_mem_inst/gen_sp_ram.spram_inst/ram" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "255" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "8" *) 
  (* ram_slice_end = "8" *) 
  RAM256X1S #(
    .INIT(256'h0000000000000000000000000000000000000000000000000000000000000000)) 
    ram_reg_0_255_8_8
       (.A(a[7:0]),
        .D(d[8]),
        .O(ram_reg_0_255_8_8_n_0),
        .WCLK(clk),
        .WE(ram_reg_0_255_0_0_i_1_n_0));
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-5 {cell *THIS*}}" *) 
  (* RTL_RAM_BITS = "32768" *) 
  (* RTL_RAM_NAME = "synth_options.dist_mem_inst/gen_sp_ram.spram_inst/ram" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "255" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "9" *) 
  (* ram_slice_end = "9" *) 
  RAM256X1S #(
    .INIT(256'h0000000000000000000000000000000000000000000000000000000000000000)) 
    ram_reg_0_255_9_9
       (.A(a[7:0]),
        .D(d[9]),
        .O(ram_reg_0_255_9_9_n_0),
        .WCLK(clk),
        .WE(ram_reg_0_255_0_0_i_1_n_0));
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-5 {cell *THIS*}}" *) 
  (* RTL_RAM_BITS = "32768" *) 
  (* RTL_RAM_NAME = "synth_options.dist_mem_inst/gen_sp_ram.spram_inst/ram" *) 
  (* ram_addr_begin = "256" *) 
  (* ram_addr_end = "511" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "0" *) 
  (* ram_slice_end = "0" *) 
  RAM256X1S #(
    .INIT(256'h0000000000000000000000000000000000000000000000000000000000000000)) 
    ram_reg_256_511_0_0
       (.A(a[7:0]),
        .D(d[0]),
        .O(ram_reg_256_511_0_0_n_0),
        .WCLK(clk),
        .WE(ram_reg_256_511_0_0_i_1_n_0));
  LUT3 #(
    .INIT(8'h40)) 
    ram_reg_256_511_0_0_i_1
       (.I0(a[9]),
        .I1(a[8]),
        .I2(we),
        .O(ram_reg_256_511_0_0_i_1_n_0));
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-5 {cell *THIS*}}" *) 
  (* RTL_RAM_BITS = "32768" *) 
  (* RTL_RAM_NAME = "synth_options.dist_mem_inst/gen_sp_ram.spram_inst/ram" *) 
  (* ram_addr_begin = "256" *) 
  (* ram_addr_end = "511" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "10" *) 
  (* ram_slice_end = "10" *) 
  RAM256X1S #(
    .INIT(256'h0000000000000000000000000000000000000000000000000000000000000000)) 
    ram_reg_256_511_10_10
       (.A(a[7:0]),
        .D(d[10]),
        .O(ram_reg_256_511_10_10_n_0),
        .WCLK(clk),
        .WE(ram_reg_256_511_0_0_i_1_n_0));
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-5 {cell *THIS*}}" *) 
  (* RTL_RAM_BITS = "32768" *) 
  (* RTL_RAM_NAME = "synth_options.dist_mem_inst/gen_sp_ram.spram_inst/ram" *) 
  (* ram_addr_begin = "256" *) 
  (* ram_addr_end = "511" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "11" *) 
  (* ram_slice_end = "11" *) 
  RAM256X1S #(
    .INIT(256'h0000000000000000000000000000000000000000000000000000000000000000)) 
    ram_reg_256_511_11_11
       (.A(a[7:0]),
        .D(d[11]),
        .O(ram_reg_256_511_11_11_n_0),
        .WCLK(clk),
        .WE(ram_reg_256_511_0_0_i_1_n_0));
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-5 {cell *THIS*}}" *) 
  (* RTL_RAM_BITS = "32768" *) 
  (* RTL_RAM_NAME = "synth_options.dist_mem_inst/gen_sp_ram.spram_inst/ram" *) 
  (* ram_addr_begin = "256" *) 
  (* ram_addr_end = "511" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "12" *) 
  (* ram_slice_end = "12" *) 
  RAM256X1S #(
    .INIT(256'h0000000000000000000000000000000000000000000000000000000000000000)) 
    ram_reg_256_511_12_12
       (.A(a[7:0]),
        .D(d[12]),
        .O(ram_reg_256_511_12_12_n_0),
        .WCLK(clk),
        .WE(ram_reg_256_511_0_0_i_1_n_0));
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-5 {cell *THIS*}}" *) 
  (* RTL_RAM_BITS = "32768" *) 
  (* RTL_RAM_NAME = "synth_options.dist_mem_inst/gen_sp_ram.spram_inst/ram" *) 
  (* ram_addr_begin = "256" *) 
  (* ram_addr_end = "511" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "13" *) 
  (* ram_slice_end = "13" *) 
  RAM256X1S #(
    .INIT(256'h0000000000000000000000000000000000000000000000000000000000000000)) 
    ram_reg_256_511_13_13
       (.A(a[7:0]),
        .D(d[13]),
        .O(ram_reg_256_511_13_13_n_0),
        .WCLK(clk),
        .WE(ram_reg_256_511_0_0_i_1_n_0));
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-5 {cell *THIS*}}" *) 
  (* RTL_RAM_BITS = "32768" *) 
  (* RTL_RAM_NAME = "synth_options.dist_mem_inst/gen_sp_ram.spram_inst/ram" *) 
  (* ram_addr_begin = "256" *) 
  (* ram_addr_end = "511" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "14" *) 
  (* ram_slice_end = "14" *) 
  RAM256X1S #(
    .INIT(256'h0000000000000000000000000000000000000000000000000000000000000000)) 
    ram_reg_256_511_14_14
       (.A(a[7:0]),
        .D(d[14]),
        .O(ram_reg_256_511_14_14_n_0),
        .WCLK(clk),
        .WE(ram_reg_256_511_0_0_i_1_n_0));
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-5 {cell *THIS*}}" *) 
  (* RTL_RAM_BITS = "32768" *) 
  (* RTL_RAM_NAME = "synth_options.dist_mem_inst/gen_sp_ram.spram_inst/ram" *) 
  (* ram_addr_begin = "256" *) 
  (* ram_addr_end = "511" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "15" *) 
  (* ram_slice_end = "15" *) 
  RAM256X1S #(
    .INIT(256'h0000000000000000000000000000000000000000000000000000000000000000)) 
    ram_reg_256_511_15_15
       (.A(a[7:0]),
        .D(d[15]),
        .O(ram_reg_256_511_15_15_n_0),
        .WCLK(clk),
        .WE(ram_reg_256_511_0_0_i_1_n_0));
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-5 {cell *THIS*}}" *) 
  (* RTL_RAM_BITS = "32768" *) 
  (* RTL_RAM_NAME = "synth_options.dist_mem_inst/gen_sp_ram.spram_inst/ram" *) 
  (* ram_addr_begin = "256" *) 
  (* ram_addr_end = "511" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "16" *) 
  (* ram_slice_end = "16" *) 
  RAM256X1S #(
    .INIT(256'h0000000000000000000000000000000000000000000000000000000000000000)) 
    ram_reg_256_511_16_16
       (.A(a[7:0]),
        .D(d[16]),
        .O(ram_reg_256_511_16_16_n_0),
        .WCLK(clk),
        .WE(ram_reg_256_511_0_0_i_1_n_0));
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-5 {cell *THIS*}}" *) 
  (* RTL_RAM_BITS = "32768" *) 
  (* RTL_RAM_NAME = "synth_options.dist_mem_inst/gen_sp_ram.spram_inst/ram" *) 
  (* ram_addr_begin = "256" *) 
  (* ram_addr_end = "511" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "17" *) 
  (* ram_slice_end = "17" *) 
  RAM256X1S #(
    .INIT(256'h0000000000000000000000000000000000000000000000000000000000000000)) 
    ram_reg_256_511_17_17
       (.A(a[7:0]),
        .D(d[17]),
        .O(ram_reg_256_511_17_17_n_0),
        .WCLK(clk),
        .WE(ram_reg_256_511_0_0_i_1_n_0));
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-5 {cell *THIS*}}" *) 
  (* RTL_RAM_BITS = "32768" *) 
  (* RTL_RAM_NAME = "synth_options.dist_mem_inst/gen_sp_ram.spram_inst/ram" *) 
  (* ram_addr_begin = "256" *) 
  (* ram_addr_end = "511" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "18" *) 
  (* ram_slice_end = "18" *) 
  RAM256X1S #(
    .INIT(256'h0000000000000000000000000000000000000000000000000000000000000000)) 
    ram_reg_256_511_18_18
       (.A(a[7:0]),
        .D(d[18]),
        .O(ram_reg_256_511_18_18_n_0),
        .WCLK(clk),
        .WE(ram_reg_256_511_0_0_i_1_n_0));
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-5 {cell *THIS*}}" *) 
  (* RTL_RAM_BITS = "32768" *) 
  (* RTL_RAM_NAME = "synth_options.dist_mem_inst/gen_sp_ram.spram_inst/ram" *) 
  (* ram_addr_begin = "256" *) 
  (* ram_addr_end = "511" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "19" *) 
  (* ram_slice_end = "19" *) 
  RAM256X1S #(
    .INIT(256'h0000000000000000000000000000000000000000000000000000000000000000)) 
    ram_reg_256_511_19_19
       (.A(a[7:0]),
        .D(d[19]),
        .O(ram_reg_256_511_19_19_n_0),
        .WCLK(clk),
        .WE(ram_reg_256_511_0_0_i_1_n_0));
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-5 {cell *THIS*}}" *) 
  (* RTL_RAM_BITS = "32768" *) 
  (* RTL_RAM_NAME = "synth_options.dist_mem_inst/gen_sp_ram.spram_inst/ram" *) 
  (* ram_addr_begin = "256" *) 
  (* ram_addr_end = "511" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "1" *) 
  (* ram_slice_end = "1" *) 
  RAM256X1S #(
    .INIT(256'h0000000000000000000000000000000000000000000000000000000000000000)) 
    ram_reg_256_511_1_1
       (.A(a[7:0]),
        .D(d[1]),
        .O(ram_reg_256_511_1_1_n_0),
        .WCLK(clk),
        .WE(ram_reg_256_511_0_0_i_1_n_0));
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-5 {cell *THIS*}}" *) 
  (* RTL_RAM_BITS = "32768" *) 
  (* RTL_RAM_NAME = "synth_options.dist_mem_inst/gen_sp_ram.spram_inst/ram" *) 
  (* ram_addr_begin = "256" *) 
  (* ram_addr_end = "511" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "20" *) 
  (* ram_slice_end = "20" *) 
  RAM256X1S #(
    .INIT(256'h0000000000000000000000000000000000000000000000000000000000000000)) 
    ram_reg_256_511_20_20
       (.A(a[7:0]),
        .D(d[20]),
        .O(ram_reg_256_511_20_20_n_0),
        .WCLK(clk),
        .WE(ram_reg_256_511_0_0_i_1_n_0));
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-5 {cell *THIS*}}" *) 
  (* RTL_RAM_BITS = "32768" *) 
  (* RTL_RAM_NAME = "synth_options.dist_mem_inst/gen_sp_ram.spram_inst/ram" *) 
  (* ram_addr_begin = "256" *) 
  (* ram_addr_end = "511" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "21" *) 
  (* ram_slice_end = "21" *) 
  RAM256X1S #(
    .INIT(256'h0000000000000000000000000000000000000000000000000000000000000000)) 
    ram_reg_256_511_21_21
       (.A(a[7:0]),
        .D(d[21]),
        .O(ram_reg_256_511_21_21_n_0),
        .WCLK(clk),
        .WE(ram_reg_256_511_0_0_i_1_n_0));
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-5 {cell *THIS*}}" *) 
  (* RTL_RAM_BITS = "32768" *) 
  (* RTL_RAM_NAME = "synth_options.dist_mem_inst/gen_sp_ram.spram_inst/ram" *) 
  (* ram_addr_begin = "256" *) 
  (* ram_addr_end = "511" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "22" *) 
  (* ram_slice_end = "22" *) 
  RAM256X1S #(
    .INIT(256'h0000000000000000000000000000000000000000000000000000000000000000)) 
    ram_reg_256_511_22_22
       (.A(a[7:0]),
        .D(d[22]),
        .O(ram_reg_256_511_22_22_n_0),
        .WCLK(clk),
        .WE(ram_reg_256_511_0_0_i_1_n_0));
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-5 {cell *THIS*}}" *) 
  (* RTL_RAM_BITS = "32768" *) 
  (* RTL_RAM_NAME = "synth_options.dist_mem_inst/gen_sp_ram.spram_inst/ram" *) 
  (* ram_addr_begin = "256" *) 
  (* ram_addr_end = "511" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "23" *) 
  (* ram_slice_end = "23" *) 
  RAM256X1S #(
    .INIT(256'h0000000000000000000000000000000000000000000000000000000000000000)) 
    ram_reg_256_511_23_23
       (.A(a[7:0]),
        .D(d[23]),
        .O(ram_reg_256_511_23_23_n_0),
        .WCLK(clk),
        .WE(ram_reg_256_511_0_0_i_1_n_0));
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-5 {cell *THIS*}}" *) 
  (* RTL_RAM_BITS = "32768" *) 
  (* RTL_RAM_NAME = "synth_options.dist_mem_inst/gen_sp_ram.spram_inst/ram" *) 
  (* ram_addr_begin = "256" *) 
  (* ram_addr_end = "511" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "24" *) 
  (* ram_slice_end = "24" *) 
  RAM256X1S #(
    .INIT(256'h0000000000000000000000000000000000000000000000000000000000000000)) 
    ram_reg_256_511_24_24
       (.A(a[7:0]),
        .D(d[24]),
        .O(ram_reg_256_511_24_24_n_0),
        .WCLK(clk),
        .WE(ram_reg_256_511_0_0_i_1_n_0));
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-5 {cell *THIS*}}" *) 
  (* RTL_RAM_BITS = "32768" *) 
  (* RTL_RAM_NAME = "synth_options.dist_mem_inst/gen_sp_ram.spram_inst/ram" *) 
  (* ram_addr_begin = "256" *) 
  (* ram_addr_end = "511" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "25" *) 
  (* ram_slice_end = "25" *) 
  RAM256X1S #(
    .INIT(256'h0000000000000000000000000000000000000000000000000000000000000000)) 
    ram_reg_256_511_25_25
       (.A(a[7:0]),
        .D(d[25]),
        .O(ram_reg_256_511_25_25_n_0),
        .WCLK(clk),
        .WE(ram_reg_256_511_0_0_i_1_n_0));
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-5 {cell *THIS*}}" *) 
  (* RTL_RAM_BITS = "32768" *) 
  (* RTL_RAM_NAME = "synth_options.dist_mem_inst/gen_sp_ram.spram_inst/ram" *) 
  (* ram_addr_begin = "256" *) 
  (* ram_addr_end = "511" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "26" *) 
  (* ram_slice_end = "26" *) 
  RAM256X1S #(
    .INIT(256'h0000000000000000000000000000000000000000000000000000000000000000)) 
    ram_reg_256_511_26_26
       (.A(a[7:0]),
        .D(d[26]),
        .O(ram_reg_256_511_26_26_n_0),
        .WCLK(clk),
        .WE(ram_reg_256_511_0_0_i_1_n_0));
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-5 {cell *THIS*}}" *) 
  (* RTL_RAM_BITS = "32768" *) 
  (* RTL_RAM_NAME = "synth_options.dist_mem_inst/gen_sp_ram.spram_inst/ram" *) 
  (* ram_addr_begin = "256" *) 
  (* ram_addr_end = "511" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "27" *) 
  (* ram_slice_end = "27" *) 
  RAM256X1S #(
    .INIT(256'h0000000000000000000000000000000000000000000000000000000000000000)) 
    ram_reg_256_511_27_27
       (.A(a[7:0]),
        .D(d[27]),
        .O(ram_reg_256_511_27_27_n_0),
        .WCLK(clk),
        .WE(ram_reg_256_511_0_0_i_1_n_0));
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-5 {cell *THIS*}}" *) 
  (* RTL_RAM_BITS = "32768" *) 
  (* RTL_RAM_NAME = "synth_options.dist_mem_inst/gen_sp_ram.spram_inst/ram" *) 
  (* ram_addr_begin = "256" *) 
  (* ram_addr_end = "511" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "28" *) 
  (* ram_slice_end = "28" *) 
  RAM256X1S #(
    .INIT(256'h0000000000000000000000000000000000000000000000000000000000000000)) 
    ram_reg_256_511_28_28
       (.A(a[7:0]),
        .D(d[28]),
        .O(ram_reg_256_511_28_28_n_0),
        .WCLK(clk),
        .WE(ram_reg_256_511_0_0_i_1_n_0));
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-5 {cell *THIS*}}" *) 
  (* RTL_RAM_BITS = "32768" *) 
  (* RTL_RAM_NAME = "synth_options.dist_mem_inst/gen_sp_ram.spram_inst/ram" *) 
  (* ram_addr_begin = "256" *) 
  (* ram_addr_end = "511" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "29" *) 
  (* ram_slice_end = "29" *) 
  RAM256X1S #(
    .INIT(256'h0000000000000000000000000000000000000000000000000000000000000000)) 
    ram_reg_256_511_29_29
       (.A(a[7:0]),
        .D(d[29]),
        .O(ram_reg_256_511_29_29_n_0),
        .WCLK(clk),
        .WE(ram_reg_256_511_0_0_i_1_n_0));
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-5 {cell *THIS*}}" *) 
  (* RTL_RAM_BITS = "32768" *) 
  (* RTL_RAM_NAME = "synth_options.dist_mem_inst/gen_sp_ram.spram_inst/ram" *) 
  (* ram_addr_begin = "256" *) 
  (* ram_addr_end = "511" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "2" *) 
  (* ram_slice_end = "2" *) 
  RAM256X1S #(
    .INIT(256'h0000000000000000000000000000000000000000000000000000000000000000)) 
    ram_reg_256_511_2_2
       (.A(a[7:0]),
        .D(d[2]),
        .O(ram_reg_256_511_2_2_n_0),
        .WCLK(clk),
        .WE(ram_reg_256_511_0_0_i_1_n_0));
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-5 {cell *THIS*}}" *) 
  (* RTL_RAM_BITS = "32768" *) 
  (* RTL_RAM_NAME = "synth_options.dist_mem_inst/gen_sp_ram.spram_inst/ram" *) 
  (* ram_addr_begin = "256" *) 
  (* ram_addr_end = "511" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "30" *) 
  (* ram_slice_end = "30" *) 
  RAM256X1S #(
    .INIT(256'h0000000000000000000000000000000000000000000000000000000000000000)) 
    ram_reg_256_511_30_30
       (.A(a[7:0]),
        .D(d[30]),
        .O(ram_reg_256_511_30_30_n_0),
        .WCLK(clk),
        .WE(ram_reg_256_511_0_0_i_1_n_0));
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-5 {cell *THIS*}}" *) 
  (* RTL_RAM_BITS = "32768" *) 
  (* RTL_RAM_NAME = "synth_options.dist_mem_inst/gen_sp_ram.spram_inst/ram" *) 
  (* ram_addr_begin = "256" *) 
  (* ram_addr_end = "511" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "31" *) 
  (* ram_slice_end = "31" *) 
  RAM256X1S #(
    .INIT(256'h0000000000000000000000000000000000000000000000000000000000000000)) 
    ram_reg_256_511_31_31
       (.A(a[7:0]),
        .D(d[31]),
        .O(ram_reg_256_511_31_31_n_0),
        .WCLK(clk),
        .WE(ram_reg_256_511_0_0_i_1_n_0));
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-5 {cell *THIS*}}" *) 
  (* RTL_RAM_BITS = "32768" *) 
  (* RTL_RAM_NAME = "synth_options.dist_mem_inst/gen_sp_ram.spram_inst/ram" *) 
  (* ram_addr_begin = "256" *) 
  (* ram_addr_end = "511" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "3" *) 
  (* ram_slice_end = "3" *) 
  RAM256X1S #(
    .INIT(256'h0000000000000000000000000000000000000000000000000000000000000000)) 
    ram_reg_256_511_3_3
       (.A(a[7:0]),
        .D(d[3]),
        .O(ram_reg_256_511_3_3_n_0),
        .WCLK(clk),
        .WE(ram_reg_256_511_0_0_i_1_n_0));
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-5 {cell *THIS*}}" *) 
  (* RTL_RAM_BITS = "32768" *) 
  (* RTL_RAM_NAME = "synth_options.dist_mem_inst/gen_sp_ram.spram_inst/ram" *) 
  (* ram_addr_begin = "256" *) 
  (* ram_addr_end = "511" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "4" *) 
  (* ram_slice_end = "4" *) 
  RAM256X1S #(
    .INIT(256'h0000000000000000000000000000000000000000000000000000000000000000)) 
    ram_reg_256_511_4_4
       (.A(a[7:0]),
        .D(d[4]),
        .O(ram_reg_256_511_4_4_n_0),
        .WCLK(clk),
        .WE(ram_reg_256_511_0_0_i_1_n_0));
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-5 {cell *THIS*}}" *) 
  (* RTL_RAM_BITS = "32768" *) 
  (* RTL_RAM_NAME = "synth_options.dist_mem_inst/gen_sp_ram.spram_inst/ram" *) 
  (* ram_addr_begin = "256" *) 
  (* ram_addr_end = "511" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "5" *) 
  (* ram_slice_end = "5" *) 
  RAM256X1S #(
    .INIT(256'h0000000000000000000000000000000000000000000000000000000000000000)) 
    ram_reg_256_511_5_5
       (.A(a[7:0]),
        .D(d[5]),
        .O(ram_reg_256_511_5_5_n_0),
        .WCLK(clk),
        .WE(ram_reg_256_511_0_0_i_1_n_0));
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-5 {cell *THIS*}}" *) 
  (* RTL_RAM_BITS = "32768" *) 
  (* RTL_RAM_NAME = "synth_options.dist_mem_inst/gen_sp_ram.spram_inst/ram" *) 
  (* ram_addr_begin = "256" *) 
  (* ram_addr_end = "511" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "6" *) 
  (* ram_slice_end = "6" *) 
  RAM256X1S #(
    .INIT(256'h0000000000000000000000000000000000000000000000000000000000000000)) 
    ram_reg_256_511_6_6
       (.A(a[7:0]),
        .D(d[6]),
        .O(ram_reg_256_511_6_6_n_0),
        .WCLK(clk),
        .WE(ram_reg_256_511_0_0_i_1_n_0));
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-5 {cell *THIS*}}" *) 
  (* RTL_RAM_BITS = "32768" *) 
  (* RTL_RAM_NAME = "synth_options.dist_mem_inst/gen_sp_ram.spram_inst/ram" *) 
  (* ram_addr_begin = "256" *) 
  (* ram_addr_end = "511" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "7" *) 
  (* ram_slice_end = "7" *) 
  RAM256X1S #(
    .INIT(256'h0000000000000000000000000000000000000000000000000000000000000000)) 
    ram_reg_256_511_7_7
       (.A(a[7:0]),
        .D(d[7]),
        .O(ram_reg_256_511_7_7_n_0),
        .WCLK(clk),
        .WE(ram_reg_256_511_0_0_i_1_n_0));
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-5 {cell *THIS*}}" *) 
  (* RTL_RAM_BITS = "32768" *) 
  (* RTL_RAM_NAME = "synth_options.dist_mem_inst/gen_sp_ram.spram_inst/ram" *) 
  (* ram_addr_begin = "256" *) 
  (* ram_addr_end = "511" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "8" *) 
  (* ram_slice_end = "8" *) 
  RAM256X1S #(
    .INIT(256'h0000000000000000000000000000000000000000000000000000000000000000)) 
    ram_reg_256_511_8_8
       (.A(a[7:0]),
        .D(d[8]),
        .O(ram_reg_256_511_8_8_n_0),
        .WCLK(clk),
        .WE(ram_reg_256_511_0_0_i_1_n_0));
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-5 {cell *THIS*}}" *) 
  (* RTL_RAM_BITS = "32768" *) 
  (* RTL_RAM_NAME = "synth_options.dist_mem_inst/gen_sp_ram.spram_inst/ram" *) 
  (* ram_addr_begin = "256" *) 
  (* ram_addr_end = "511" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "9" *) 
  (* ram_slice_end = "9" *) 
  RAM256X1S #(
    .INIT(256'h0000000000000000000000000000000000000000000000000000000000000000)) 
    ram_reg_256_511_9_9
       (.A(a[7:0]),
        .D(d[9]),
        .O(ram_reg_256_511_9_9_n_0),
        .WCLK(clk),
        .WE(ram_reg_256_511_0_0_i_1_n_0));
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-5 {cell *THIS*}}" *) 
  (* RTL_RAM_BITS = "32768" *) 
  (* RTL_RAM_NAME = "synth_options.dist_mem_inst/gen_sp_ram.spram_inst/ram" *) 
  (* ram_addr_begin = "512" *) 
  (* ram_addr_end = "767" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "0" *) 
  (* ram_slice_end = "0" *) 
  RAM256X1S #(
    .INIT(256'h0000000000000000000000000000000000000000000000000000000000000000)) 
    ram_reg_512_767_0_0
       (.A(a[7:0]),
        .D(d[0]),
        .O(ram_reg_512_767_0_0_n_0),
        .WCLK(clk),
        .WE(ram_reg_512_767_0_0_i_1_n_0));
  LUT3 #(
    .INIT(8'h40)) 
    ram_reg_512_767_0_0_i_1
       (.I0(a[8]),
        .I1(a[9]),
        .I2(we),
        .O(ram_reg_512_767_0_0_i_1_n_0));
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-5 {cell *THIS*}}" *) 
  (* RTL_RAM_BITS = "32768" *) 
  (* RTL_RAM_NAME = "synth_options.dist_mem_inst/gen_sp_ram.spram_inst/ram" *) 
  (* ram_addr_begin = "512" *) 
  (* ram_addr_end = "767" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "10" *) 
  (* ram_slice_end = "10" *) 
  RAM256X1S #(
    .INIT(256'h0000000000000000000000000000000000000000000000000000000000000000)) 
    ram_reg_512_767_10_10
       (.A(a[7:0]),
        .D(d[10]),
        .O(ram_reg_512_767_10_10_n_0),
        .WCLK(clk),
        .WE(ram_reg_512_767_0_0_i_1_n_0));
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-5 {cell *THIS*}}" *) 
  (* RTL_RAM_BITS = "32768" *) 
  (* RTL_RAM_NAME = "synth_options.dist_mem_inst/gen_sp_ram.spram_inst/ram" *) 
  (* ram_addr_begin = "512" *) 
  (* ram_addr_end = "767" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "11" *) 
  (* ram_slice_end = "11" *) 
  RAM256X1S #(
    .INIT(256'h0000000000000000000000000000000000000000000000000000000000000000)) 
    ram_reg_512_767_11_11
       (.A(a[7:0]),
        .D(d[11]),
        .O(ram_reg_512_767_11_11_n_0),
        .WCLK(clk),
        .WE(ram_reg_512_767_0_0_i_1_n_0));
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-5 {cell *THIS*}}" *) 
  (* RTL_RAM_BITS = "32768" *) 
  (* RTL_RAM_NAME = "synth_options.dist_mem_inst/gen_sp_ram.spram_inst/ram" *) 
  (* ram_addr_begin = "512" *) 
  (* ram_addr_end = "767" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "12" *) 
  (* ram_slice_end = "12" *) 
  RAM256X1S #(
    .INIT(256'h0000000000000000000000000000000000000000000000000000000000000000)) 
    ram_reg_512_767_12_12
       (.A(a[7:0]),
        .D(d[12]),
        .O(ram_reg_512_767_12_12_n_0),
        .WCLK(clk),
        .WE(ram_reg_512_767_0_0_i_1_n_0));
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-5 {cell *THIS*}}" *) 
  (* RTL_RAM_BITS = "32768" *) 
  (* RTL_RAM_NAME = "synth_options.dist_mem_inst/gen_sp_ram.spram_inst/ram" *) 
  (* ram_addr_begin = "512" *) 
  (* ram_addr_end = "767" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "13" *) 
  (* ram_slice_end = "13" *) 
  RAM256X1S #(
    .INIT(256'h0000000000000000000000000000000000000000000000000000000000000000)) 
    ram_reg_512_767_13_13
       (.A(a[7:0]),
        .D(d[13]),
        .O(ram_reg_512_767_13_13_n_0),
        .WCLK(clk),
        .WE(ram_reg_512_767_0_0_i_1_n_0));
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-5 {cell *THIS*}}" *) 
  (* RTL_RAM_BITS = "32768" *) 
  (* RTL_RAM_NAME = "synth_options.dist_mem_inst/gen_sp_ram.spram_inst/ram" *) 
  (* ram_addr_begin = "512" *) 
  (* ram_addr_end = "767" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "14" *) 
  (* ram_slice_end = "14" *) 
  RAM256X1S #(
    .INIT(256'h0000000000000000000000000000000000000000000000000000000000000000)) 
    ram_reg_512_767_14_14
       (.A(a[7:0]),
        .D(d[14]),
        .O(ram_reg_512_767_14_14_n_0),
        .WCLK(clk),
        .WE(ram_reg_512_767_0_0_i_1_n_0));
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-5 {cell *THIS*}}" *) 
  (* RTL_RAM_BITS = "32768" *) 
  (* RTL_RAM_NAME = "synth_options.dist_mem_inst/gen_sp_ram.spram_inst/ram" *) 
  (* ram_addr_begin = "512" *) 
  (* ram_addr_end = "767" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "15" *) 
  (* ram_slice_end = "15" *) 
  RAM256X1S #(
    .INIT(256'h0000000000000000000000000000000000000000000000000000000000000000)) 
    ram_reg_512_767_15_15
       (.A(a[7:0]),
        .D(d[15]),
        .O(ram_reg_512_767_15_15_n_0),
        .WCLK(clk),
        .WE(ram_reg_512_767_0_0_i_1_n_0));
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-5 {cell *THIS*}}" *) 
  (* RTL_RAM_BITS = "32768" *) 
  (* RTL_RAM_NAME = "synth_options.dist_mem_inst/gen_sp_ram.spram_inst/ram" *) 
  (* ram_addr_begin = "512" *) 
  (* ram_addr_end = "767" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "16" *) 
  (* ram_slice_end = "16" *) 
  RAM256X1S #(
    .INIT(256'h0000000000000000000000000000000000000000000000000000000000000000)) 
    ram_reg_512_767_16_16
       (.A(a[7:0]),
        .D(d[16]),
        .O(ram_reg_512_767_16_16_n_0),
        .WCLK(clk),
        .WE(ram_reg_512_767_0_0_i_1_n_0));
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-5 {cell *THIS*}}" *) 
  (* RTL_RAM_BITS = "32768" *) 
  (* RTL_RAM_NAME = "synth_options.dist_mem_inst/gen_sp_ram.spram_inst/ram" *) 
  (* ram_addr_begin = "512" *) 
  (* ram_addr_end = "767" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "17" *) 
  (* ram_slice_end = "17" *) 
  RAM256X1S #(
    .INIT(256'h0000000000000000000000000000000000000000000000000000000000000000)) 
    ram_reg_512_767_17_17
       (.A(a[7:0]),
        .D(d[17]),
        .O(ram_reg_512_767_17_17_n_0),
        .WCLK(clk),
        .WE(ram_reg_512_767_0_0_i_1_n_0));
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-5 {cell *THIS*}}" *) 
  (* RTL_RAM_BITS = "32768" *) 
  (* RTL_RAM_NAME = "synth_options.dist_mem_inst/gen_sp_ram.spram_inst/ram" *) 
  (* ram_addr_begin = "512" *) 
  (* ram_addr_end = "767" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "18" *) 
  (* ram_slice_end = "18" *) 
  RAM256X1S #(
    .INIT(256'h0000000000000000000000000000000000000000000000000000000000000000)) 
    ram_reg_512_767_18_18
       (.A(a[7:0]),
        .D(d[18]),
        .O(ram_reg_512_767_18_18_n_0),
        .WCLK(clk),
        .WE(ram_reg_512_767_0_0_i_1_n_0));
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-5 {cell *THIS*}}" *) 
  (* RTL_RAM_BITS = "32768" *) 
  (* RTL_RAM_NAME = "synth_options.dist_mem_inst/gen_sp_ram.spram_inst/ram" *) 
  (* ram_addr_begin = "512" *) 
  (* ram_addr_end = "767" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "19" *) 
  (* ram_slice_end = "19" *) 
  RAM256X1S #(
    .INIT(256'h0000000000000000000000000000000000000000000000000000000000000000)) 
    ram_reg_512_767_19_19
       (.A(a[7:0]),
        .D(d[19]),
        .O(ram_reg_512_767_19_19_n_0),
        .WCLK(clk),
        .WE(ram_reg_512_767_0_0_i_1_n_0));
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-5 {cell *THIS*}}" *) 
  (* RTL_RAM_BITS = "32768" *) 
  (* RTL_RAM_NAME = "synth_options.dist_mem_inst/gen_sp_ram.spram_inst/ram" *) 
  (* ram_addr_begin = "512" *) 
  (* ram_addr_end = "767" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "1" *) 
  (* ram_slice_end = "1" *) 
  RAM256X1S #(
    .INIT(256'h0000000000000000000000000000000000000000000000000000000000000000)) 
    ram_reg_512_767_1_1
       (.A(a[7:0]),
        .D(d[1]),
        .O(ram_reg_512_767_1_1_n_0),
        .WCLK(clk),
        .WE(ram_reg_512_767_0_0_i_1_n_0));
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-5 {cell *THIS*}}" *) 
  (* RTL_RAM_BITS = "32768" *) 
  (* RTL_RAM_NAME = "synth_options.dist_mem_inst/gen_sp_ram.spram_inst/ram" *) 
  (* ram_addr_begin = "512" *) 
  (* ram_addr_end = "767" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "20" *) 
  (* ram_slice_end = "20" *) 
  RAM256X1S #(
    .INIT(256'h0000000000000000000000000000000000000000000000000000000000000000)) 
    ram_reg_512_767_20_20
       (.A(a[7:0]),
        .D(d[20]),
        .O(ram_reg_512_767_20_20_n_0),
        .WCLK(clk),
        .WE(ram_reg_512_767_0_0_i_1_n_0));
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-5 {cell *THIS*}}" *) 
  (* RTL_RAM_BITS = "32768" *) 
  (* RTL_RAM_NAME = "synth_options.dist_mem_inst/gen_sp_ram.spram_inst/ram" *) 
  (* ram_addr_begin = "512" *) 
  (* ram_addr_end = "767" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "21" *) 
  (* ram_slice_end = "21" *) 
  RAM256X1S #(
    .INIT(256'h0000000000000000000000000000000000000000000000000000000000000000)) 
    ram_reg_512_767_21_21
       (.A(a[7:0]),
        .D(d[21]),
        .O(ram_reg_512_767_21_21_n_0),
        .WCLK(clk),
        .WE(ram_reg_512_767_0_0_i_1_n_0));
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-5 {cell *THIS*}}" *) 
  (* RTL_RAM_BITS = "32768" *) 
  (* RTL_RAM_NAME = "synth_options.dist_mem_inst/gen_sp_ram.spram_inst/ram" *) 
  (* ram_addr_begin = "512" *) 
  (* ram_addr_end = "767" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "22" *) 
  (* ram_slice_end = "22" *) 
  RAM256X1S #(
    .INIT(256'h0000000000000000000000000000000000000000000000000000000000000000)) 
    ram_reg_512_767_22_22
       (.A(a[7:0]),
        .D(d[22]),
        .O(ram_reg_512_767_22_22_n_0),
        .WCLK(clk),
        .WE(ram_reg_512_767_0_0_i_1_n_0));
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-5 {cell *THIS*}}" *) 
  (* RTL_RAM_BITS = "32768" *) 
  (* RTL_RAM_NAME = "synth_options.dist_mem_inst/gen_sp_ram.spram_inst/ram" *) 
  (* ram_addr_begin = "512" *) 
  (* ram_addr_end = "767" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "23" *) 
  (* ram_slice_end = "23" *) 
  RAM256X1S #(
    .INIT(256'h0000000000000000000000000000000000000000000000000000000000000000)) 
    ram_reg_512_767_23_23
       (.A(a[7:0]),
        .D(d[23]),
        .O(ram_reg_512_767_23_23_n_0),
        .WCLK(clk),
        .WE(ram_reg_512_767_0_0_i_1_n_0));
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-5 {cell *THIS*}}" *) 
  (* RTL_RAM_BITS = "32768" *) 
  (* RTL_RAM_NAME = "synth_options.dist_mem_inst/gen_sp_ram.spram_inst/ram" *) 
  (* ram_addr_begin = "512" *) 
  (* ram_addr_end = "767" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "24" *) 
  (* ram_slice_end = "24" *) 
  RAM256X1S #(
    .INIT(256'h0000000000000000000000000000000000000000000000000000000000000000)) 
    ram_reg_512_767_24_24
       (.A(a[7:0]),
        .D(d[24]),
        .O(ram_reg_512_767_24_24_n_0),
        .WCLK(clk),
        .WE(ram_reg_512_767_0_0_i_1_n_0));
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-5 {cell *THIS*}}" *) 
  (* RTL_RAM_BITS = "32768" *) 
  (* RTL_RAM_NAME = "synth_options.dist_mem_inst/gen_sp_ram.spram_inst/ram" *) 
  (* ram_addr_begin = "512" *) 
  (* ram_addr_end = "767" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "25" *) 
  (* ram_slice_end = "25" *) 
  RAM256X1S #(
    .INIT(256'h0000000000000000000000000000000000000000000000000000000000000000)) 
    ram_reg_512_767_25_25
       (.A(a[7:0]),
        .D(d[25]),
        .O(ram_reg_512_767_25_25_n_0),
        .WCLK(clk),
        .WE(ram_reg_512_767_0_0_i_1_n_0));
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-5 {cell *THIS*}}" *) 
  (* RTL_RAM_BITS = "32768" *) 
  (* RTL_RAM_NAME = "synth_options.dist_mem_inst/gen_sp_ram.spram_inst/ram" *) 
  (* ram_addr_begin = "512" *) 
  (* ram_addr_end = "767" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "26" *) 
  (* ram_slice_end = "26" *) 
  RAM256X1S #(
    .INIT(256'h0000000000000000000000000000000000000000000000000000000000000000)) 
    ram_reg_512_767_26_26
       (.A(a[7:0]),
        .D(d[26]),
        .O(ram_reg_512_767_26_26_n_0),
        .WCLK(clk),
        .WE(ram_reg_512_767_0_0_i_1_n_0));
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-5 {cell *THIS*}}" *) 
  (* RTL_RAM_BITS = "32768" *) 
  (* RTL_RAM_NAME = "synth_options.dist_mem_inst/gen_sp_ram.spram_inst/ram" *) 
  (* ram_addr_begin = "512" *) 
  (* ram_addr_end = "767" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "27" *) 
  (* ram_slice_end = "27" *) 
  RAM256X1S #(
    .INIT(256'h0000000000000000000000000000000000000000000000000000000000000000)) 
    ram_reg_512_767_27_27
       (.A(a[7:0]),
        .D(d[27]),
        .O(ram_reg_512_767_27_27_n_0),
        .WCLK(clk),
        .WE(ram_reg_512_767_0_0_i_1_n_0));
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-5 {cell *THIS*}}" *) 
  (* RTL_RAM_BITS = "32768" *) 
  (* RTL_RAM_NAME = "synth_options.dist_mem_inst/gen_sp_ram.spram_inst/ram" *) 
  (* ram_addr_begin = "512" *) 
  (* ram_addr_end = "767" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "28" *) 
  (* ram_slice_end = "28" *) 
  RAM256X1S #(
    .INIT(256'h0000000000000000000000000000000000000000000000000000000000000000)) 
    ram_reg_512_767_28_28
       (.A(a[7:0]),
        .D(d[28]),
        .O(ram_reg_512_767_28_28_n_0),
        .WCLK(clk),
        .WE(ram_reg_512_767_0_0_i_1_n_0));
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-5 {cell *THIS*}}" *) 
  (* RTL_RAM_BITS = "32768" *) 
  (* RTL_RAM_NAME = "synth_options.dist_mem_inst/gen_sp_ram.spram_inst/ram" *) 
  (* ram_addr_begin = "512" *) 
  (* ram_addr_end = "767" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "29" *) 
  (* ram_slice_end = "29" *) 
  RAM256X1S #(
    .INIT(256'h0000000000000000000000000000000000000000000000000000000000000000)) 
    ram_reg_512_767_29_29
       (.A(a[7:0]),
        .D(d[29]),
        .O(ram_reg_512_767_29_29_n_0),
        .WCLK(clk),
        .WE(ram_reg_512_767_0_0_i_1_n_0));
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-5 {cell *THIS*}}" *) 
  (* RTL_RAM_BITS = "32768" *) 
  (* RTL_RAM_NAME = "synth_options.dist_mem_inst/gen_sp_ram.spram_inst/ram" *) 
  (* ram_addr_begin = "512" *) 
  (* ram_addr_end = "767" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "2" *) 
  (* ram_slice_end = "2" *) 
  RAM256X1S #(
    .INIT(256'h0000000000000000000000000000000000000000000000000000000000000000)) 
    ram_reg_512_767_2_2
       (.A(a[7:0]),
        .D(d[2]),
        .O(ram_reg_512_767_2_2_n_0),
        .WCLK(clk),
        .WE(ram_reg_512_767_0_0_i_1_n_0));
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-5 {cell *THIS*}}" *) 
  (* RTL_RAM_BITS = "32768" *) 
  (* RTL_RAM_NAME = "synth_options.dist_mem_inst/gen_sp_ram.spram_inst/ram" *) 
  (* ram_addr_begin = "512" *) 
  (* ram_addr_end = "767" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "30" *) 
  (* ram_slice_end = "30" *) 
  RAM256X1S #(
    .INIT(256'h0000000000000000000000000000000000000000000000000000000000000000)) 
    ram_reg_512_767_30_30
       (.A(a[7:0]),
        .D(d[30]),
        .O(ram_reg_512_767_30_30_n_0),
        .WCLK(clk),
        .WE(ram_reg_512_767_0_0_i_1_n_0));
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-5 {cell *THIS*}}" *) 
  (* RTL_RAM_BITS = "32768" *) 
  (* RTL_RAM_NAME = "synth_options.dist_mem_inst/gen_sp_ram.spram_inst/ram" *) 
  (* ram_addr_begin = "512" *) 
  (* ram_addr_end = "767" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "31" *) 
  (* ram_slice_end = "31" *) 
  RAM256X1S #(
    .INIT(256'h0000000000000000000000000000000000000000000000000000000000000000)) 
    ram_reg_512_767_31_31
       (.A(a[7:0]),
        .D(d[31]),
        .O(ram_reg_512_767_31_31_n_0),
        .WCLK(clk),
        .WE(ram_reg_512_767_0_0_i_1_n_0));
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-5 {cell *THIS*}}" *) 
  (* RTL_RAM_BITS = "32768" *) 
  (* RTL_RAM_NAME = "synth_options.dist_mem_inst/gen_sp_ram.spram_inst/ram" *) 
  (* ram_addr_begin = "512" *) 
  (* ram_addr_end = "767" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "3" *) 
  (* ram_slice_end = "3" *) 
  RAM256X1S #(
    .INIT(256'h0000000000000000000000000000000000000000000000000000000000000000)) 
    ram_reg_512_767_3_3
       (.A(a[7:0]),
        .D(d[3]),
        .O(ram_reg_512_767_3_3_n_0),
        .WCLK(clk),
        .WE(ram_reg_512_767_0_0_i_1_n_0));
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-5 {cell *THIS*}}" *) 
  (* RTL_RAM_BITS = "32768" *) 
  (* RTL_RAM_NAME = "synth_options.dist_mem_inst/gen_sp_ram.spram_inst/ram" *) 
  (* ram_addr_begin = "512" *) 
  (* ram_addr_end = "767" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "4" *) 
  (* ram_slice_end = "4" *) 
  RAM256X1S #(
    .INIT(256'h0000000000000000000000000000000000000000000000000000000000000000)) 
    ram_reg_512_767_4_4
       (.A(a[7:0]),
        .D(d[4]),
        .O(ram_reg_512_767_4_4_n_0),
        .WCLK(clk),
        .WE(ram_reg_512_767_0_0_i_1_n_0));
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-5 {cell *THIS*}}" *) 
  (* RTL_RAM_BITS = "32768" *) 
  (* RTL_RAM_NAME = "synth_options.dist_mem_inst/gen_sp_ram.spram_inst/ram" *) 
  (* ram_addr_begin = "512" *) 
  (* ram_addr_end = "767" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "5" *) 
  (* ram_slice_end = "5" *) 
  RAM256X1S #(
    .INIT(256'h0000000000000000000000000000000000000000000000000000000000000000)) 
    ram_reg_512_767_5_5
       (.A(a[7:0]),
        .D(d[5]),
        .O(ram_reg_512_767_5_5_n_0),
        .WCLK(clk),
        .WE(ram_reg_512_767_0_0_i_1_n_0));
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-5 {cell *THIS*}}" *) 
  (* RTL_RAM_BITS = "32768" *) 
  (* RTL_RAM_NAME = "synth_options.dist_mem_inst/gen_sp_ram.spram_inst/ram" *) 
  (* ram_addr_begin = "512" *) 
  (* ram_addr_end = "767" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "6" *) 
  (* ram_slice_end = "6" *) 
  RAM256X1S #(
    .INIT(256'h0000000000000000000000000000000000000000000000000000000000000000)) 
    ram_reg_512_767_6_6
       (.A(a[7:0]),
        .D(d[6]),
        .O(ram_reg_512_767_6_6_n_0),
        .WCLK(clk),
        .WE(ram_reg_512_767_0_0_i_1_n_0));
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-5 {cell *THIS*}}" *) 
  (* RTL_RAM_BITS = "32768" *) 
  (* RTL_RAM_NAME = "synth_options.dist_mem_inst/gen_sp_ram.spram_inst/ram" *) 
  (* ram_addr_begin = "512" *) 
  (* ram_addr_end = "767" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "7" *) 
  (* ram_slice_end = "7" *) 
  RAM256X1S #(
    .INIT(256'h0000000000000000000000000000000000000000000000000000000000000000)) 
    ram_reg_512_767_7_7
       (.A(a[7:0]),
        .D(d[7]),
        .O(ram_reg_512_767_7_7_n_0),
        .WCLK(clk),
        .WE(ram_reg_512_767_0_0_i_1_n_0));
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-5 {cell *THIS*}}" *) 
  (* RTL_RAM_BITS = "32768" *) 
  (* RTL_RAM_NAME = "synth_options.dist_mem_inst/gen_sp_ram.spram_inst/ram" *) 
  (* ram_addr_begin = "512" *) 
  (* ram_addr_end = "767" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "8" *) 
  (* ram_slice_end = "8" *) 
  RAM256X1S #(
    .INIT(256'h0000000000000000000000000000000000000000000000000000000000000000)) 
    ram_reg_512_767_8_8
       (.A(a[7:0]),
        .D(d[8]),
        .O(ram_reg_512_767_8_8_n_0),
        .WCLK(clk),
        .WE(ram_reg_512_767_0_0_i_1_n_0));
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-5 {cell *THIS*}}" *) 
  (* RTL_RAM_BITS = "32768" *) 
  (* RTL_RAM_NAME = "synth_options.dist_mem_inst/gen_sp_ram.spram_inst/ram" *) 
  (* ram_addr_begin = "512" *) 
  (* ram_addr_end = "767" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "9" *) 
  (* ram_slice_end = "9" *) 
  RAM256X1S #(
    .INIT(256'h0000000000000000000000000000000000000000000000000000000000000000)) 
    ram_reg_512_767_9_9
       (.A(a[7:0]),
        .D(d[9]),
        .O(ram_reg_512_767_9_9_n_0),
        .WCLK(clk),
        .WE(ram_reg_512_767_0_0_i_1_n_0));
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-5 {cell *THIS*}}" *) 
  (* RTL_RAM_BITS = "32768" *) 
  (* RTL_RAM_NAME = "synth_options.dist_mem_inst/gen_sp_ram.spram_inst/ram" *) 
  (* ram_addr_begin = "768" *) 
  (* ram_addr_end = "1023" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "0" *) 
  (* ram_slice_end = "0" *) 
  RAM256X1S #(
    .INIT(256'h0000000000000000000000000000000000000000000000000000000000000000)) 
    ram_reg_768_1023_0_0
       (.A(a[7:0]),
        .D(d[0]),
        .O(ram_reg_768_1023_0_0_n_0),
        .WCLK(clk),
        .WE(ram_reg_768_1023_0_0_i_1_n_0));
  LUT3 #(
    .INIT(8'h80)) 
    ram_reg_768_1023_0_0_i_1
       (.I0(we),
        .I1(a[8]),
        .I2(a[9]),
        .O(ram_reg_768_1023_0_0_i_1_n_0));
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-5 {cell *THIS*}}" *) 
  (* RTL_RAM_BITS = "32768" *) 
  (* RTL_RAM_NAME = "synth_options.dist_mem_inst/gen_sp_ram.spram_inst/ram" *) 
  (* ram_addr_begin = "768" *) 
  (* ram_addr_end = "1023" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "10" *) 
  (* ram_slice_end = "10" *) 
  RAM256X1S #(
    .INIT(256'h0000000000000000000000000000000000000000000000000000000000000000)) 
    ram_reg_768_1023_10_10
       (.A(a[7:0]),
        .D(d[10]),
        .O(ram_reg_768_1023_10_10_n_0),
        .WCLK(clk),
        .WE(ram_reg_768_1023_0_0_i_1_n_0));
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-5 {cell *THIS*}}" *) 
  (* RTL_RAM_BITS = "32768" *) 
  (* RTL_RAM_NAME = "synth_options.dist_mem_inst/gen_sp_ram.spram_inst/ram" *) 
  (* ram_addr_begin = "768" *) 
  (* ram_addr_end = "1023" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "11" *) 
  (* ram_slice_end = "11" *) 
  RAM256X1S #(
    .INIT(256'h0000000000000000000000000000000000000000000000000000000000000000)) 
    ram_reg_768_1023_11_11
       (.A(a[7:0]),
        .D(d[11]),
        .O(ram_reg_768_1023_11_11_n_0),
        .WCLK(clk),
        .WE(ram_reg_768_1023_0_0_i_1_n_0));
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-5 {cell *THIS*}}" *) 
  (* RTL_RAM_BITS = "32768" *) 
  (* RTL_RAM_NAME = "synth_options.dist_mem_inst/gen_sp_ram.spram_inst/ram" *) 
  (* ram_addr_begin = "768" *) 
  (* ram_addr_end = "1023" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "12" *) 
  (* ram_slice_end = "12" *) 
  RAM256X1S #(
    .INIT(256'h0000000000000000000000000000000000000000000000000000000000000000)) 
    ram_reg_768_1023_12_12
       (.A(a[7:0]),
        .D(d[12]),
        .O(ram_reg_768_1023_12_12_n_0),
        .WCLK(clk),
        .WE(ram_reg_768_1023_0_0_i_1_n_0));
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-5 {cell *THIS*}}" *) 
  (* RTL_RAM_BITS = "32768" *) 
  (* RTL_RAM_NAME = "synth_options.dist_mem_inst/gen_sp_ram.spram_inst/ram" *) 
  (* ram_addr_begin = "768" *) 
  (* ram_addr_end = "1023" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "13" *) 
  (* ram_slice_end = "13" *) 
  RAM256X1S #(
    .INIT(256'h0000000000000000000000000000000000000000000000000000000000000000)) 
    ram_reg_768_1023_13_13
       (.A(a[7:0]),
        .D(d[13]),
        .O(ram_reg_768_1023_13_13_n_0),
        .WCLK(clk),
        .WE(ram_reg_768_1023_0_0_i_1_n_0));
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-5 {cell *THIS*}}" *) 
  (* RTL_RAM_BITS = "32768" *) 
  (* RTL_RAM_NAME = "synth_options.dist_mem_inst/gen_sp_ram.spram_inst/ram" *) 
  (* ram_addr_begin = "768" *) 
  (* ram_addr_end = "1023" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "14" *) 
  (* ram_slice_end = "14" *) 
  RAM256X1S #(
    .INIT(256'h0000000000000000000000000000000000000000000000000000000000000000)) 
    ram_reg_768_1023_14_14
       (.A(a[7:0]),
        .D(d[14]),
        .O(ram_reg_768_1023_14_14_n_0),
        .WCLK(clk),
        .WE(ram_reg_768_1023_0_0_i_1_n_0));
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-5 {cell *THIS*}}" *) 
  (* RTL_RAM_BITS = "32768" *) 
  (* RTL_RAM_NAME = "synth_options.dist_mem_inst/gen_sp_ram.spram_inst/ram" *) 
  (* ram_addr_begin = "768" *) 
  (* ram_addr_end = "1023" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "15" *) 
  (* ram_slice_end = "15" *) 
  RAM256X1S #(
    .INIT(256'h0000000000000000000000000000000000000000000000000000000000000000)) 
    ram_reg_768_1023_15_15
       (.A(a[7:0]),
        .D(d[15]),
        .O(ram_reg_768_1023_15_15_n_0),
        .WCLK(clk),
        .WE(ram_reg_768_1023_0_0_i_1_n_0));
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-5 {cell *THIS*}}" *) 
  (* RTL_RAM_BITS = "32768" *) 
  (* RTL_RAM_NAME = "synth_options.dist_mem_inst/gen_sp_ram.spram_inst/ram" *) 
  (* ram_addr_begin = "768" *) 
  (* ram_addr_end = "1023" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "16" *) 
  (* ram_slice_end = "16" *) 
  RAM256X1S #(
    .INIT(256'h0000000000000000000000000000000000000000000000000000000000000000)) 
    ram_reg_768_1023_16_16
       (.A(a[7:0]),
        .D(d[16]),
        .O(ram_reg_768_1023_16_16_n_0),
        .WCLK(clk),
        .WE(ram_reg_768_1023_0_0_i_1_n_0));
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-5 {cell *THIS*}}" *) 
  (* RTL_RAM_BITS = "32768" *) 
  (* RTL_RAM_NAME = "synth_options.dist_mem_inst/gen_sp_ram.spram_inst/ram" *) 
  (* ram_addr_begin = "768" *) 
  (* ram_addr_end = "1023" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "17" *) 
  (* ram_slice_end = "17" *) 
  RAM256X1S #(
    .INIT(256'h0000000000000000000000000000000000000000000000000000000000000000)) 
    ram_reg_768_1023_17_17
       (.A(a[7:0]),
        .D(d[17]),
        .O(ram_reg_768_1023_17_17_n_0),
        .WCLK(clk),
        .WE(ram_reg_768_1023_0_0_i_1_n_0));
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-5 {cell *THIS*}}" *) 
  (* RTL_RAM_BITS = "32768" *) 
  (* RTL_RAM_NAME = "synth_options.dist_mem_inst/gen_sp_ram.spram_inst/ram" *) 
  (* ram_addr_begin = "768" *) 
  (* ram_addr_end = "1023" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "18" *) 
  (* ram_slice_end = "18" *) 
  RAM256X1S #(
    .INIT(256'h0000000000000000000000000000000000000000000000000000000000000000)) 
    ram_reg_768_1023_18_18
       (.A(a[7:0]),
        .D(d[18]),
        .O(ram_reg_768_1023_18_18_n_0),
        .WCLK(clk),
        .WE(ram_reg_768_1023_0_0_i_1_n_0));
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-5 {cell *THIS*}}" *) 
  (* RTL_RAM_BITS = "32768" *) 
  (* RTL_RAM_NAME = "synth_options.dist_mem_inst/gen_sp_ram.spram_inst/ram" *) 
  (* ram_addr_begin = "768" *) 
  (* ram_addr_end = "1023" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "19" *) 
  (* ram_slice_end = "19" *) 
  RAM256X1S #(
    .INIT(256'h0000000000000000000000000000000000000000000000000000000000000000)) 
    ram_reg_768_1023_19_19
       (.A(a[7:0]),
        .D(d[19]),
        .O(ram_reg_768_1023_19_19_n_0),
        .WCLK(clk),
        .WE(ram_reg_768_1023_0_0_i_1_n_0));
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-5 {cell *THIS*}}" *) 
  (* RTL_RAM_BITS = "32768" *) 
  (* RTL_RAM_NAME = "synth_options.dist_mem_inst/gen_sp_ram.spram_inst/ram" *) 
  (* ram_addr_begin = "768" *) 
  (* ram_addr_end = "1023" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "1" *) 
  (* ram_slice_end = "1" *) 
  RAM256X1S #(
    .INIT(256'h0000000000000000000000000000000000000000000000000000000000000000)) 
    ram_reg_768_1023_1_1
       (.A(a[7:0]),
        .D(d[1]),
        .O(ram_reg_768_1023_1_1_n_0),
        .WCLK(clk),
        .WE(ram_reg_768_1023_0_0_i_1_n_0));
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-5 {cell *THIS*}}" *) 
  (* RTL_RAM_BITS = "32768" *) 
  (* RTL_RAM_NAME = "synth_options.dist_mem_inst/gen_sp_ram.spram_inst/ram" *) 
  (* ram_addr_begin = "768" *) 
  (* ram_addr_end = "1023" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "20" *) 
  (* ram_slice_end = "20" *) 
  RAM256X1S #(
    .INIT(256'h0000000000000000000000000000000000000000000000000000000000000000)) 
    ram_reg_768_1023_20_20
       (.A(a[7:0]),
        .D(d[20]),
        .O(ram_reg_768_1023_20_20_n_0),
        .WCLK(clk),
        .WE(ram_reg_768_1023_0_0_i_1_n_0));
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-5 {cell *THIS*}}" *) 
  (* RTL_RAM_BITS = "32768" *) 
  (* RTL_RAM_NAME = "synth_options.dist_mem_inst/gen_sp_ram.spram_inst/ram" *) 
  (* ram_addr_begin = "768" *) 
  (* ram_addr_end = "1023" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "21" *) 
  (* ram_slice_end = "21" *) 
  RAM256X1S #(
    .INIT(256'h0000000000000000000000000000000000000000000000000000000000000000)) 
    ram_reg_768_1023_21_21
       (.A(a[7:0]),
        .D(d[21]),
        .O(ram_reg_768_1023_21_21_n_0),
        .WCLK(clk),
        .WE(ram_reg_768_1023_0_0_i_1_n_0));
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-5 {cell *THIS*}}" *) 
  (* RTL_RAM_BITS = "32768" *) 
  (* RTL_RAM_NAME = "synth_options.dist_mem_inst/gen_sp_ram.spram_inst/ram" *) 
  (* ram_addr_begin = "768" *) 
  (* ram_addr_end = "1023" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "22" *) 
  (* ram_slice_end = "22" *) 
  RAM256X1S #(
    .INIT(256'h0000000000000000000000000000000000000000000000000000000000000000)) 
    ram_reg_768_1023_22_22
       (.A(a[7:0]),
        .D(d[22]),
        .O(ram_reg_768_1023_22_22_n_0),
        .WCLK(clk),
        .WE(ram_reg_768_1023_0_0_i_1_n_0));
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-5 {cell *THIS*}}" *) 
  (* RTL_RAM_BITS = "32768" *) 
  (* RTL_RAM_NAME = "synth_options.dist_mem_inst/gen_sp_ram.spram_inst/ram" *) 
  (* ram_addr_begin = "768" *) 
  (* ram_addr_end = "1023" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "23" *) 
  (* ram_slice_end = "23" *) 
  RAM256X1S #(
    .INIT(256'h0000000000000000000000000000000000000000000000000000000000000000)) 
    ram_reg_768_1023_23_23
       (.A(a[7:0]),
        .D(d[23]),
        .O(ram_reg_768_1023_23_23_n_0),
        .WCLK(clk),
        .WE(ram_reg_768_1023_0_0_i_1_n_0));
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-5 {cell *THIS*}}" *) 
  (* RTL_RAM_BITS = "32768" *) 
  (* RTL_RAM_NAME = "synth_options.dist_mem_inst/gen_sp_ram.spram_inst/ram" *) 
  (* ram_addr_begin = "768" *) 
  (* ram_addr_end = "1023" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "24" *) 
  (* ram_slice_end = "24" *) 
  RAM256X1S #(
    .INIT(256'h0000000000000000000000000000000000000000000000000000000000000000)) 
    ram_reg_768_1023_24_24
       (.A(a[7:0]),
        .D(d[24]),
        .O(ram_reg_768_1023_24_24_n_0),
        .WCLK(clk),
        .WE(ram_reg_768_1023_0_0_i_1_n_0));
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-5 {cell *THIS*}}" *) 
  (* RTL_RAM_BITS = "32768" *) 
  (* RTL_RAM_NAME = "synth_options.dist_mem_inst/gen_sp_ram.spram_inst/ram" *) 
  (* ram_addr_begin = "768" *) 
  (* ram_addr_end = "1023" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "25" *) 
  (* ram_slice_end = "25" *) 
  RAM256X1S #(
    .INIT(256'h0000000000000000000000000000000000000000000000000000000000000000)) 
    ram_reg_768_1023_25_25
       (.A(a[7:0]),
        .D(d[25]),
        .O(ram_reg_768_1023_25_25_n_0),
        .WCLK(clk),
        .WE(ram_reg_768_1023_0_0_i_1_n_0));
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-5 {cell *THIS*}}" *) 
  (* RTL_RAM_BITS = "32768" *) 
  (* RTL_RAM_NAME = "synth_options.dist_mem_inst/gen_sp_ram.spram_inst/ram" *) 
  (* ram_addr_begin = "768" *) 
  (* ram_addr_end = "1023" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "26" *) 
  (* ram_slice_end = "26" *) 
  RAM256X1S #(
    .INIT(256'h0000000000000000000000000000000000000000000000000000000000000000)) 
    ram_reg_768_1023_26_26
       (.A(a[7:0]),
        .D(d[26]),
        .O(ram_reg_768_1023_26_26_n_0),
        .WCLK(clk),
        .WE(ram_reg_768_1023_0_0_i_1_n_0));
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-5 {cell *THIS*}}" *) 
  (* RTL_RAM_BITS = "32768" *) 
  (* RTL_RAM_NAME = "synth_options.dist_mem_inst/gen_sp_ram.spram_inst/ram" *) 
  (* ram_addr_begin = "768" *) 
  (* ram_addr_end = "1023" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "27" *) 
  (* ram_slice_end = "27" *) 
  RAM256X1S #(
    .INIT(256'h0000000000000000000000000000000000000000000000000000000000000000)) 
    ram_reg_768_1023_27_27
       (.A(a[7:0]),
        .D(d[27]),
        .O(ram_reg_768_1023_27_27_n_0),
        .WCLK(clk),
        .WE(ram_reg_768_1023_0_0_i_1_n_0));
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-5 {cell *THIS*}}" *) 
  (* RTL_RAM_BITS = "32768" *) 
  (* RTL_RAM_NAME = "synth_options.dist_mem_inst/gen_sp_ram.spram_inst/ram" *) 
  (* ram_addr_begin = "768" *) 
  (* ram_addr_end = "1023" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "28" *) 
  (* ram_slice_end = "28" *) 
  RAM256X1S #(
    .INIT(256'h0000000000000000000000000000000000000000000000000000000000000000)) 
    ram_reg_768_1023_28_28
       (.A(a[7:0]),
        .D(d[28]),
        .O(ram_reg_768_1023_28_28_n_0),
        .WCLK(clk),
        .WE(ram_reg_768_1023_0_0_i_1_n_0));
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-5 {cell *THIS*}}" *) 
  (* RTL_RAM_BITS = "32768" *) 
  (* RTL_RAM_NAME = "synth_options.dist_mem_inst/gen_sp_ram.spram_inst/ram" *) 
  (* ram_addr_begin = "768" *) 
  (* ram_addr_end = "1023" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "29" *) 
  (* ram_slice_end = "29" *) 
  RAM256X1S #(
    .INIT(256'h0000000000000000000000000000000000000000000000000000000000000000)) 
    ram_reg_768_1023_29_29
       (.A(a[7:0]),
        .D(d[29]),
        .O(ram_reg_768_1023_29_29_n_0),
        .WCLK(clk),
        .WE(ram_reg_768_1023_0_0_i_1_n_0));
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-5 {cell *THIS*}}" *) 
  (* RTL_RAM_BITS = "32768" *) 
  (* RTL_RAM_NAME = "synth_options.dist_mem_inst/gen_sp_ram.spram_inst/ram" *) 
  (* ram_addr_begin = "768" *) 
  (* ram_addr_end = "1023" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "2" *) 
  (* ram_slice_end = "2" *) 
  RAM256X1S #(
    .INIT(256'h0000000000000000000000000000000000000000000000000000000000000000)) 
    ram_reg_768_1023_2_2
       (.A(a[7:0]),
        .D(d[2]),
        .O(ram_reg_768_1023_2_2_n_0),
        .WCLK(clk),
        .WE(ram_reg_768_1023_0_0_i_1_n_0));
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-5 {cell *THIS*}}" *) 
  (* RTL_RAM_BITS = "32768" *) 
  (* RTL_RAM_NAME = "synth_options.dist_mem_inst/gen_sp_ram.spram_inst/ram" *) 
  (* ram_addr_begin = "768" *) 
  (* ram_addr_end = "1023" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "30" *) 
  (* ram_slice_end = "30" *) 
  RAM256X1S #(
    .INIT(256'h0000000000000000000000000000000000000000000000000000000000000000)) 
    ram_reg_768_1023_30_30
       (.A(a[7:0]),
        .D(d[30]),
        .O(ram_reg_768_1023_30_30_n_0),
        .WCLK(clk),
        .WE(ram_reg_768_1023_0_0_i_1_n_0));
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-5 {cell *THIS*}}" *) 
  (* RTL_RAM_BITS = "32768" *) 
  (* RTL_RAM_NAME = "synth_options.dist_mem_inst/gen_sp_ram.spram_inst/ram" *) 
  (* ram_addr_begin = "768" *) 
  (* ram_addr_end = "1023" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "31" *) 
  (* ram_slice_end = "31" *) 
  RAM256X1S #(
    .INIT(256'h0000000000000000000000000000000000000000000000000000000000000000)) 
    ram_reg_768_1023_31_31
       (.A(a[7:0]),
        .D(d[31]),
        .O(ram_reg_768_1023_31_31_n_0),
        .WCLK(clk),
        .WE(ram_reg_768_1023_0_0_i_1_n_0));
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-5 {cell *THIS*}}" *) 
  (* RTL_RAM_BITS = "32768" *) 
  (* RTL_RAM_NAME = "synth_options.dist_mem_inst/gen_sp_ram.spram_inst/ram" *) 
  (* ram_addr_begin = "768" *) 
  (* ram_addr_end = "1023" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "3" *) 
  (* ram_slice_end = "3" *) 
  RAM256X1S #(
    .INIT(256'h0000000000000000000000000000000000000000000000000000000000000000)) 
    ram_reg_768_1023_3_3
       (.A(a[7:0]),
        .D(d[3]),
        .O(ram_reg_768_1023_3_3_n_0),
        .WCLK(clk),
        .WE(ram_reg_768_1023_0_0_i_1_n_0));
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-5 {cell *THIS*}}" *) 
  (* RTL_RAM_BITS = "32768" *) 
  (* RTL_RAM_NAME = "synth_options.dist_mem_inst/gen_sp_ram.spram_inst/ram" *) 
  (* ram_addr_begin = "768" *) 
  (* ram_addr_end = "1023" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "4" *) 
  (* ram_slice_end = "4" *) 
  RAM256X1S #(
    .INIT(256'h0000000000000000000000000000000000000000000000000000000000000000)) 
    ram_reg_768_1023_4_4
       (.A(a[7:0]),
        .D(d[4]),
        .O(ram_reg_768_1023_4_4_n_0),
        .WCLK(clk),
        .WE(ram_reg_768_1023_0_0_i_1_n_0));
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-5 {cell *THIS*}}" *) 
  (* RTL_RAM_BITS = "32768" *) 
  (* RTL_RAM_NAME = "synth_options.dist_mem_inst/gen_sp_ram.spram_inst/ram" *) 
  (* ram_addr_begin = "768" *) 
  (* ram_addr_end = "1023" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "5" *) 
  (* ram_slice_end = "5" *) 
  RAM256X1S #(
    .INIT(256'h0000000000000000000000000000000000000000000000000000000000000000)) 
    ram_reg_768_1023_5_5
       (.A(a[7:0]),
        .D(d[5]),
        .O(ram_reg_768_1023_5_5_n_0),
        .WCLK(clk),
        .WE(ram_reg_768_1023_0_0_i_1_n_0));
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-5 {cell *THIS*}}" *) 
  (* RTL_RAM_BITS = "32768" *) 
  (* RTL_RAM_NAME = "synth_options.dist_mem_inst/gen_sp_ram.spram_inst/ram" *) 
  (* ram_addr_begin = "768" *) 
  (* ram_addr_end = "1023" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "6" *) 
  (* ram_slice_end = "6" *) 
  RAM256X1S #(
    .INIT(256'h0000000000000000000000000000000000000000000000000000000000000000)) 
    ram_reg_768_1023_6_6
       (.A(a[7:0]),
        .D(d[6]),
        .O(ram_reg_768_1023_6_6_n_0),
        .WCLK(clk),
        .WE(ram_reg_768_1023_0_0_i_1_n_0));
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-5 {cell *THIS*}}" *) 
  (* RTL_RAM_BITS = "32768" *) 
  (* RTL_RAM_NAME = "synth_options.dist_mem_inst/gen_sp_ram.spram_inst/ram" *) 
  (* ram_addr_begin = "768" *) 
  (* ram_addr_end = "1023" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "7" *) 
  (* ram_slice_end = "7" *) 
  RAM256X1S #(
    .INIT(256'h0000000000000000000000000000000000000000000000000000000000000000)) 
    ram_reg_768_1023_7_7
       (.A(a[7:0]),
        .D(d[7]),
        .O(ram_reg_768_1023_7_7_n_0),
        .WCLK(clk),
        .WE(ram_reg_768_1023_0_0_i_1_n_0));
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-5 {cell *THIS*}}" *) 
  (* RTL_RAM_BITS = "32768" *) 
  (* RTL_RAM_NAME = "synth_options.dist_mem_inst/gen_sp_ram.spram_inst/ram" *) 
  (* ram_addr_begin = "768" *) 
  (* ram_addr_end = "1023" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "8" *) 
  (* ram_slice_end = "8" *) 
  RAM256X1S #(
    .INIT(256'h0000000000000000000000000000000000000000000000000000000000000000)) 
    ram_reg_768_1023_8_8
       (.A(a[7:0]),
        .D(d[8]),
        .O(ram_reg_768_1023_8_8_n_0),
        .WCLK(clk),
        .WE(ram_reg_768_1023_0_0_i_1_n_0));
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-5 {cell *THIS*}}" *) 
  (* RTL_RAM_BITS = "32768" *) 
  (* RTL_RAM_NAME = "synth_options.dist_mem_inst/gen_sp_ram.spram_inst/ram" *) 
  (* ram_addr_begin = "768" *) 
  (* ram_addr_end = "1023" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "9" *) 
  (* ram_slice_end = "9" *) 
  RAM256X1S #(
    .INIT(256'h0000000000000000000000000000000000000000000000000000000000000000)) 
    ram_reg_768_1023_9_9
       (.A(a[7:0]),
        .D(d[9]),
        .O(ram_reg_768_1023_9_9_n_0),
        .WCLK(clk),
        .WE(ram_reg_768_1023_0_0_i_1_n_0));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \spo[0]_INST_0 
       (.I0(ram_reg_768_1023_0_0_n_0),
        .I1(ram_reg_512_767_0_0_n_0),
        .I2(a[9]),
        .I3(ram_reg_256_511_0_0_n_0),
        .I4(a[8]),
        .I5(ram_reg_0_255_0_0_n_0),
        .O(spo[0]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \spo[10]_INST_0 
       (.I0(ram_reg_768_1023_10_10_n_0),
        .I1(ram_reg_512_767_10_10_n_0),
        .I2(a[9]),
        .I3(ram_reg_256_511_10_10_n_0),
        .I4(a[8]),
        .I5(ram_reg_0_255_10_10_n_0),
        .O(spo[10]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \spo[11]_INST_0 
       (.I0(ram_reg_768_1023_11_11_n_0),
        .I1(ram_reg_512_767_11_11_n_0),
        .I2(a[9]),
        .I3(ram_reg_256_511_11_11_n_0),
        .I4(a[8]),
        .I5(ram_reg_0_255_11_11_n_0),
        .O(spo[11]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \spo[12]_INST_0 
       (.I0(ram_reg_768_1023_12_12_n_0),
        .I1(ram_reg_512_767_12_12_n_0),
        .I2(a[9]),
        .I3(ram_reg_256_511_12_12_n_0),
        .I4(a[8]),
        .I5(ram_reg_0_255_12_12_n_0),
        .O(spo[12]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \spo[13]_INST_0 
       (.I0(ram_reg_768_1023_13_13_n_0),
        .I1(ram_reg_512_767_13_13_n_0),
        .I2(a[9]),
        .I3(ram_reg_256_511_13_13_n_0),
        .I4(a[8]),
        .I5(ram_reg_0_255_13_13_n_0),
        .O(spo[13]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \spo[14]_INST_0 
       (.I0(ram_reg_768_1023_14_14_n_0),
        .I1(ram_reg_512_767_14_14_n_0),
        .I2(a[9]),
        .I3(ram_reg_256_511_14_14_n_0),
        .I4(a[8]),
        .I5(ram_reg_0_255_14_14_n_0),
        .O(spo[14]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \spo[15]_INST_0 
       (.I0(ram_reg_768_1023_15_15_n_0),
        .I1(ram_reg_512_767_15_15_n_0),
        .I2(a[9]),
        .I3(ram_reg_256_511_15_15_n_0),
        .I4(a[8]),
        .I5(ram_reg_0_255_15_15_n_0),
        .O(spo[15]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \spo[16]_INST_0 
       (.I0(ram_reg_768_1023_16_16_n_0),
        .I1(ram_reg_512_767_16_16_n_0),
        .I2(a[9]),
        .I3(ram_reg_256_511_16_16_n_0),
        .I4(a[8]),
        .I5(ram_reg_0_255_16_16_n_0),
        .O(spo[16]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \spo[17]_INST_0 
       (.I0(ram_reg_768_1023_17_17_n_0),
        .I1(ram_reg_512_767_17_17_n_0),
        .I2(a[9]),
        .I3(ram_reg_256_511_17_17_n_0),
        .I4(a[8]),
        .I5(ram_reg_0_255_17_17_n_0),
        .O(spo[17]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \spo[18]_INST_0 
       (.I0(ram_reg_768_1023_18_18_n_0),
        .I1(ram_reg_512_767_18_18_n_0),
        .I2(a[9]),
        .I3(ram_reg_256_511_18_18_n_0),
        .I4(a[8]),
        .I5(ram_reg_0_255_18_18_n_0),
        .O(spo[18]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \spo[19]_INST_0 
       (.I0(ram_reg_768_1023_19_19_n_0),
        .I1(ram_reg_512_767_19_19_n_0),
        .I2(a[9]),
        .I3(ram_reg_256_511_19_19_n_0),
        .I4(a[8]),
        .I5(ram_reg_0_255_19_19_n_0),
        .O(spo[19]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \spo[1]_INST_0 
       (.I0(ram_reg_768_1023_1_1_n_0),
        .I1(ram_reg_512_767_1_1_n_0),
        .I2(a[9]),
        .I3(ram_reg_256_511_1_1_n_0),
        .I4(a[8]),
        .I5(ram_reg_0_255_1_1_n_0),
        .O(spo[1]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \spo[20]_INST_0 
       (.I0(ram_reg_768_1023_20_20_n_0),
        .I1(ram_reg_512_767_20_20_n_0),
        .I2(a[9]),
        .I3(ram_reg_256_511_20_20_n_0),
        .I4(a[8]),
        .I5(ram_reg_0_255_20_20_n_0),
        .O(spo[20]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \spo[21]_INST_0 
       (.I0(ram_reg_768_1023_21_21_n_0),
        .I1(ram_reg_512_767_21_21_n_0),
        .I2(a[9]),
        .I3(ram_reg_256_511_21_21_n_0),
        .I4(a[8]),
        .I5(ram_reg_0_255_21_21_n_0),
        .O(spo[21]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \spo[22]_INST_0 
       (.I0(ram_reg_768_1023_22_22_n_0),
        .I1(ram_reg_512_767_22_22_n_0),
        .I2(a[9]),
        .I3(ram_reg_256_511_22_22_n_0),
        .I4(a[8]),
        .I5(ram_reg_0_255_22_22_n_0),
        .O(spo[22]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \spo[23]_INST_0 
       (.I0(ram_reg_768_1023_23_23_n_0),
        .I1(ram_reg_512_767_23_23_n_0),
        .I2(a[9]),
        .I3(ram_reg_256_511_23_23_n_0),
        .I4(a[8]),
        .I5(ram_reg_0_255_23_23_n_0),
        .O(spo[23]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \spo[24]_INST_0 
       (.I0(ram_reg_768_1023_24_24_n_0),
        .I1(ram_reg_512_767_24_24_n_0),
        .I2(a[9]),
        .I3(ram_reg_256_511_24_24_n_0),
        .I4(a[8]),
        .I5(ram_reg_0_255_24_24_n_0),
        .O(spo[24]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \spo[25]_INST_0 
       (.I0(ram_reg_768_1023_25_25_n_0),
        .I1(ram_reg_512_767_25_25_n_0),
        .I2(a[9]),
        .I3(ram_reg_256_511_25_25_n_0),
        .I4(a[8]),
        .I5(ram_reg_0_255_25_25_n_0),
        .O(spo[25]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \spo[26]_INST_0 
       (.I0(ram_reg_768_1023_26_26_n_0),
        .I1(ram_reg_512_767_26_26_n_0),
        .I2(a[9]),
        .I3(ram_reg_256_511_26_26_n_0),
        .I4(a[8]),
        .I5(ram_reg_0_255_26_26_n_0),
        .O(spo[26]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \spo[27]_INST_0 
       (.I0(ram_reg_768_1023_27_27_n_0),
        .I1(ram_reg_512_767_27_27_n_0),
        .I2(a[9]),
        .I3(ram_reg_256_511_27_27_n_0),
        .I4(a[8]),
        .I5(ram_reg_0_255_27_27_n_0),
        .O(spo[27]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \spo[28]_INST_0 
       (.I0(ram_reg_768_1023_28_28_n_0),
        .I1(ram_reg_512_767_28_28_n_0),
        .I2(a[9]),
        .I3(ram_reg_256_511_28_28_n_0),
        .I4(a[8]),
        .I5(ram_reg_0_255_28_28_n_0),
        .O(spo[28]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \spo[29]_INST_0 
       (.I0(ram_reg_768_1023_29_29_n_0),
        .I1(ram_reg_512_767_29_29_n_0),
        .I2(a[9]),
        .I3(ram_reg_256_511_29_29_n_0),
        .I4(a[8]),
        .I5(ram_reg_0_255_29_29_n_0),
        .O(spo[29]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \spo[2]_INST_0 
       (.I0(ram_reg_768_1023_2_2_n_0),
        .I1(ram_reg_512_767_2_2_n_0),
        .I2(a[9]),
        .I3(ram_reg_256_511_2_2_n_0),
        .I4(a[8]),
        .I5(ram_reg_0_255_2_2_n_0),
        .O(spo[2]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \spo[30]_INST_0 
       (.I0(ram_reg_768_1023_30_30_n_0),
        .I1(ram_reg_512_767_30_30_n_0),
        .I2(a[9]),
        .I3(ram_reg_256_511_30_30_n_0),
        .I4(a[8]),
        .I5(ram_reg_0_255_30_30_n_0),
        .O(spo[30]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \spo[31]_INST_0 
       (.I0(ram_reg_768_1023_31_31_n_0),
        .I1(ram_reg_512_767_31_31_n_0),
        .I2(a[9]),
        .I3(ram_reg_256_511_31_31_n_0),
        .I4(a[8]),
        .I5(ram_reg_0_255_31_31_n_0),
        .O(spo[31]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \spo[3]_INST_0 
       (.I0(ram_reg_768_1023_3_3_n_0),
        .I1(ram_reg_512_767_3_3_n_0),
        .I2(a[9]),
        .I3(ram_reg_256_511_3_3_n_0),
        .I4(a[8]),
        .I5(ram_reg_0_255_3_3_n_0),
        .O(spo[3]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \spo[4]_INST_0 
       (.I0(ram_reg_768_1023_4_4_n_0),
        .I1(ram_reg_512_767_4_4_n_0),
        .I2(a[9]),
        .I3(ram_reg_256_511_4_4_n_0),
        .I4(a[8]),
        .I5(ram_reg_0_255_4_4_n_0),
        .O(spo[4]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \spo[5]_INST_0 
       (.I0(ram_reg_768_1023_5_5_n_0),
        .I1(ram_reg_512_767_5_5_n_0),
        .I2(a[9]),
        .I3(ram_reg_256_511_5_5_n_0),
        .I4(a[8]),
        .I5(ram_reg_0_255_5_5_n_0),
        .O(spo[5]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \spo[6]_INST_0 
       (.I0(ram_reg_768_1023_6_6_n_0),
        .I1(ram_reg_512_767_6_6_n_0),
        .I2(a[9]),
        .I3(ram_reg_256_511_6_6_n_0),
        .I4(a[8]),
        .I5(ram_reg_0_255_6_6_n_0),
        .O(spo[6]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \spo[7]_INST_0 
       (.I0(ram_reg_768_1023_7_7_n_0),
        .I1(ram_reg_512_767_7_7_n_0),
        .I2(a[9]),
        .I3(ram_reg_256_511_7_7_n_0),
        .I4(a[8]),
        .I5(ram_reg_0_255_7_7_n_0),
        .O(spo[7]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \spo[8]_INST_0 
       (.I0(ram_reg_768_1023_8_8_n_0),
        .I1(ram_reg_512_767_8_8_n_0),
        .I2(a[9]),
        .I3(ram_reg_256_511_8_8_n_0),
        .I4(a[8]),
        .I5(ram_reg_0_255_8_8_n_0),
        .O(spo[8]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \spo[9]_INST_0 
       (.I0(ram_reg_768_1023_9_9_n_0),
        .I1(ram_reg_512_767_9_9_n_0),
        .I2(a[9]),
        .I3(ram_reg_256_511_9_9_n_0),
        .I4(a[8]),
        .I5(ram_reg_0_255_9_9_n_0),
        .O(spo[9]));
endmodule
`ifndef GLBL
`define GLBL
`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;
    wire FCSBO_GLBL;
    wire [3:0] DO_GLBL;
    wire [3:0] DI_GLBL;
   
    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (strong1, weak0) GSR = GSR_int;
    assign (strong1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

endmodule
`endif
