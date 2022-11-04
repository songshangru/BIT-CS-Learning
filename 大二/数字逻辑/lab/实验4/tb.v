`timescale 1ms/1ms
module tb();

reg clk;
reg rst_n;
reg start_continue;
reg pause_stop;
wire[3:0] select_digit;
wire[7:0] show_led;
wire l1;
wire l2;

running_timer running_timer_instance(
    .clk                (clk),
    .rst_n              (rst_n),
    .start_continue     (start_continue),
    .pause_stop         (pause_stop),
    .select_digit       (select_digit),
    .show_led           (show_led),
    .l1                 (l1),
    .l2                 (l2)
);

always #1 clk<=~clk;

initial begin
     $dumpfile("dumpfile.vcd");
     $dumpvars;
     clk<=1'b1;
     start_continue <= 'b1;
     pause_stop <= 'b0;
     rst_n <= 1'b1;
     #10
     rst_n <= 1'b0;
     #1
     rst_n <= 1'b1;
     #40024
     pause_stop <= 'b1;
     #300
     pause_stop <= 'b0;
     #100000;
     rst_n<='b0;
     start_continue <= 'b0;
     #20
     rst_n <='b1;
     #300
     start_continue <= 'b1;
     #300
     start_continue <= 'b0;
     #150000;
     $finish;
 end





// reg clk;
// reg rst_n;
// reg start_continue;
// reg pause_stop;
// wire min;
// wire [7:0] sec;
// wire [7:0] milisec;
// wire timeout;


// running_count u_running_count(
//     .clk            ( clk            ),
//     .rst_n          ( rst_n          ),
//     .start_continue ( start_continue ),
//     .pause_stop     ( pause_stop     ),
//     .min            ( min            ),
//     .sec            ( sec            ),
//     .milisec        ( milisec        ),
//     .timeout        ( timeout        )
// );

// always #1 clk <= ~clk;


// initial begin
//     $dumpfile("dumpfile.vcd");
//     $dumpvars;
//     clk<=1'b1;
//     start_continue <= 'b1;
//     pause_stop <= 'b0;
//     rst_n <= 1'b1;
//     #10
//     rst_n <= 1'b0;
//     #1
//     rst_n <= 1'b1;
//     #40024
//     pause_stop <= 'b1;
//     #300
//     pause_stop <= 'b0;
//     #100000;
//     rst_n<='b0;
//     start_continue <= 'b0;
//     #20
//     rst_n <='b1;
//     #300
//     start_continue <= 'b1;
//     #300
//     start_continue <= 'b0;
//     #150000;
//     $finish;
// end

endmodule