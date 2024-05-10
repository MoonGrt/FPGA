`timescale 1ns / 1ps

module led_twinkle (
    input sys_clk_p,  // ϵͳ�������ʱ��
    input sys_clk_n,  // ϵͳ�������ʱ��
    input sys_rst_n,  // ϵͳ��λ���͵�ƽ��Ч

    output [1:0] led  // LED��
);

    // reg define
    reg [26:0] cnt;

    //*****************************************************
    //**                    main code
    //*****************************************************

    // �Լ�������ֵ�����жϣ������LED��״̬
    assign led = (cnt < 27'd5000_0000) ? 2'b01 : 2'b10;
    //assign led = (cnt <  27'd5)           ? 2'b01 : 2'b10 ;  // �����ڷ���

    // ת������ź�
    IBUFDS diff_clock (
        .I (sys_clk_p),  // ϵͳ�������ʱ��
        .IB(sys_clk_n),  // ϵͳ�������ʱ��
        .O (sys_clk)     // ���ϵͳʱ��
    );

    // ��������0~10000_0000֮����м���
    always @(posedge sys_clk or negedge sys_rst_n) begin
        if (!sys_rst_n) cnt <= 27'd0;
        //else if(cnt <  27'd10)  // �����ڷ���
        else if (cnt < 27'd10000_0000) cnt <= cnt + 1'b1;
        else cnt <= 27'd0;
    end

endmodule