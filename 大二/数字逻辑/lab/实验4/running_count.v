module running_count(
    input clk,                //时钟
    input rst_n,              //复位
    input start_continue,     //开始或继续输入
    input pause_stop,         //暂停或停止输入
    output reg min,           //记录分钟仅需1位
    output reg [7:0] sec,     //秒钟，BCD码，高4位是十位，低四位是个位
    output reg [7:0] milisec, //毫秒
    output reg timeout        //超时标记 
);


parameter STATE_IDLE     =  "idle" ;
parameter STATE_COUNTING =  "counting" ;
parameter STATE_PAUSE    =  "pause" ;
parameter STATE_TIMEOUT  =  "timeout" ;

reg [100:0] current_state;
reg [100:0] next_state;

always @ (posedge clk or negedge rst_n) begin
    //复位则回到默认态
    if(~rst_n) begin
        current_state<=STATE_IDLE;
        timeout <= 1'b0;
    end
    //没复位则进入下一状态
    else begin
        current_state <= next_state;
    end
end

//状态机描述
always @ (*) begin
    case(current_state)

    STATE_IDLE : begin
        //默认状态转移到计时状态
        if(start_continue == 1'b1) begin
            next_state = STATE_COUNTING;
        end
        //默认状态不变
        else begin
            next_state = STATE_IDLE;
        end
    end

    STATE_COUNTING : begin
        //计时状态转移到暂停状态
        if(pause_stop==1'b1) begin
            next_state = STATE_PAUSE;
        end
        //计时状态转移到超时状态
        else if (min == 1'b1 && sec == 'h59 && milisec == 'h99 && flag ) begin
            next_state = STATE_TIMEOUT;
        end
        //继续计时
        else begin
            next_state = STATE_COUNTING;
        end
    end

    STATE_PAUSE : begin
        //收到暂停信号，保持暂停
        if(pause_stop == 1'b1)
            next_state = STATE_PAUSE;
        //收到继续信号，暂停状态转移到计时状态
        else if(start_continue==1'b1)
            next_state = STATE_COUNTING;
        //保持暂停
        else 
            next_state = STATE_PAUSE;
    end

    STATE_TIMEOUT : begin
        //复位到默认态
        if(rst_n==1'b0) begin
            next_state = STATE_IDLE;
        end
        //保持超时态
        else begin
            next_state = STATE_TIMEOUT;
        end
    end
    //给冗余态用
    default:
        next_state <= STATE_IDLE;
    endcase
end

//10ms，根据时钟频率决定
parameter MILISEC_10 = 4; 
//用于记录是否满足10ms进1
reg [31:0] count;

always @ (posedge clk or negedge rst_n) begin
    if(~rst_n) begin
        count<='b0;
    end
    else if(current_state == STATE_COUNTING) begin
        if(count < MILISEC_10)
            count<=count+1'b1;
        else begin
            count<='b0;
        end
    end
    else if (current_state == STATE_TIMEOUT) begin
        count<='b0;
    end
    else if(current_state==STATE_PAUSE) begin
        count<=count;
    end
end

//flag是判断条件，当flag是true的时候ms位加一
wire flag;
assign flag  =  current_state == STATE_COUNTING && count == MILISEC_10 ;


//毫秒处理
always @ (posedge clk or negedge rst_n) begin
    if(~rst_n) begin
        milisec <= 'b0;
    end
    else if(flag) begin
        if(milisec=='h99) begin
            milisec <= 'b0;
        end
        else if(milisec[3:0]=='h9)begin
            milisec[3:0]<='h0;
            milisec[7:4]<= milisec[7:4] +1'b1;
        end
        else begin
            milisec[3:0] <= milisec[3:0] + 1'b1;
        end
    end
end

//秒数处理
always @ (posedge clk or negedge rst_n) begin
    if(~rst_n) begin
        sec <='b0;
    end
    else if (flag&&milisec=='h99) begin
        if(sec == 'h59)begin
            sec<='b0;
        end
        else if (sec[3:0]=='h9) begin
            sec[3:0] <='b0;
            sec[7:4] <= sec[7:4]+1'b1;
        end
        else begin
            sec[3:0] <= sec[3:0] + 1'b1;
        end
    end
    else begin
        sec <= sec;
    end
end

//分钟处理
always @ (posedge clk or negedge rst_n) begin
    if(~rst_n) begin
        min <= 1'b0;
    end
    else if(flag&&sec == 'h59&&milisec=='h99) begin
        if(min == 1'b0) begin
            min <=1'b1;
        end
        else begin
            min <= min; 
            timeout <= 1'b1;
        end
    end
end



endmodule