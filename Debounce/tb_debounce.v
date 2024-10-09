`timescale 1ns / 1ps

module tb_key_debounce;

    // key_debounce Parameters
    parameter T = 20;
    parameter CNT_NMB = 10000;

    // key_debounce Inputs
    reg  clk = 0;
    reg  key_i = 0;

    // key_debounce Outputs
    wire key_o;

    initial begin
        forever #(T / 2) clk = ~clk;
    end

    initial begin
        #(T * 100) key_i = 1;
    end

    key_debounce #(
        .CNT_NMB(CNT_NMB)
    ) key_debounce (
        .clk  (clk),
        .key_i(key_i),
        .key_o(key_o)
    );

endmodule
