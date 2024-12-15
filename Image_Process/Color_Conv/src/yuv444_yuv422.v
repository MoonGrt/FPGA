
module yuv444_yuv422 (
    input        sys_clk,
    input        i_hs,
    input        line_end,
    input        i_vs,
    input        i_de,
    input  [7:0] i_y,
    input  [7:0] i_cb,
    input  [7:0] i_cr,
    output       o_hs,
    output       o_vs,
    output       o_de,
    output [7:0] o_y,
    output [7:0] o_c
);
    reg        i_de_d0 = 1'b0;
    reg        i_de_d1 = 1'b0;
    reg        i_hs_d0 = 1'b0;
    reg        i_hs_d1 = 1'b0;
    reg        i_vs_d0 = 1'b0;
    reg        i_vs_d1 = 1'b0;

    reg  [7:0] i_y_d0 = 8'd0;
    reg  [7:0] i_y_d1 = 8'd0;
    reg  [7:0] i_cb_d0 = 8'd0;
    reg  [7:0] i_cr_d0 = 8'd0;
    reg  [7:0] cb = 8'd0;
    reg  [7:0] cr = 8'd0;
    reg  [7:0] cr_d0 = 8'd0;
    reg        line_end_d0;
    reg        line_end_d1;
    wire [8:0] cb_add;
    wire [8:0] cr_add;
    reg        c_flag = 1'b0;
    assign cb_add = {1'b0, i_cb} + {1'b0, i_cb_d0};
    assign cr_add = {1'b0, i_cr} + {1'b0, i_cr_d0};

    always @(posedge sys_clk) begin
        if (i_de) begin
            i_y_d0 <= i_y;
            i_cb_d0 <= i_cb;
            i_cr_d0 <= i_cr;
            line_end_d0 <= line_end;
        end else begin
            i_y_d0 <= i_y_d0;
            i_cb_d0 <= i_cb_d0;
            i_cr_d0 <= i_cr_d0;
            line_end_d0 <= line_end_d0;
        end
        i_de_d0 <= i_de;
        i_vs_d0 <= i_vs;
    end

    always @(posedge sys_clk) begin
        if (i_de_d0) begin
            i_y_d1 <= i_y_d0;
            cb <= cb_add[8:1];
            cr <= cr_add[8:1];
            line_end_d1 <= line_end_d0;
        end else begin
            i_y_d1 <= i_y_d1;
            cb <= cb;
            cr <= cr;
            line_end_d1 <= line_end_d1;
        end
        i_de_d1 <= i_de_d0;
        i_vs_d1 <= i_vs_d0;
    end

    always @(posedge sys_clk) begin
        i_hs_d0 <= i_hs;
        i_hs_d1 <= i_hs_d0;
    end

    always @(posedge sys_clk) begin
        if ((i_hs_d0 & ~i_hs_d1) | line_end_d1) begin
            c_flag <= 1'b0;
        end else if (i_de_d1) begin
            c_flag <= ~c_flag;
        end else begin
            c_flag <= c_flag;
        end
    end
    always @(posedge sys_clk) begin
        if (i_de_d1) cr_d0 <= cr;
        else cr_d0 <= cr_d0;
    end
    assign o_c  = c_flag ? cr_d0 : cb;
    assign o_y  = i_y_d1;
    assign o_de = i_de_d1;
    assign o_hs = i_hs_d1;
    assign o_vs = i_vs_d1;

endmodule
