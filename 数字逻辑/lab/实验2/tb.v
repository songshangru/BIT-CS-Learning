`timescale 1ps/1ps
module tb();
reg [2:0] in;
wire [5:0] out;

square square_test(
    .num(in),
    .square_num(out)
);

initial begin
    $dumpfile("dumpfile.vcd");
    $dumpvars;
    in <= 3'd0;
    #20 in<= 3'd1 ;
    #10 in<= 3'd2 ;
    #10 in<= 3'd3 ;
    #10 in<= 3'd4 ;
    #10 in<= 3'd5 ;
    #10 in<= 3'd6 ;
    #10 in<= 3'd7 ;
    #20
    $finish;
end
endmodule
