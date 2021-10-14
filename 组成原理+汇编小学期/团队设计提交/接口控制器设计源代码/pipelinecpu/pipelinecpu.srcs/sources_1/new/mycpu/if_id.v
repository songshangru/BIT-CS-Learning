`timescale 1ns / 1ps

module if_id(
    input clk,
    input rst,
    input [31:0] _pc,
    input [31:0] _instr,//input instruction
    input pause,
    input drop,
    // pause=0 drop=0  or  pause=1 drop=0  or  pause=0 drop=1
    
    output [31:0] instr_,//output instruction
    output [31:0] pc_
);
    
    reg [31:0] pc;
    reg [31:0] instr;
    always @(posedge clk or negedge rst) begin
        if (!rst) begin
            pc <= 32'hbfc00000;
            instr <= 32'h00000000;
        end
        else if (!pause && !drop) begin
            pc <= _pc;
            instr <= _instr;
        end
        else if (!pause && drop) begin
            pc <= _pc;
            instr <= 32'h00000000;
        end 
        else if (pause && !drop) begin
        end
    end
    
    assign pc_ = pc;
    assign instr_ = instr;
    
endmodule