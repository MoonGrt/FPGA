      `timescale 1ns / 1ps
      module tb_ROM1;
      reg [7:0] address;
      reg read_en, ce;
      wire [7:0] data;
      integer i;
      initial begin
        address = 0;
        read_en = 0;
        ce = 0;
        //#10 $monitor ("address = %h, data = %h, read_en = %b, ce = %b", address, data, read_en, ce);
        for (i = 0; i < 256; i = i + 1 )begin
       #5
     	 address = i;
      read_en = 1;
      ce = 1;
       #5
     	 read_en = 0;
      ce = 0;
      address = 0;
        end
      end
      ROM1 ROM1(
      .address(address) , // Address input
      .data(data) , // Data output
      .read_en(read_en) , // Read Enable
      .ce(ce) // Chip Enable
      );
      endmodule