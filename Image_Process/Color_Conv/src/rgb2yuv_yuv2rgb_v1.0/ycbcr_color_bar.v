//*************************************************************************
//YCbCr颜色空间彩条发生模块 
//==========================================================================

module ycbcr_color_bar (
    input        clk,       // 像素时钟输入，1280x720@60P的像素时钟为74.25
    input        rst,       // 复位,高有效
    output       hs,        // 行同步、高有效
    output       vs,        // 场同步、高有效
    output       de,        // 数据有效
    output [7:0] ycbcr_y,   // 像素数据、亮度分量
    output [7:0] ycbcr_cb,  // 像素数据、蓝色差分量
    output [7:0] ycbcr_cr   // 像素数据、红色差分量
);

    /*********视频时序参数定义******************************************/
    parameter H_ACTIVE = 16'd1920;  // 行有效长度（像素时钟周期个数）
    parameter H_FP = 16'd88;  // 行同步前肩长度
    parameter H_SYNC = 16'd44;  // 行同步长度
    parameter H_BP = 16'd148;  // 行同步后肩长度
    parameter V_ACTIVE = 16'd1080;  // 场有效长度（行的个数）
    parameter V_FP = 16'd5;  // 场同步前肩长度
    parameter V_SYNC = 16'd5;  // 场同步长度
    parameter V_BP = 16'd36;  // 场同步后肩长度
    parameter H_TOTAL = H_ACTIVE + H_FP + H_SYNC + H_BP;  // 行总长度（时钟周期）
    parameter V_TOTAL = V_ACTIVE + V_FP + V_SYNC + V_BP;  // 场总长度（行）

    // color parameter
    parameter WHITE_Y = 8'd180;
    parameter WHITE_CB = 8'd128;
    parameter WHITE_CR = 8'd128;
    parameter YELLOW_Y = 8'd162;
    parameter YELLOW_CB = 8'd44;
    parameter YELLOW_CR = 8'd142;
    parameter CYAN_Y = 8'd131;
    parameter CYAN_CB = 8'd156;
    parameter CYAN_CR = 8'd44;
    parameter GREEN_Y = 8'd112;
    parameter GREEN_CB = 8'd72;
    parameter GREEN_CR = 8'd58;
    parameter MAGENTA_Y = 8'd84;
    parameter MAGENTA_CB = 8'd184;
    parameter MAGENTA_CR = 8'd198;
    parameter RED_Y = 8'd65;
    parameter RED_CB = 8'd100;
    parameter RED_CR = 8'd212;
    parameter BLUE_Y = 8'd35;
    parameter BLUE_CB = 8'd212;
    parameter BLUE_CR = 8'd114;
    parameter BLACK_Y = 8'd16;
    parameter BLACK_CB = 8'd128;
    parameter BLACK_CR = 8'd128;

    reg         hs_reg;  // 定义一个寄存器,用于行同步
    reg         vs_reg;  // 定义一个寄存器,用户场同步
    reg         hs_reg_d0;  // hs_reg一个时钟的延迟
                            // 所有以_d0、d1、d2等为后缀的均为某个寄存器的延迟
    reg         vs_reg_d0;  // vs_reg一个时钟的延迟
    reg  [11:0] h_cnt;  // 用于行的计数器
    reg  [11:0] v_cnt;  // 用于场（帧）的计数器
    reg  [11:0] active_x;  // 有效图像的的坐标x
    reg  [11:0] active_y;  // 有效图像的坐标y
    reg  [ 7:0] ycbcr_y_reg;
    reg  [ 7:0] ycbcr_cb_reg;
    reg  [ 7:0] ycbcr_cr_reg;
    reg         h_active;  // 行图像有效
    reg         v_active;  // 场图像有效
    wire        video_active;  // 一帧内图像的有效区域h_active & v_active
    reg         video_active_d0;
    assign hs = hs_reg_d0;
    assign vs = vs_reg_d0;
    assign video_active = h_active & v_active;
    assign de = video_active_d0;
    assign ycbcr_y = ycbcr_y_reg;
    assign ycbcr_cb = ycbcr_cb_reg;
    assign ycbcr_cr = ycbcr_cr_reg;
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            hs_reg_d0 <= 1'b0;
            vs_reg_d0 <= 1'b0;
            video_active_d0 <= 1'b0;
        end else begin
            hs_reg_d0 <= hs_reg;
            vs_reg_d0 <= vs_reg;
            video_active_d0 <= video_active;
        end
    end

    always @(posedge clk or posedge rst) begin
        if (rst) h_cnt <= 12'd0;
        else if (h_cnt == H_TOTAL - 1)  // 行计数器到最大值清零
            h_cnt <= 12'd0;
        else h_cnt <= h_cnt + 12'd1;
    end

    always @(posedge clk or posedge rst) begin
        if (rst) active_x <= 12'd0;
        else if (h_cnt >= H_FP + H_SYNC + H_BP - 1)  // 计算图像的x坐标
            active_x <= h_cnt - (H_FP[11:0] + H_SYNC[11:0] + H_BP[11:0] - 12'd1);
        else active_x <= active_x;
    end

    always @(posedge clk or posedge rst) begin
        if (rst) v_cnt <= 12'd0;
        else if (h_cnt == H_FP - 1)  // 在行数计算器为H_FP - 1的时候场计数器+1或清零
            if (v_cnt == V_TOTAL - 1)  // 场计数器到最大值了，清零
                v_cnt <= 12'd0;
            else v_cnt <= v_cnt + 12'd1;  // 没到最大值，+1
        else v_cnt <= v_cnt;
    end

    always @(posedge clk or posedge rst) begin
        if (rst) hs_reg <= 1'b0;
        else if (h_cnt == H_FP - 1)  // 行同步开始了...
            hs_reg <= 1'b1;
        else if (h_cnt == H_FP + H_SYNC - 1)  // 行同步这时候要结束了
            hs_reg <= 1'b0;
        else hs_reg <= hs_reg;
    end

    always @(posedge clk or posedge rst) begin
        if (rst) h_active <= 1'b0;
        else if (h_cnt == H_FP + H_SYNC + H_BP - 1) h_active <= 1'b1;
        else if (h_cnt == H_TOTAL - 1) h_active <= 1'b0;
        else h_active <= h_active;
    end

    always @(posedge clk or posedge rst) begin
        if (rst) vs_reg <= 1'd0;
        else if ((v_cnt == V_FP - 1) && (h_cnt == H_FP - 1)) vs_reg <= 1'b1;
        else if ((v_cnt == V_FP + V_SYNC - 1) && (h_cnt == H_FP - 1)) vs_reg <= 1'b0;
        else vs_reg <= vs_reg;
    end

    always @(posedge clk or posedge rst) begin
        if (rst) v_active <= 1'd0;
        else if ((v_cnt == V_FP + V_SYNC + V_BP - 1) && (h_cnt == H_FP - 1)) v_active <= 1'b1;
        else if ((v_cnt == V_TOTAL - 1) && (h_cnt == H_FP - 1)) v_active <= 1'b0;
        else v_active <= v_active;
    end

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            ycbcr_y_reg  <= 8'h00;
            ycbcr_cb_reg <= 8'h00;
            ycbcr_cr_reg <= 8'h00;
        end else if (video_active)
            if (active_x == 12'd0) begin
                ycbcr_y_reg  <= WHITE_Y;
                ycbcr_cb_reg <= WHITE_CB;
                ycbcr_cr_reg <= WHITE_CR;
            end else if (active_x == (H_ACTIVE / 8) * 1) begin
                ycbcr_y_reg  <= YELLOW_Y;
                ycbcr_cb_reg <= YELLOW_CB;
                ycbcr_cr_reg <= YELLOW_CR;
            end else if (active_x == (H_ACTIVE / 8) * 2) begin
                ycbcr_y_reg  <= CYAN_Y;
                ycbcr_cb_reg <= CYAN_CB;
                ycbcr_cr_reg <= CYAN_CR;
            end else if (active_x == (H_ACTIVE / 8) * 3) begin
                ycbcr_y_reg  <= GREEN_Y;
                ycbcr_cb_reg <= GREEN_CB;
                ycbcr_cr_reg <= GREEN_CR;
            end else if (active_x == (H_ACTIVE / 8) * 4) begin
                ycbcr_y_reg  <= MAGENTA_Y;
                ycbcr_cb_reg <= MAGENTA_CB;
                ycbcr_cr_reg <= MAGENTA_CR;
            end else if (active_x == (H_ACTIVE / 8) * 5) begin
                ycbcr_y_reg  <= RED_Y;
                ycbcr_cb_reg <= RED_CB;
                ycbcr_cr_reg <= RED_CR;
            end else if (active_x == (H_ACTIVE / 8) * 6) begin
                ycbcr_y_reg  <= BLUE_Y;
                ycbcr_cb_reg <= BLUE_CB;
                ycbcr_cr_reg <= BLUE_CR;
            end else if (active_x == (H_ACTIVE / 8) * 7) begin
                ycbcr_y_reg  <= BLACK_Y;
                ycbcr_cb_reg <= BLACK_CB;
                ycbcr_cr_reg <= BLACK_CR;
            end else begin
                ycbcr_y_reg  <= ycbcr_y_reg;
                ycbcr_cb_reg <= ycbcr_cb_reg;
                ycbcr_cr_reg <= ycbcr_cr_reg;
            end
        else begin
            ycbcr_y_reg  <= 8'h00;
            ycbcr_cb_reg <= 8'h00;
            ycbcr_cr_reg <= 8'h00;
        end
    end

endmodule
