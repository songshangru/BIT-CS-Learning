`timescale 1ns / 1ps

`define RST_ENABLE 1'b1

`define DIGITAL_NUM_ADDR    16'h8000 // 0xbfaf_8000
`define SWITCH_ADDR         16'h8004 // 0xbfaf_8004
`define LED_ADDR            16'h8008 // 0xbfaf_8008
`define MID_BTN_KEY_ADDR    16'h800c // 0xbfaf_800c
`define LEFT_BTN_KEY_ADDR   16'h8010 // 0xbfaf_8010
`define RIGHT_BTN_KEY_ADDR  16'h8014 // 0xbfaf_8014
`define UP_BTN_KEY_ADDR     16'h8018 // 0xbfaf_8018
`define DOWN_BTN_KEY_ADDR   16'h801c // 0xbfaf_801c

module confreg(
    input   wire        clk,
    input   wire        rst,

    input   wire        confreg_wen,
    input   wire[31:0]  confreg_write_data,
    input   wire[31:0]  confreg_addr,
    output  wire[31:0]  confreg_read_data,

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

    reg[31:0]   digital_num_v;
    reg[7:0]    led_v;
    wire[31:0]  switch_v;
    wire[31:0]  mid_btn_key_v;
    wire[31:0]  left_btn_key_v;
    wire[31:0]  right_btn_key_v;
    wire[31:0]  up_btn_key_v;
    wire[31:0]  down_btn_key_v;

    // read confreg
    assign confreg_read_data = get_confreg_read_data(confreg_addr);
function [31:0] get_confreg_read_data(input [31:0] confreg_addr);
begin
    case(confreg_addr[15:0])
    `DIGITAL_NUM_ADDR   : get_confreg_read_data = digital_num_v;
    `SWITCH_ADDR        : get_confreg_read_data = switch_v;
    `LED_ADDR           : get_confreg_read_data = {24'b0, led_v};
    `MID_BTN_KEY_ADDR   : get_confreg_read_data = mid_btn_key_v;
    `LEFT_BTN_KEY_ADDR  : get_confreg_read_data = left_btn_key_v;
    `RIGHT_BTN_KEY_ADDR : get_confreg_read_data = right_btn_key_v;
    `UP_BTN_KEY_ADDR    : get_confreg_read_data = up_btn_key_v;
    `DOWN_BTN_KEY_ADDR  : get_confreg_read_data = down_btn_key_v;
    default: get_confreg_read_data = 32'b0;
    endcase
end
endfunction

    /*********** mid_btn_key ***********/
    reg mid_btn_key_r;
    assign mid_btn_key_v = {31'd0, mid_btn_key_r};

    // eliminate jitter
    reg         mid_btn_key_flag;
    reg [19:0]  mid_btn_key_count;
    wire mid_btn_key_start = !mid_btn_key_r && mid_btn_key;
    wire mid_btn_key_end   = mid_btn_key_r && !mid_btn_key;
    wire mid_btn_key_sample= mid_btn_key_count[19];

    always @ (posedge clk) begin
        if (rst == `RST_ENABLE) begin
            mid_btn_key_flag <= 1'b0;
        end else if (mid_btn_key_sample) begin
            mid_btn_key_flag <= 1'b0;
        end else if (mid_btn_key_start || mid_btn_key_end) begin
            mid_btn_key_flag <= 1'b1;
        end

        if (rst == `RST_ENABLE || !mid_btn_key_flag) begin
            mid_btn_key_count <= 20'b0;
        end else begin
            mid_btn_key_count <= mid_btn_key_count + 1'b1;
        end

        if (rst == `RST_ENABLE) begin
            mid_btn_key_r <= 1'b0;
        end else if (mid_btn_key_sample) begin
            mid_btn_key_r <= mid_btn_key;
        end
    end

    /*********** left_btn_key ***********/
    reg left_btn_key_r;
    assign left_btn_key_v = {31'd0, left_btn_key_r};

    // eliminate jitter
    reg         left_btn_key_flag;
    reg [19:0]  left_btn_key_count;
    wire left_btn_key_start = !left_btn_key_r && left_btn_key;
    wire left_btn_key_end   = left_btn_key_r && !left_btn_key;
    wire left_btn_key_sample= left_btn_key_count[19];

    always @ (posedge clk) begin
        if (rst == `RST_ENABLE) begin
            left_btn_key_flag <= 1'b0;
        end else if (left_btn_key_sample) begin
            left_btn_key_flag <= 1'b0;
        end else if (left_btn_key_start || left_btn_key_end) begin
            left_btn_key_flag <= 1'b1;
        end

        if (rst == `RST_ENABLE || !left_btn_key_flag) begin
            left_btn_key_count <= 20'b0;
        end else begin
            left_btn_key_count <= left_btn_key_count + 1'b1;
        end

        if (rst == `RST_ENABLE) begin
            left_btn_key_r <= 1'b0;
        end else if (left_btn_key_sample) begin
            left_btn_key_r <= left_btn_key;
        end
    end

    /*********** right_btn_key ***********/
    reg right_btn_key_r;
    assign right_btn_key_v = {31'd0, right_btn_key_r};

    // eliminate jitter
    reg         right_btn_key_flag;
    reg [19:0]  right_btn_key_count;
    wire right_btn_key_start = !right_btn_key_r && right_btn_key;
    wire right_btn_key_end   = right_btn_key_r && !right_btn_key;
    wire right_btn_key_sample= right_btn_key_count[19];

    always @ (posedge clk) begin
        if (rst == `RST_ENABLE) begin
            right_btn_key_flag <= 1'b0;
        end else if (right_btn_key_sample) begin
            right_btn_key_flag <= 1'b0;
        end else if (right_btn_key_start || right_btn_key_end) begin
            right_btn_key_flag <= 1'b1;
        end

        if (rst == `RST_ENABLE || !right_btn_key_flag) begin
            right_btn_key_count <= 20'b0;
        end else begin
            right_btn_key_count <= right_btn_key_count + 1'b1;
        end

        if (rst == `RST_ENABLE) begin
            right_btn_key_r <= 1'b0;
        end else if (right_btn_key_sample) begin
            right_btn_key_r <= right_btn_key;
        end
    end

    /*********** up_btn_key ***********/
    reg up_btn_key_r;
    assign up_btn_key_v = {31'd0, up_btn_key_r};

    // eliminate jitter
    reg         up_btn_key_flag;
    reg [19:0]  up_btn_key_count;
    wire up_btn_key_start = !up_btn_key_r && up_btn_key;
    wire up_btn_key_end   = up_btn_key_r && !up_btn_key;
    wire up_btn_key_sample= up_btn_key_count[19];

    always @ (posedge clk) begin
        if (rst == `RST_ENABLE) begin
            up_btn_key_flag <= 1'b0;
        end else if (up_btn_key_sample) begin
            up_btn_key_flag <= 1'b0;
        end else if (up_btn_key_start || up_btn_key_end) begin
            up_btn_key_flag <= 1'b1;
        end

        if (rst == `RST_ENABLE || !up_btn_key_flag) begin
            up_btn_key_count <= 20'b0;
        end else begin
            up_btn_key_count <= up_btn_key_count + 1'b1;
        end

        if (rst == `RST_ENABLE) begin
            up_btn_key_r <= 1'b0;
        end else if (up_btn_key_sample) begin
            up_btn_key_r <= up_btn_key;
        end
    end

    /*********** down_btn_key ***********/
    reg down_btn_key_r;
    assign down_btn_key_v = {31'd0, down_btn_key_r};

    // eliminate jitter
    reg         down_btn_key_flag;
    reg [19:0]  down_btn_key_count;
    wire down_btn_key_start = !down_btn_key_r && down_btn_key;
    wire down_btn_key_end   = down_btn_key_r && !down_btn_key;
    wire down_btn_key_sample= down_btn_key_count[19];

    always @ (posedge clk) begin
        if (rst == `RST_ENABLE) begin
            down_btn_key_flag <= 1'b0;
        end else if (down_btn_key_sample) begin
            down_btn_key_flag <= 1'b0;
        end else if (down_btn_key_start || down_btn_key_end) begin
            down_btn_key_flag <= 1'b1;
        end

        if (rst == `RST_ENABLE || !down_btn_key_flag) begin
            down_btn_key_count <= 20'b0;
        end else begin
            down_btn_key_count <= down_btn_key_count + 1'b1;
        end

        if (rst == `RST_ENABLE) begin
            down_btn_key_r <= 1'b0;
        end else if (down_btn_key_sample) begin
            down_btn_key_r <= down_btn_key;
        end
    end

    /***********    switch   ***********/
    assign switch_v = {24'h000000, switch};

    /***********     led     ***********/
    assign led = led_v;
    wire write_led;
    assign write_led = confreg_wen & (confreg_addr[15:0] == `LED_ADDR);

    always @ (posedge clk) begin
        if (rst == `RST_ENABLE) begin
            led_v <= switch;
        end else begin
            if (write_led) begin
                led_v <= confreg_write_data[7:0];
            end
        end
    end

    /*********** digital num ***********/
    reg[19:0] count;
    reg[3:0] scan_data1, scan_data2;
    reg[7:0] scan_enable;
    reg[6:0] num_a_g1, num_a_g2;

    wire write_digital_num;
    assign write_digital_num = confreg_wen & (confreg_addr[15:0] == `DIGITAL_NUM_ADDR);

    always @ (posedge clk) begin
        if(rst == `RST_ENABLE) begin
            digital_num_v <= 32'b0;
        end else begin
            if (write_digital_num) begin
                digital_num_v <= confreg_write_data;
            end
        end
    end

    assign digital_cs = scan_enable;
    assign digital_num0 = num_a_g1;
    assign digital_num1 = num_a_g2;

    always @ (posedge clk) begin
        if (rst == `RST_ENABLE) begin
            count <= 20'b0;
        end else begin
            count <= count + 1;
        end
    end

    always @ (posedge clk) begin
        if (rst == `RST_ENABLE) begin
            scan_data1 <= 4'b0;
            scan_data2 <= 4'b0;
            scan_enable <= 8'b0;
        end else begin
            case(count[19:18])
            2'b00: begin
                scan_data1 <= digital_num_v[3:0];
                scan_data2 <= digital_num_v[19:16];
                scan_enable <= 8'b0001_0001;
            end
            2'b01: begin
                scan_data1 <= digital_num_v[7:4];
                scan_data2 <= digital_num_v[23:20];
                scan_enable <= 8'b0010_0010;
            end
            2'b10: begin
                scan_data1 <= digital_num_v[11:8];
                scan_data2 <= digital_num_v[27:24];
                scan_enable <= 8'b0100_0100;
            end
            2'b11: begin
                scan_data1 <= digital_num_v[15:12];
                scan_data2 <= digital_num_v[31:28];
                scan_enable <= 8'b1000_1000;
            end
            default: ;
            endcase
        end
    end

    always @ (posedge clk) begin
        if (rst == `RST_ENABLE) begin
            num_a_g1 <= 7'b0;
            num_a_g2 <= 7'b0;
        end else begin
            case(scan_data1)
            4'd0: num_a_g1 <= 7'b111_1110; // 0
            4'd1: num_a_g1 <= 7'b011_0000; // 1
            4'd2: num_a_g1 <= 7'b110_1101; // 2
            4'd3: num_a_g1 <= 7'b111_1001; // 3
            4'd4: num_a_g1 <= 7'b011_0011; // 4
            4'd5: num_a_g1 <= 7'b101_1011; // 5
            4'd6: num_a_g1 <= 7'b101_1111; // 6
            4'd7: num_a_g1 <= 7'b111_0000; // 7
            4'd8: num_a_g1 <= 7'b111_1111; // 8
            4'd9: num_a_g1 <= 7'b111_1011; // 9
            4'd10: num_a_g1 <= 7'b111_0111; // 10
            4'd11: num_a_g1 <= 7'b001_1111; // 11
            4'd12: num_a_g1 <= 7'b100_1110; // 12
            4'd13: num_a_g1 <= 7'b011_1101; // 13
            4'd14: num_a_g1 <= 7'b100_1111; // 14
            4'd15: num_a_g1 <= 7'b100_0111; // 15
            default: ;
            endcase

            case(scan_data2)
            4'd0: num_a_g2 <= 7'b111_1110; // 0
            4'd1: num_a_g2 <= 7'b011_0000; // 1
            4'd2: num_a_g2 <= 7'b110_1101; // 2
            4'd3: num_a_g2 <= 7'b111_1001; // 3
            4'd4: num_a_g2 <= 7'b011_0011; // 4
            4'd5: num_a_g2 <= 7'b101_1011; // 5
            4'd6: num_a_g2 <= 7'b101_1111; // 6
            4'd7: num_a_g2 <= 7'b111_0000; // 7
            4'd8: num_a_g2 <= 7'b111_1111; // 8
            4'd9: num_a_g2 <= 7'b111_1011; // 9
            4'd10: num_a_g2 <= 7'b111_0111; // 10
            4'd11: num_a_g2 <= 7'b001_1111; // 11
            4'd12: num_a_g2 <= 7'b100_1110; // 12
            4'd13: num_a_g2 <= 7'b011_1101; // 13
            4'd14: num_a_g2 <= 7'b100_1111; // 14
            4'd15: num_a_g2 <= 7'b100_0111; // 15
            default: ;
            endcase
        end
    end
endmodule
