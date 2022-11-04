`timescale 1ns / 1ps

module single_cycle(
    input   wire    rstn,
    input   wire    clk,

    /********* confreg *********/
    output  wire[6:0]   digital_num0,
    output  wire[6:0]   digital_num1,
    output  wire[7:0]   digital_cs,
    output  wire[7:0]   led,
    input   wire[7:0]   switch,
    input   wire        mid_btn_key,
    input   wire        left_btn_key,
    input   wire        right_btn_key,
    input   wire        up_btn_key,
    input   wire        down_btn_key
    );

    wire[31:0]  inst_rom_addr;
    wire[31:0]  inst_rom_rdata;
    wire[31:0]  data_ram_addr;
    wire[31:0]  data_ram_wdata;
    wire        data_ram_wen;
    wire[31:0]  data_ram_rdata;

    cpu cpu0(
        .rstn(rstn),                                  // input
        .clk(clk),                                  // input

        .inst_rom_addr(inst_rom_addr),              // output
        .inst_rom_rdata(inst_rom_rdata),            // input

        .data_ram_addr(data_ram_addr),              // output
        .data_ram_wdata(data_ram_wdata),            // output
        .data_ram_wen(data_ram_wen),                // output
        .data_ram_rdata(data_ram_rdata)             // input
    );

    inst_rom inst_rom_4k(
        .a(inst_rom_addr[11:2]),                    // input wire [9 : 0] a
        .spo(inst_rom_rdata)                        // output wire [31 : 0] spo
    );

    wire ram_wen, confreg_wen;
    wire[31:0] ram_addr, confreg_addr;
    wire[31:0] ram_wdata, confreg_wdata;
    wire[31:0] ram_rdata, confreg_rdata;

    assign ram_addr = data_ram_addr;
    assign confreg_addr = data_ram_addr;

    assign ram_wdata = data_ram_wdata;
    assign confreg_wdata = data_ram_wdata;

    wire is_confreg_addr;
    assign is_confreg_addr = data_ram_addr[31:16] == 16'hbfaf ? 1'b1 : 1'b0;
    assign confreg_wen = data_ram_wen & is_confreg_addr;
    assign ram_wen = data_ram_wen & !is_confreg_addr;

    assign data_ram_rdata = is_confreg_addr == 1'b1 ? confreg_rdata : ram_rdata;

    data_ram data_ram_4k(
        .a(ram_addr[11:2]),                         // input wire [9 : 0] a
        .d(ram_wdata),                              // input wire [31 : 0] d
        .clk(clk),                                  // input wire clk
        .we(ram_wen),                               // input wire we
        .spo(ram_rdata)                             // output wire [31 : 0] spo
    );

    confreg confreg0(
        .clk(clk),
        .rst(~rstn),

        .confreg_wen(confreg_wen),
        .confreg_write_data(confreg_wdata),
        .confreg_addr(confreg_addr),
        .confreg_read_data(confreg_rdata),

        .digital_num0(digital_num0),
        .digital_num1(digital_num1),
        .digital_cs(digital_cs),
        .led(led),
        .switch(switch),
        .mid_btn_key(mid_btn_key),
        .left_btn_key(left_btn_key),
        .right_btn_key(right_btn_key),
        .up_btn_key(up_btn_key),
        .down_btn_key(down_btn_key)
    );
endmodule
