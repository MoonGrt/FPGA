`timescale 1ns / 1ps

module clk_div (
    input             clk,      //50Mhz
    input             rst_n,
    input      [15:0] lcd_id,
    output reg        lcd_pclk
);

    reg       clk_50m;
    reg       clk_25m;
    reg       clk_12_5m;
    reg       div_4_cnt;
    reg [1:0] div_8_cnt;

    // ʱ��2��Ƶ ���50MHzʱ�� 
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) clk_50m <= 1'b0;
        else clk_50m <= ~clk_50m;
    end

    // ʱ��4��Ƶ ���25MHzʱ�� 
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            div_4_cnt <= 1'b0;
            clk_25m   <= 1'b0;
        end else begin
            div_4_cnt <= div_4_cnt + 1'b1;
            if (div_4_cnt == 1'b1) clk_25m <= ~clk_25m;
        end
    end

    // ʱ��8��Ƶ ���12.5MHzʱ�� 
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            div_8_cnt <= 2'b0;
            clk_12_5m <= 1'b0;
        end else begin
            div_8_cnt <= div_8_cnt + 2'b01;
            if (div_8_cnt == 2'b11) clk_12_5m <= ~clk_12_5m;
        end
    end

    always @(*) begin
        case (lcd_id)
            16'h4342: lcd_pclk = clk_12_5m;
            16'h7084: lcd_pclk = clk_25m;
            16'h7016: lcd_pclk = clk_50m;
            16'h4384: lcd_pclk = clk_25m;
            16'h1018: lcd_pclk = clk_50m;
            default:  lcd_pclk = 1'b0;
        endcase
    end

endmodule
