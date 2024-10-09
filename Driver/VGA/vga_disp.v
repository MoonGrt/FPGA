`timescale 1ns / 1ps

module vga_disp (
    input        clk,
    input [10:0] pixel_xpos,  // 像素点横坐标
    input [10:0] pixel_ypos,  // 像素点纵坐标
    input        in_flag,     // 接收一帧数据完成标志
    input [ 7:0] in_data,     // 接收的数据

    output reg [2:0] pixel_data = 0  // 像素点数据,
);

    localparam WHITE = 3'b111;  // 背景颜色 白色
    localparam BLACK = 3'b000;  // 黑色

    localparam CHAR_WIDTH = 11'd16;  // 字符宽度
    localparam CHAR_HEIGHT = 11'd32;  // 字符高度

    wire    [  7:0] char;
    reg     [  7:0] map      [31:0];
    reg     [  4:0] addr = 0;
    reg     [512:0] char_data[16:0];

    integer i;
    initial begin  // 数组初始化
        for (i = 0; i < 32; i = i + 1) begin
            map[i] = 16;
        end
        char_data[0] = 512'h0;
        char_data[ 1] = 512'h000000000000000200060004000C000800180010003000200060004000C000800180010003000200060004000C00080018001000300020006000400000000000;
        char_data[ 2] = 512'h0000000040002000100018000C0004000600020003000300018001800180018001800180018001800180030003000300060004000C0018001000200040000000;
        char_data[ 3] = 512'h00000000000000000000000003C006200C30181818181808300C300C300C300C300C300C300C300C300C300C1808181818180C30062003C00000000000000000;
        char_data[ 4] = 512'h000000000002000400080018003000200060004000C000C001800180018001800180018001800180018000C000C0004000600020003000180008000400020000;
        char_data[ 5] = 512'h0000000000000000000000000000000000C001C001C030C6388E1C9C06B001C001C006B01C9C388E318601C001C001C000000000000000000000000000000000;
        char_data[ 6] = 512'h00000000000000000000000007C018603030301830183018001800180030006003C0007000180008000C000C300C300C30083018183007C00000000000000000;
        char_data[ 7] = 512'h00000000000000000000000007E008381018200C200C300C300C000C001800180030006000C0018003000200040408041004200C3FF83FF80000000000000000;
        char_data[ 8] = 512'h000000000000000000000000008001801F800180018001800180018001800180018001800180018001800180018001800180018003C01FF80000000000000000;
        char_data[ 9] = 512'h00000000000000000000000000000000000000000000000000000000000000007FFE000000000000000000000000000000000000000000000000000000000000;
        char_data[10] = 512'h00000000000000000000000001E006180C180818180010001000300033E0363038183808300C300C300C300C300C180C18080C180E3003E00000000000000000;
        char_data[11] = 512'h0000000000000000000000000FFC0FFC10001000100010001000100013E0143018181008000C000C000C000C300C300C20182018183007C00000000000000000;
        char_data[12] = 512'h0000000000000000000000000060006000E000E0016001600260046004600860086010603060206040607FFC0060006000600060006003FC0000000000000000;
        char_data[13] = 512'h00000000000000000000000000000000000000800080008000800080008000803FFE008000800080008000800080008000000000000000000000000000000000;
        char_data[14] = 512'h00000000000000000000000007C01820301030186008600C600C600C600C600C701C302C186C0F8C000C0018001800103030306030C00F800000000000000000;
        char_data[15] = 512'h00000000000000000000000007E00C301818300C300C300C380C38081E180F2007C018F030783038601C600C600C600C600C3018183007C00000000000000000;
        char_data[16] = 512'h0000000000000000000000001FFC1FFC100830102010202000200040004000400080008001000100010001000300030003000300030003000000000000000000;
        char_data[17] = 512'h0;
    end

    assign char = map[(pixel_xpos-144)/CHAR_WIDTH] + 1;

    always @(posedge clk) begin
        if (in_flag) begin
            map[addr] <= in_data;
            if (addr == 5'd31) addr <= 0;
            else addr <= addr + 1;
        end else begin
            addr <= addr;
            map[addr] <= map[addr];
        end
    end

    always @(pixel_xpos or pixel_ypos) begin
        if (pixel_xpos < 144 || pixel_xpos > 656 || pixel_ypos < 288 || pixel_ypos > 320)
            pixel_data <= BLACK;
        else if(char_data[char][CHAR_WIDTH * CHAR_HEIGHT  - pixel_xpos % CHAR_WIDTH - (pixel_ypos % CHAR_HEIGHT) * CHAR_WIDTH])
            pixel_data <= WHITE;  // 显示字符
        else pixel_data <= BLACK;
    end

endmodule
