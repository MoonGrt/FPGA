`timescale 1ns / 1ps

module tb_simpledualport_ram;

parameter DATA_WIDTH = 16;
parameter ADDR_WIDTH = 5;
	
reg  we = 0;
reg  wclk = 1;
reg  re = 0;
reg  rclk = 1;
reg  [(DATA_WIDTH-1):0] wdata = 0;
reg  [(DATA_WIDTH-1):0] waddr = 0;
reg  [(DATA_WIDTH-1):0] raddr = 0;
wire [(DATA_WIDTH-1):0] rdata;

// port declaration
always #5   wclk = ~wclk;
always #5   rclk = ~rclk;

integer i = 0;
initial begin
//    // 写入一系列数据
//    #100 for (i = 1; i < 32; i = i + 1) begin
//        we = 1;
//        waddr = i;
//        wdata = i;
//        #10;
//    end
//    we = 0;
    
    // 读取并打印数据
    #500 for (i = 1; i < 32; i = i + 1) begin
        re = 1;
        raddr = i;
        #10;
    end
    re = 0;
end

simple_dualport_ram #(
	.DATA_WIDTH	( DATA_WIDTH ),
	.ADDR_WIDTH	( ADDR_WIDTH ),
	.OUTPUT_REG	( "FALSE" ),
	.RAM_INIT_FILE( "F:/Project/FPAG/Project_18.3/RAM/RAM.srcs/sources_1/ram_init_file.inithex" ))
u_simple_dual_port_ram (
/*i*/.wdata	(wdata),
/*i*/.waddr	(waddr), 
/*i*/.raddr	(raddr),
/*i*/.we	(we), 
/*i*/.wclk	(wclk),
/*i*/.re	(re), 
/*i*/.rclk	(rclk),
/*o*/.rdata (rdata)
);

endmodule
