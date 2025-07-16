`timescale 1 ns / 1 ns

module tb_CORDIC ();

  integer i;

  reg clk, rst_n;
  reg [15:0] theta, theta_n;
  wire [15:0] sin_theta, cos_theta;

  reg [15:0] cnt, cnt_n;

  CORDIC CORDIC (
      .clk      (clk),
      .rst_n    (rst_n),
      .theta    (theta),
      .sin_theta(sin_theta),
      .cos_theta(cos_theta)
  );

  always #10 clk = ~clk;

  initial begin
    #0 clk = 1'b0;
    #10 rst_n = 1'b0;
    #10 rst_n = 1'b1;
  end

  initial begin
    #0 theta = 16'd20;
    for (i = 0; i < 10000; i = i + 1) begin
      #400;
      theta <= theta + 16'd200;
    end
  end

endmodule
