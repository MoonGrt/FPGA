module vga_dri (
    input       vga_clk,      // 时钟
    input [2:0] pixel_data,   // 像素数据

    output        Hsync,      // 行同步信号
    output        Vsync,      // 场同步信号
    output [10:0] pixel_xpos, // 当前像素点横坐标
    output [10:0] pixel_ypos, // 当前像素点纵坐标

    // RGB LCD接口
    output        vga_en,     // VGA 数据使能信号
    output [3:0]  vgaRed,     // 红色分量
    output [3:0]  vgaGreen,   // 绿色分量
    output [3:0]  vgaBlue     // 蓝色分量
);

    // 参数定义  800*600 分辨率
    parameter H_SYNC   = 11'd80;   // 行同步
    parameter H_BACK   = 11'd100;  // 行显示后沿
    parameter H_DISP   = 11'd800;  // 行有效数据
    parameter H_FRONT  = 11'd76;   // 行显示前沿
    parameter H_TOTAL  = 11'd1056; // 行扫描周期

    parameter V_SYNC   = 11'd3;    // 场同步
    parameter V_BACK   = 11'd21;   // 场显示后沿
    parameter V_DISP   = 11'd600;  // 场有效数据
    parameter V_FRONT  = 11'd1;    // 场显示前沿
    parameter V_TOTAL  = 11'd625;  // 场扫描周期

    // 寄存器定义
    reg  [10:0] h_cnt = 0; // 行计数器
    reg  [10:0] v_cnt = 0; // 场计数器

    // 网线定义
    wire        data_req; // 数据请求信号
    wire        h_valid;  // 水平有效信号
    wire        v_valid;  // 垂直有效信号

    // 使能数据输出
    assign Hsync = !(h_cnt < H_SYNC);
    assign Vsync = !(v_cnt < V_SYNC);

    assign h_valid = (h_cnt >= H_SYNC) && (h_cnt < H_SYNC + H_BACK + H_DISP);
    assign v_valid = (v_cnt >= V_SYNC) && (v_cnt < V_SYNC + V_BACK + V_DISP);

    assign vga_en = h_valid && (v_cnt >= (V_SYNC + V_BACK)) && (v_cnt < (V_SYNC + V_BACK + V_DISP));

    // 请求像素点颜色数据输入
    assign data_req = (h_cnt >= (H_SYNC - 1)) && (h_cnt < (H_SYNC + H_BACK + H_DISP - 1)) &&
                       (v_cnt >= V_SYNC) && (v_cnt < (V_SYNC + V_BACK + V_DISP));

    // 像素点坐标
    assign pixel_xpos = data_req ? (h_cnt - (H_SYNC + H_BACK - 1)) : 11'd0;
    assign pixel_ypos = data_req ? (v_cnt - (V_SYNC + V_BACK - 1)) : 11'd0;

    // 像素数据输出
    assign vgaRed   = {4{pixel_data[2]}}; // 红色分量
    assign vgaGreen = {4{pixel_data[1]}}; // 绿色分量
    assign vgaBlue  = {4{pixel_data[0]}}; // 蓝色分量

    // 时序控制
    always @(posedge vga_clk) begin
        if (h_cnt == H_TOTAL) begin
            h_cnt <= 11'b0;
            v_cnt <= (v_cnt == V_TOTAL) ? 11'b0 : v_cnt + 1'b1;
        end else begin
            h_cnt <= h_cnt + 1'b1;
        end
    end

endmodule
