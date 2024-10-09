`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/10/13 14:20:04
// Design Name: 
// Module Name: tb_led_twinkle
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module tb_led_twinkle();

//输入
reg           sys_clk_p;
reg           sys_clk_n;
reg           sys_rst_n;

//输出
wire  [1:0]   led;

//信号初始化
initial begin
    sys_clk_p = 1'b0;
    sys_clk_n = 1'b1;
    sys_rst_n = 1'b0;
    #200
    sys_rst_n = 1'b1;
end

//生成时钟
always #5 sys_clk_p = ~sys_clk_p;
always #5 sys_clk_n = ~sys_clk_n;

//例化待测设计
led_twinkle  u_led_twinkle(
    .sys_clk_p   (sys_clk_p),
    .sys_clk_n   (sys_clk_n),
    .sys_rst_n   (sys_rst_n),
    .led         (led)
    );

endmodule

