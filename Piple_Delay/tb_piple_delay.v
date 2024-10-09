`timescale 1ns / 1ps

module tb_piple_delay;

    // piple_delay Parameters
    parameter T = 20;
    parameter DLY = 3;

    // piple_delay Inputs
    reg  clk = 0;
    reg  siganl_i = 0;

    // piple_delay Outputs
    wire siganl_o;

    initial begin
        forever #(T / 2) clk = ~clk;
    end

    initial begin
        #30 siganl_i = 1;
        #(T * 2) siganl_i = 0;
        #(T * 2) siganl_i = 1;
        #(T * 2) siganl_i = 0;
    end

    piple_delay #(
        .DLY(5)
    ) piple_delay (
        .clk     (clk),
        .siganl_i(siganl_i),
        .siganl_o(siganl_o)
    );

endmodule
