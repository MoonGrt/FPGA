`timescale 1ns / 1ps

module hdmi_loop (
    input        sys_clk,          // 50M系统时钟
    input        rst_n,            // 系统复位，低有效
    // hdmi in
    input        hdmi_ddc_scl_io,  // IIC时钟
    inout        hdmi_ddc_sda_io,  // IIC数据
    output       hdmi_in_hpd,      // 热插拔信号
    output [0:0] hdmi_in_oen,      // 输入输出切换信号
    input        clk_hdmi_in_n,    // 输入差分时钟
    input        clk_hdmi_in_p,    // 输入差分时钟
    input  [2:0] data_hdmi_in_n,   // 输入差分数据
    input  [2:0] data_hdmi_in_p,   // 输入差分数据
    // hdmi out
    output [0:0] hdmi_out_oen,     // 输入输出切换信号
    output       clk_hdmi_out_n,   // 输出差分时钟
    output       clk_hdmi_out_p,   // 输出差分时钟
    output [2:0] data_hdmi_out_n,  // 输出差分数据
    output [2:0] data_hdmi_out_p   // 输出差分数据
);

    // wire define
    wire        clk_10m;  // 10m时钟
    wire        clk_200m;  // 200m时钟
    wire        rx_rst;  // 复位信号，高有效
    wire        pixel_clk;  // 像素时钟
    wire        pixel_clk_5x;  // 5倍像素时钟
    wire        video_hs;  // 行信号
    wire        video_vs;  // 场信号
    wire        video_de;  // 数据有效使能
    wire        hdmi_in_oen;  // 输入输出切换信号
    wire        hdmi_in_hpd;  // 热插拔信号
    wire        hdmi_out_oen;  // 输入输出切换信号
    wire [23:0] video_rgb;  // 像素数据

    // *****************************************************
    // **                    main code
    // *****************************************************
    // 时钟模块
    mmcm u_mmcm (
        .clk_out1(clk_10m),   //  output clk_out1
        .clk_out2(clk_200m),  //  output clk_out1
        .locked  (),          //  output locked
        .clk_in1 (sys_clk)    //  input clk_in1
    );

    // 读edid模块
    i2c_edid u_i2c_edid (
        .clk(clk_10m),
        .rst(~rst_n),
        .scl(hdmi_ddc_scl_io),
        .sda(hdmi_ddc_sda_io)
    );

    // hdmi解码模块
    hdmi_rx u_hdmi_rx (
        .clk_10m    (clk_10m),
        .clk_200m   (clk_200m),
        // input
        .tmdsclk_p  (clk_hdmi_in_p),
        .tmdsclk_n  (clk_hdmi_in_n),
        .blue_p     (data_hdmi_in_p[0]),
        .green_p    (data_hdmi_in_p[1]),
        .red_p      (data_hdmi_in_p[2]),
        .blue_n     (data_hdmi_in_n[0]),
        .green_n    (data_hdmi_in_n[1]),
        .red_n      (data_hdmi_in_n[2]),
        .rst_n      (rst_n),
        // output
        .reset      (rx_rst),
        .pclk       (pixel_clk),
        .pclkx5     (pixel_clk_5x),
        .hsync      (video_hs),
        .vsync      (video_vs),
        .de         (video_de),
        .rgb_data   (video_rgb),
        .hdmi_in_en (hdmi_in_oen),
        .hdmi_in_hpd(hdmi_in_hpd)
    );

    //  HDMI解码封装层模块
    dvi_transmitter_top u_rgb2dvi_0 (
        .pclk   (pixel_clk),
        .pclk_x5(pixel_clk_5x),
        .reset_n(~rx_rst),

        .video_din  (video_rgb),
        .video_hsync(video_hs),
        .video_vsync(video_vs),
        .video_de   (video_de),

        .tmds_clk_p (clk_hdmi_out_p),
        .tmds_clk_n (clk_hdmi_out_n),
        .tmds_data_p(data_hdmi_out_p),
        .tmds_data_n(data_hdmi_out_n),
        .tmds_oen   (hdmi_out_oen)
    );

endmodule
