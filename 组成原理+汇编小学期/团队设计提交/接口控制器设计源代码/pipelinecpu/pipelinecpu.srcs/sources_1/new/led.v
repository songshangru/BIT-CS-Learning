`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/09/07 10:57:15
// Design Name: 
// Module Name: led
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


module led(
    input rst,
    input clk,
    input [7:0] num,
    output [7:0] led
    );
    
    reg [7:0] now_num;
    //reg [7:0] last_num;
    
    assign led = now_num;
    
    always @ (posedge clk) begin
        if (!rst) begin
            now_num<=8'b0;
            //last_num<=8'b0;
        end else begin
            if (now_num!=num) begin
                now_num <= num;
            end
        end
    end
endmodule
