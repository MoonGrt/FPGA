`timescale 1ns / 1ps

module lcd_display (
    input             lcd_pclk,    // 时钟
    input             rst_n,       // 复位，低电平有效
    input      [10:0] pixel_xpos,  // 当前像素点横坐标
    input      [10:0] pixel_ypos,  // 当前像素点纵坐标
    input      [10:0] h_disp,      // LCD屏水平分辨率
    input      [10:0] v_disp,      // LCD屏垂直分辨率
    output reg [23:0] pixel_data   // 像素数据
);

    // parameter define
    parameter WHITE = 24'hFFFFFF;  // 白色
    parameter BLACK = 24'h000000;  // 黑色
    parameter RED = 24'hFF0000;  // 红色
    parameter GREEN = 24'h00FF00;  // 绿色
    parameter BLUE = 24'h0000FF;  // 蓝色

    // 根据当前像素点坐标指定当前像素点颜色数据，在屏幕上显示彩条
    always @(posedge lcd_pclk or negedge rst_n) begin
        if (!rst_n) pixel_data <= BLACK;
        else begin
            if ((pixel_xpos >= 11'd0) && (pixel_xpos < h_disp / 5 * 1)) pixel_data <= WHITE;
            else if ((pixel_xpos >= h_disp / 5 * 1) && (pixel_xpos < h_disp / 5 * 2))
                pixel_data <= BLACK;
            else if ((pixel_xpos >= h_disp / 5 * 2) && (pixel_xpos < h_disp / 5 * 3))
                pixel_data <= RED;
            else if ((pixel_xpos >= h_disp / 5 * 3) && (pixel_xpos < h_disp / 5 * 4))
                pixel_data <= GREEN;
            else pixel_data <= BLUE;
        end
    end

endmodule
