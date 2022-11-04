`timescale 1ns / 1ps

module top_pipeline(
    input   wire    rstn,
    input   wire    clk
    );
    
    wire[31:0]  inst_rom_addr;
    wire[31:0]  inst_rom_rdata;
    
    wire[31:0]  data_ram_addr;
    wire[31:0]  data_ram_wdata;
    wire        data_ram_wen;
    wire[31:0]  data_ram_rdata;

    cpu mycpu0(
        .rst(rstn),                                  // input
        .clk(clk),                                  // input

        .imem_ra(inst_rom_addr),              // output
        .imem_rd(inst_rom_rdata),            // input

        .dmem_ra(data_ram_addr),              // output
        .dmem_wd(data_ram_wdata),            // output
        .dmem_wen(data_ram_wen),                // output
        .dmem_rd(data_ram_rdata)             // input
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
    
endmodule
