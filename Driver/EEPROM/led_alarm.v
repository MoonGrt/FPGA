module led_alarm #(
    parameter L_TIME = 25'd25_000_000
) (
    input clk,   // 时钟信号
    input rst_n, // 复位信号

    input      rw_done,    // 错误标志
    input      rw_result,  // E2PROM读写测试完成
    output reg led         // E2PROM读写测试结果 0:失败 1:成功
);

    // reg define
    reg        rw_done_flag;  // 读写测试完成标志
    reg [24:0] led_cnt;  // led计数

    //*****************************************************
    //**                    main code
    //*****************************************************

    // 读写测试完成标志
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) rw_done_flag <= 1'b0;
        else if (rw_done) rw_done_flag <= 1'b1;
    end

    // 错误标志为1时PL_LED0闪烁，否则PL_LED0常亮
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            led_cnt <= 25'd0;
            led <= 1'b0;
        end else begin
            if (rw_done_flag) begin
                if (rw_result)  // 读写测试正确
                    led <= 1'b1;  // led灯常亮
                else begin  // 读写测试错误
                    led_cnt <= led_cnt + 25'd1;
                    if (led_cnt == L_TIME - 1'b1) begin
                        led_cnt <= 25'd0;
                        led     <= ~led;  // led灯闪烁
                    end
                end
            end else led <= 1'b0;  // 读写测试完成之前,led灯熄灭
        end
    end

endmodule
