module display(
	input clk,  //时钟信号
	input wire[7:0] sec,  //输入秒数
	input wire[7:0] milisec,  //输入毫秒数
	output reg[3:0] select_digit,  //数码管选择信号
	output reg[7:0] show_led  //LED控制信号
);
    reg[3:0] show_num;  //当前数码管显示时间
    reg[1:0] count;  //递增从而切换数码管进行显示
    reg point;  //判断小数点是否亮灯
    parameter  //LED控制信号
		zero = 8'b00111111,  //63
        one = 8'b00000110,  //6
		two = 8'b01011011,  //91
		three = 8'b01001111,  //79
		four = 8'b01100110,  //102
		five = 8'b01101101,  //109
		six = 8'b01111101,  //125
		seven = 8'b00000111,  //7
		eight = 8'b01111111,  //127
		nine = 8'b01101111;  //111
	
	initial show_num=4'b0000;
    initial count=2'b00;
	always @(posedge clk) begin  //切换数码管，并更新显示数字
		case(count)
			2'b00: begin
				select_digit<=4'b0001;
                show_num<=milisec[3:0];
				point=0;
			end
			
			2'b01: begin
				select_digit<=4'b0010;
				show_num<=milisec[7:4];
				point=0;
			end
			
			2'b10: begin  //第3位数码管需要亮小数点
				select_digit<=4'b0100;
				show_num<=sec[3:0];
				point=1;
			end
			
			2'b11: begin
				select_digit<=4'b1000;
				show_num<=sec[7:4];
				point=0;
			end
		endcase
        count <= count+1'b1;  //切换数码管
    end
    
	always @(*) begin  //不断重复，当show_num改变，更新LED控制信号的值
        if(point==0) begin
			case(show_num)
				4'b0000:show_led=zero;
				4'b0001:show_led=one;
				4'b0010:show_led=two;
				4'b0011:show_led=three;
				4'b0100:show_led=four;
				4'b0101:show_led=five;
				4'b0110:show_led=six;
				4'b0111:show_led=seven;
				4'b1000:show_led=eight;
				4'b1001:show_led=nine;
			endcase
        end
        else begin  //需要亮小数点，加上8'b10000000则H为1，小数点亮
			case(show_num)
                4'b0000:show_led=zero+8'b10000000;
                4'b0001:show_led=one+8'b10000000;
                4'b0010:show_led=two+8'b10000000; 
                4'b0011:show_led=three+8'b10000000; 
                4'b0100:show_led=four+8'b10000000; 
                4'b0101:show_led=five+8'b10000000; 
                4'b0110:show_led=six+8'b10000000; 
                4'b0111:show_led=seven+8'b10000000; 
                4'b1000:show_led=eight+8'b10000000; 
                4'b1001:show_led=nine+8'b10000000; 
            endcase
        end
    end
endmodule