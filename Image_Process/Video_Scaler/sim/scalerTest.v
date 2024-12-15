`timescale 1ns / 1ps

module scalerTest #(
parameter INPUT_X_RES = 120-1,
parameter INPUT_Y_RES = 90-1,
parameter OUTPUT_X_RES = 1280-1,   //Output resolution - 1
parameter OUTPUT_Y_RES = 960-1,   //Output resolution - 1
parameter X_SCALE = 32'h4000 * (INPUT_X_RES) / (OUTPUT_X_RES)-1,
parameter Y_SCALE = 32'h4000 * (INPUT_Y_RES) / (OUTPUT_Y_RES)-1,

parameter DATA_WIDTH = 8,
parameter CHANNELS = 3,
parameter DISCARD_CNT_WIDTH = 8,
parameter INPUT_X_RES_WIDTH = 11,
parameter INPUT_Y_RES_WIDTH = 11,
parameter OUTPUT_X_RES_WIDTH = 11,
parameter OUTPUT_Y_RES_WIDTH = 11,
parameter BUFFER_SIZE = 6				//Number of RAMs in RAM ring buffer
)(
input wire [50*8:0] inputFilename,inputFilename1,outputFilename,

//Control
input wire [DISCARD_CNT_WIDTH-1:0]	inputDiscardCnt,		//Number of input pixels to discard before processing data. Used for clipping
input wire [INPUT_X_RES_WIDTH+14-1:0] leftOffset,
input wire [14-1:0]	topFracOffset,
input wire nearestNeighbor,

output reg done

);

`define LEN_HEADER	54  // 0x33

reg clk;
reg rst;

reg [DATA_WIDTH*CHANNELS-1:0] dIn;
reg		dInValid;
wire	nextDin;
reg		start;

wire [DATA_WIDTH*CHANNELS-1:0] dOut;
wire	dOutValid;
reg		nextDout;

reg	[DATA_WIDTH-1:0]		FILE_HEADER[0:`LEN_HEADER-1];//Image Header
reg	[DATA_WIDTH-1:0]		FILE_HEADER1[0:`LEN_HEADER-1];//Image Header

integer r,h,h1,k, rfile,rfile1, wfile;

initial // Clock generator
  begin
    #10 //Delay to allow filename to get here
    clk = 0;
    #5 forever #5 clk = !clk;
  end

initial	// Reset
  begin
	done = 0;
    #10 //Delay to allow filename to get here
    rst = 0;
    #5 rst = 1;
    #4 rst = 0;
   // #50000 $stop;
  end

reg eof;
reg [DATA_WIDTH*CHANNELS-1:0] readMem [0:0];
initial // Input file read, generates dIn data
begin
  #10 //Delay to allow filename to get here
  
	rfile = $fopen(inputFilename, "rb");
	rfile1 = $fopen(inputFilename1, "rb");
	h = $fread(FILE_HEADER, rfile, 0, `LEN_HEADER);
	h1 = $fread(FILE_HEADER1, rfile1, 0, `LEN_HEADER);
	dIn = 0;
	dInValid = 0;
	start = 0;

	#41
	start = 1;

	#10
	start = 0;

	#20
	r = $fread(readMem, rfile);
	dIn = readMem[0];
	
	while(! $feof(rfile))
	begin
		dInValid = 1;
		
		#10 
		if(nextDin) 
		begin
			r = $fread(readMem, rfile);
			dIn = readMem[0];
		end
	end

  $fclose(rfile);
end

//Generate nextDout request signal
initial
begin
  #10 //Delay to match filename arrival delay
	nextDout = 0;
	#140001
	forever
	begin
		//This can be used to slow down the read to simulate live read-out. This basically inserts H blank periods.
		#(10*(OUTPUT_X_RES+1)*4)
		nextDout = 0;
		#(10*(OUTPUT_X_RES+1))
		nextDout = 1;
	end
end

//Read dOut and write to file
integer dOutCount;
initial
begin
  #10 //Delay to allow filename to get here
	wfile = $fopen(outputFilename, "wb");
    for(k=0; k<`LEN_HEADER; k=k+1)begin
	   		$fwrite(wfile, "%c", FILE_HEADER1[k]);//frame 1 header
	   	end	
	dOutCount = 0;
	#1
	while(dOutCount < (OUTPUT_X_RES+1) * (OUTPUT_Y_RES+1))
	begin
		#10
		if(dOutValid == 1)
		begin
			$fwrite(wfile, "%c", dOut[23:16]);
			$fwrite(wfile, "%c", dOut[15:8]);
			$fwrite(wfile, "%c", dOut[7:0]);
			dOutCount = dOutCount + 1;
		end
	end
	$fclose(wfile);
	done = 1;
end

streamScaler #(
.DATA_WIDTH( DATA_WIDTH ),
.CHANNELS( CHANNELS ),
.DISCARD_CNT_WIDTH( DISCARD_CNT_WIDTH ),
.INPUT_X_RES_WIDTH( INPUT_X_RES_WIDTH ),
.INPUT_Y_RES_WIDTH( INPUT_Y_RES_WIDTH ),
.OUTPUT_X_RES_WIDTH( OUTPUT_X_RES_WIDTH ),
.OUTPUT_Y_RES_WIDTH( OUTPUT_Y_RES_WIDTH ),
.BUFFER_SIZE( BUFFER_SIZE )				//Number of RAMs in RAM ring buffer
) scaler_inst (
.clk( clk ),
.rst( rst ),

.dIn( dIn ),
.dInValid( dInValid ),
.nextDin( nextDin ),
.start( start ),

.dOut( dOut ),
.dOutValid( dOutValid ),
.nextDout( nextDout ),

//Control
.inputDiscardCnt( inputDiscardCnt ),		//Number of input pixels to discard before processing data. Used for clipping
.inputXRes( INPUT_X_RES ),				//Input data number of pixels per line
.inputYRes( INPUT_Y_RES ),

.outputXRes( OUTPUT_X_RES ),				//Resolution of output data
.outputYRes( OUTPUT_Y_RES ),
.xScale( X_SCALE ),					//Scaling factors. Input resolution scaled by 1/xScale. Format Q4.14
.yScale( Y_SCALE ),					//Scaling factors. Input resolution scaled by 1/yScale. Format Q4.14

.leftOffset( leftOffset ),
.topFracOffset( topFracOffset ),
.nearestNeighbor( nearestNeighbor )
);

endmodule