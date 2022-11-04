module key_rebounce(                //定义输入输出端口
    input       clk,              //系统时钟
    input       rst_n,            //复位信号
    input       key_in,           //按键输入信号
    output reg  key_out           //按键去抖输出信号
    );
    
    reg key_in0;          //记录上个时钟周期的按键输入信号
    reg [19:0] count;     //计数寄存器
    
    wire change;          //按键输入改变信号
    
    parameter   C_COUNTER_NUM = 5;
//    parameter   C_COUNTER_NUM = 180000;
    
    always@(posedge clk or negedge rst_n)
        if(!rst_n)//复位处理
            key_in0 <= 0;
        else        //记录按键输入
            key_in0 <= key_in;
    //如果前后两个时钟按键输入数据不同，将此信号置为1        
    assign change=(key_in & !key_in0)|(!key_in & key_in0);
    
    always@(posedge clk or negedge rst_n)
        if(!rst_n)    //复位处理
            count <= 0;
        else if(change)//按键输入发生改变，重新开始计数   
            count <= 0;
        else 
            count <= count + 1;
    
    always@(posedge clk or negedge rst_n)
        if(!rst_n)    //复位处理
            key_out <= 0;  
        else if(count >= C_COUNTER_NUM - 1)//更改输出信号
            key_out <= key_in;
endmodule