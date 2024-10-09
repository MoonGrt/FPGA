`timescale 1ns / 1ps

module led_twinkle (
    input sys_clk_p,  // 系统差分输入时钟
    input sys_clk_n,  // 系统差分输入时钟
    input sys_rst_n,  // 系统复位，低电平有效

    output [1:0] led  // LED灯
);

    // reg define
    reg [26:0] cnt;

    //*****************************************************
    //**                    main code
    //*****************************************************

    // 对计数器的值进行判断，以输出LED的状态
    assign led = (cnt < 27'd5000_0000) ? 2'b01 : 2'b10;
    //assign led = (cnt <  27'd5)           ? 2'b01 : 2'b10 ;  // 仅用于仿真

    // 转换差分信号
    IBUFDS diff_clock (
        .I (sys_clk_p),  // 系统差分输入时钟
        .IB(sys_clk_n),  // 系统差分输入时钟
        .O (sys_clk)     // 输出系统时钟
    );

    // 计数器在0~10000_0000之间进行计数
    always @(posedge sys_clk or negedge sys_rst_n) begin
        if (!sys_rst_n) cnt <= 27'd0;
        //else if(cnt <  27'd10)  // 仅用于仿真
        else if (cnt < 27'd10000_0000) cnt <= cnt + 1'b1;
        else cnt <= 27'd0;
    end

endmodule
