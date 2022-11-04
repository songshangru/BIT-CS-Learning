`timescale 1ns / 1ps

module regfile(
    input clk,
    input rst,
    input [4:0] ra1,//read address1
    input [4:0] ra2,//read address2
    input en_write,//enable write
    input [31:0] wd,//write data
    input [4:0] wa,//write address
    
    output [31:0] rd1,//read data1
    output [31:0] rd2//read data2
);

    reg [31:0] reg_data[31:0];
    assign rd1 = reg_data[ra1];
    assign rd2 = reg_data[ra2];
    
    integer i = 0;
    always @(posedge clk or negedge rst) begin
        if (!rst) begin
            for (i = 0; i <= 31; i = i + 1)
                reg_data[i] <= 32'b0;
            end
        else if (en_write) reg_data[wa] <= wd;
    end
    
endmodule