`timescale 1ns / 1ps

module tb_lcd_rgb_colorbar ();

    // reg define
    reg         sys_clk_p;
    reg         sys_clk_n;
    reg         sys_rst_n;

    // wire define
    wire        lcd_de;
    wire        lcd_hs;
    wire        lcd_vs;
    wire        lcd_bl;
    wire        lcd_clk;
    wire [23:0] lcd_rgb;

    always #5 sys_clk_p = ~sys_clk_p;
    always #5 sys_clk_n = ~sys_clk_n;

    assign lcd_rgb = 24'h0;

    initial begin
        sys_clk_p = 1'b0;
        sys_clk_n = 1'b1;
        sys_rst_n = 1'b0;
        #200 sys_rst_n = 1'b1;
    end

    lcd_rgb_colorbar u_lcd_rgb_colorbar (
        .sys_clk_p(sys_clk_p),
        .sys_clk_n(sys_clk_n),
        .sys_rst_n(sys_rst_n),

        .lcd_de (lcd_de),
        .lcd_hs (lcd_hs),
        .lcd_vs (lcd_vs),
        .lcd_bl (lcd_bl),
        .lcd_clk(lcd_clk),
        .lcd_rst(lcd_rst),
        .lcd_rgb(lcd_rgb)
    );

endmodule
