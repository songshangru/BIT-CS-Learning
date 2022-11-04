`timescale 1ps/1ps
module tb();

reg clk;
reg rst_n;
reg in;
wire out;
always #1 clk<=~clk;

seq_check u_seq_check(
    .clk   (clk  ),
    .rst_n (rst_n),
    .in    (in   ),
    .out   (out  )
);

initial begin
    $dumpvars;
    $dumpfile("dumpfile.vcd");
    clk<= 'b0;
    rst_n <='b0;
    in<='b1;
    #10 rst_n <='b1;

    //1个0子序列检测
    #2 in<='b0;
    #2 in<='b1;
    //2个0子序列检测
    #2 in<='b0;
    #2 in<='b0;
    #2 in<='b1;
    //3个0子序列检测
    #2 in<='b0;
    #2 in<='b0;
    #2 in<='b0;
    #2 in<='b1;
    //4个及以上0子序列检测
    #2 in<='b0;
    #2 in<='b0;
    #2 in<='b0;
    #2 in<='b0;
    #2 in<='b0;
    #2 in<='b0;
    #2 in<='b1;
    #10;
    $finish;


end


endmodule