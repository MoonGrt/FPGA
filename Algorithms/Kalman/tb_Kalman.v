`default_nettype none 
`timescale 1ns / 1ps

module Kalman_tb ();

    reg  [15:0] data_noised  [0:1023];  //带噪数据
    reg         start_tb = 0;

    reg         rst_n = 1;
    reg  [31:0] data_in;
    reg         en = 1;
    wire [31:0] data_out;

    initial begin
        $readmemh("data_noised.hex", data_noised, 0);  // 读取带噪数据
        #(5);  // 延迟奇数个ns,以避免读入xxx的data_in
        start_tb = 1;
    end

    initial begin
        wait (start_tb);

        #(1024 * 2);
        #(1024 * 2);

        $stop();
    end

    always #1 begin
        en = ~en;
    end

    reg [9:0] k = 0;
    always @(negedge en) begin	// 下降沿导入数据，则上升沿可保证向滤波器发送的是当前周期的数据
        if (start_tb) begin
            k <= k + 1;
            data_in <= data_noised[k];
        end
    end

    //Kalman滤波器
    Kalman #(
        .Q(32'd655),
        .R(32'd65536)
    ) Kalman_inst (
        .rst_n   (rst_n),
        .data_in (data_in),
        .en      (en & start_tb),
        .data_out(data_out)
    );

endmodule
