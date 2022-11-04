module LED(
    input wire clk,
    input wire rst_n,
    input wire min,
    input wire timeout,  //超时信号
    output wire l1,  //LED灯，时间>=60s亮起
    output wire l2  //LED灯，超时亮起
);
    reg light1,light2;  //对应于l1,l2
    initial light1=1'b0;
    initial light2=1'b0;
    
    always @(posedge clk or negedge rst_n) begin
        if(~rst_n) begin
            light1=1'b0;
            light2=1'b0;
        end
        else begin
            light1=min;
            if(timeout==1'b1)
                light2=1'b1;
        end
    end
    
    assign l1=light1;
    assign l2=light2;   
endmodule