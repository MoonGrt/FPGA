`timescale 1ns / 1ps

module v1(
    input clk,
    input [7:0] sw,
    output [7:0] led,
    output Hsync,
    output Vsync,
    output [3:0] vgaRed,
    output [3:0] vgaGreen,
    output [3:0] vgaBlue
    );                                                              
  parameter  ta=80,tb=160,tc=800,td=40,te=1056,to=3,tp=21,tq=600,tr=1,ts=624;  
        reg[10:0] x_counter=0;                           
        reg[10:0] y_counter=0;
        reg [2:0] colour;
        wire clk_vga;
    assign led=sw;                               
   clk_wiz_0 uut_clk                          
     (
         .clk_in1(clk),
          .clk_out1(clk_vga)
     );
      always @(posedge clk_vga) begin    
          begin
              if(x_counter==te-1)// 1055
              begin
                  x_counter = 0;     
                  if(y_counter == ts-1)
                      y_counter = 0;
                  else
                      y_counter = y_counter + 1;
              end
              else
                  x_counter = x_counter + 1;
          end
      end   
     always @(x_counter or y_counter)                                         
      begin
          if (x_counter<340)   colour<=3'b001;
              else if (x_counter<440)    colour<=3'b010;
              else if (x_counter<540)    colour<=3'b011;
              else if (x_counter<640)   colour<=3'b100;
              else if (x_counter<740)    colour<=3'b101;
              else if (x_counter<840)    colour<=3'b110;
              else if (x_counter<940)    colour<=3'b111;   
              else   colour<=3'b000 ; 
          end    
      assign  vgaRed={4{colour[2]}};                                          
      assign  vgaGreen={4{colour[1]}};
      assign  vgaBlue={4{colour[0]}};
      assign Hsync = !(x_counter < ta);                                      
      assign Vsync = !(y_counter < to);   
endmodule   
