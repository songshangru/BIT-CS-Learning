module running_timer(
    input clk,
    input rst_n, 
    input start_continue,
    input pause_stop,
    output wire[3:0] select_digit,
    output wire[7:0] show_led,
    output wire l1, 
    output wire l2
);

//给start_continue消抖
wire start_continue_out;

key_rebounce s_key_rebounce(
    .clk        (clk),
    .rst_n      (rst_n),
    .key_in     (start_continue),
    .key_out    (start_continue_out)
);

//给pause_stop消抖
wire pause_stop_out;

key_rebounce p_key_rebounce(
    .clk        (clk),
    .rst_n      (rst_n),
    .key_in     (pause_stop),
    .key_out    (pause_stop_out)
);



wire  min;
wire [7:0] sec;
wire [7:0] milisec;
wire timeout;

running_count u_running_count(
    .clk                (clk),
    .rst_n              (rst_n),
    .start_continue     (start_continue_out),
    .pause_stop         (pause_stop_out),
    .min                (min),
    .sec                (sec),
    .milisec            (milisec),
    .timeout            (timeout)
);



//数字显示模块
display u_display(
    .clk                (clk),
    .sec                (sec),
    .milisec            (milisec),
    .select_digit       (select_digit),
    .show_led           (show_led)
);


//LED显示模块
LED u_LED(
    .clk        (clk),
    .rst_n      (rst_n),
    .min        (min),
    .timeout    (timeout),
    .l1         (l1),
    .l2         (l2)
);

endmodule