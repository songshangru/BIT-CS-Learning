`timescale 1ns / 1ps

module pc(
    input rst,
    input clk,
    input pause,
    input [31:0] pc_in,
    
    output [31:0] pc_out
);
    reg [31:0] pc_val;
    always@(posedge clk or negedge rst) begin
        if(!rst) begin
            pc_val <= 32'hbfc00000;
        end
        else if(!pause) begin
            pc_val <= pc_in;
        end
    end
    assign pc_out = pc_val;
    
endmodule
