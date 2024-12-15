`timescale 1ns / 1ps

//`define INPUT640x512 "src/1.bmp"  //Input image
`define INPUT640x512 "F:/Project/FPAG/image/640_512.bmp"  //Input image
`define INPUT480x384 "F:/Project/FPAG/image/2.bmp"  //Input image
`define INPUT1280x1024 "F:/Project/FPAG/image/1280_1024.bmp"  //Input image
`define INPUT960x768 "F:/Project/FPAG/image/4.bmp"  //Input image
`define INPUT1920x1080 "F:/Project/FPAG/image/5.bmp"  //Input image

//`define OUTPUT_FRAME1 "F:/Project/FPAG/image/out/640x512to1280x1024_near.bmp" //result image frame1
`define OUTPUT_FRAME1 "F:/Project/FPAG/image/out/2.bmp" //result image frame1
`define OUTPUT_FRAME2 "out/640x512to640x512.bmp" //result image frame2
`define OUTPUT_FRAME3 "out/1280x1024to960x768.bmp" //result image frame3
`define OUTPUT_FRAME4 "out/1280x1024to640x512.bmp" //result image frame4
`define OUTPUT_FRAME5 "out/1280x1024to480x384.bmp" //result image frame5
`define OUTPUT_FRAME6 "out/640x512toto1280x1024_21extra.bmp" //result image frame6
`define OUTPUT_FRAME7 "out/50x40to640x512clipped.bmp" //result image

module tb_scaler();
parameter BUFFER_SIZE = 4;

wire [7-1:0] done;

////640x512 to 1280x1024
//	scalerTest #(
//	.INPUT_X_RES ( 640-1 ),
//	.INPUT_Y_RES ( 512-1 ),
//	.OUTPUT_X_RES ( 1280-1 ),   //Output resolution - 1
//	.OUTPUT_Y_RES ( 1024-1 ),   //Output resolution - 1
//	//.X_SCALE ( X_SCALE ),
//	//.Y_SCALE ( Y_SCALE ),

//	.DATA_WIDTH ( 8 ),
//	.DISCARD_CNT_WIDTH ( 8 ),
//	.INPUT_X_RES_WIDTH ( 11 ),
//	.INPUT_Y_RES_WIDTH ( 11 ),
//	.OUTPUT_X_RES_WIDTH ( 11 ),
//	.OUTPUT_Y_RES_WIDTH ( 11 ),
//	.BUFFER_SIZE ( BUFFER_SIZE )				//Number of RAMs in RAM ring buffer
//	) st_640x512to1280x1024 (
//	.inputFilename( `INPUT640x512 ),
//	.inputFilename1( `INPUT1280x1024 ),
//	.outputFilename( `OUTPUT_FRAME1 ),

//	//Control
//	.inputDiscardCnt( 0 ),		//Number of input pixels to discard before processing data. Used for clipping
//	.leftOffset( 0 ),
//	.topFracOffset( 0 ),
////	.nearestNeighbor( 1 ), // 最近邻域
//	.nearestNeighbor( 0 ), // 双线性
//	.done ( done[0] )
//	);
	
////640x512 to 640x512
//	scalerTest #(
//	.INPUT_X_RES ( 640-1 ),
//	.INPUT_Y_RES ( 512-1 ),
//	.OUTPUT_X_RES ( 640-1 ),   //Output resolution - 1
//	.OUTPUT_Y_RES ( 512-1 ),   //Output resolution - 1
//	.X_SCALE ( 32'h4000 ),
//	.Y_SCALE ( 32'h4000 ),

//	.DATA_WIDTH ( 8 ),
//	.DISCARD_CNT_WIDTH ( 8 ),
//	.INPUT_X_RES_WIDTH ( 11 ),
//	.INPUT_Y_RES_WIDTH ( 11 ),
//	.OUTPUT_X_RES_WIDTH ( 11 ),
//	.OUTPUT_Y_RES_WIDTH ( 11 ),
//	.BUFFER_SIZE ( BUFFER_SIZE )				//Number of RAMs in RAM ring buffer
//	) st_640x512to640x512 (
//	.inputFilename( `INPUT640x512 ),
//	.inputFilename1( `INPUT640x512  ),
//	.outputFilename( `OUTPUT_FRAME2 ),

//	//Control
//	.inputDiscardCnt( 0 ),		//Number of input pixels to discard before processing data. Used for clipping
//	.leftOffset( 0 ),
//	.topFracOffset( 0 ),
//	.nearestNeighbor( 0 ),
//	.done ( done[1] )
//	);
	
//1280x1024 to 960x768
	scalerTest #(
	.INPUT_X_RES ( 1280-1 ),
	.INPUT_Y_RES ( 1024-1 ),
	.OUTPUT_X_RES ( 960-1 ),   //Output resolution - 1
	.OUTPUT_Y_RES ( 768-1 ),   //Output resolution - 1
	//.X_SCALE ( X_SCALE ),
	//.Y_SCALE ( Y_SCALE ),

	.DATA_WIDTH ( 8 ),
	.DISCARD_CNT_WIDTH ( 8 ),
	.INPUT_X_RES_WIDTH ( 11 ),
	.INPUT_Y_RES_WIDTH ( 11 ),
	.OUTPUT_X_RES_WIDTH ( 11 ),
	.OUTPUT_Y_RES_WIDTH ( 11 ),
	.BUFFER_SIZE ( BUFFER_SIZE )				//Number of RAMs in RAM ring buffer
	) st_1280x1024to960x768 (
	.inputFilename( `INPUT1280x1024 ),
	.inputFilename1( `INPUT960x768  ),
	.outputFilename( `OUTPUT_FRAME1 ),

	//Control
	.inputDiscardCnt( 0 ),		//Number of input pixels to discard before processing data. Used for clipping
	.leftOffset( 0 ),
	.topFracOffset( 0 ),
	.nearestNeighbor( 0 ),
  	.done ( done[2] )
	);

////1280x1024 to 640x512
//	scalerTest #(
//	.INPUT_X_RES ( 1280-1 ),
//	.INPUT_Y_RES ( 1024-1 ),
//	.OUTPUT_X_RES ( 640-1 ),   //Output resolution - 1
//	.OUTPUT_Y_RES ( 512-1 ),   //Output resolution - 1
//	.X_SCALE ( 32'h4000*2 ),
//	.Y_SCALE ( 32'h4000*2 ),

//	.DATA_WIDTH ( 8 ),
//	.DISCARD_CNT_WIDTH ( 8 ),
//	.INPUT_X_RES_WIDTH ( 11 ),
//	.INPUT_Y_RES_WIDTH ( 11 ),
//	.OUTPUT_X_RES_WIDTH ( 11 ),
//	.OUTPUT_Y_RES_WIDTH ( 11 ),
//	.BUFFER_SIZE ( BUFFER_SIZE )				//Number of RAMs in RAM ring buffer
//	) st_1280x1024to640x512 (
//	.inputFilename( `INPUT1280x1024 ),
//	.inputFilename1(  `INPUT640x512  ),
//	.outputFilename( `OUTPUT_FRAME4 ),

//	//Control
//	.inputDiscardCnt( 0 ),		//Number of input pixels to discard before processing data. Used for clipping
//	.leftOffset( 25'h1FFF ),
//	.topFracOffset( 25'h1FFF ),
//	.nearestNeighbor( 0 ),
//	.done ( done[3] )
//	);	
	
////1280x1024 to 480x384

//	scalerTest #(
//	.INPUT_X_RES ( 1280-1 ),
//	.INPUT_Y_RES ( 1024-1 ),
//	.OUTPUT_X_RES ( 480-1 ),   //Output resolution - 1
//	.OUTPUT_Y_RES ( 384-1 ),   //Output resolution - 1
//	//.X_SCALE ( 32'h4000*2 ),
//	//.Y_SCALE ( 32'h4000*2 ),

//	.DATA_WIDTH ( 8 ),
//	.DISCARD_CNT_WIDTH ( 8 ),
//	.INPUT_X_RES_WIDTH ( 11 ),
//	.INPUT_Y_RES_WIDTH ( 11 ),
//	.OUTPUT_X_RES_WIDTH ( 11 ),
//	.OUTPUT_Y_RES_WIDTH ( 11 ),
//	.BUFFER_SIZE ( BUFFER_SIZE )				//Number of RAMs in RAM ring buffer
//	) st_1280x1024to480x384 (
//	.inputFilename( `INPUT1280x1024 ),
//	.inputFilename1(  `INPUT480x384 ),
//	.outputFilename( `OUTPUT_FRAME5 ),

//	//Control
//	.inputDiscardCnt( 0 ),		//Number of input pixels to discard before processing data. Used for clipping
//	.leftOffset( 0 ),
//	.topFracOffset( 0 ),
//	.nearestNeighbor( 0 ),
//	.done ( done[4] )
//		);
	
////640x512 to 1280x1024, discarding 21

//	scalerTest #(
//	.INPUT_X_RES ( 640-1 ),
//	.INPUT_Y_RES ( 512-1 ),
//	.OUTPUT_X_RES ( 1280-1 ),   //Output resolution - 1
//	.OUTPUT_Y_RES ( 1024-1 ),   //Output resolution - 1
//	//.X_SCALE ( 32'h4000*2 ),
//	//.Y_SCALE ( 32'h4000*2 ),

//	.DATA_WIDTH ( 8 ),
//	.DISCARD_CNT_WIDTH ( 8 ),
//	.INPUT_X_RES_WIDTH ( 11 ),
//	.INPUT_Y_RES_WIDTH ( 11 ),
//	.OUTPUT_X_RES_WIDTH ( 11 ),
//	.OUTPUT_Y_RES_WIDTH ( 11 ),
//	.BUFFER_SIZE ( BUFFER_SIZE )				//Number of RAMs in RAM ring buffer
//	) st_640x512to1280x1024_21extra (
//	.inputFilename( `INPUT640x512 ),
//	.inputFilename1(  `INPUT1280x1024 ),
//	.outputFilename( `OUTPUT_FRAME6 ),

//	//Control
//	.inputDiscardCnt( 21 ),		//Number of input pixels to discard before processing data. Used for clipping
//	.leftOffset( 0 ),
//	.topFracOffset( 0 ),
//	.nearestNeighbor( 0 ),
//	.done ( done[5] )
//		);
	
	
	
	
	
	
	
	
	
/*	
	//640x512 to 1280x1024, discarding 21

	scalerTest #(
	.INPUT_X_RES ( 640-1 ),
	.INPUT_Y_RES ( 40-1 ),
	.OUTPUT_X_RES ( 640-1 ),   //Output resolution - 1
	.OUTPUT_Y_RES ( 512-1 ),   //Output resolution - 1
	.X_SCALE ( 32'h4000 * (50-1) / (640-1)-1 ),
	.Y_SCALE ( 32'h4000 * (40-1) / (512-1)-1 ),

	.DATA_WIDTH ( 8 ),
	.DISCARD_CNT_WIDTH ( 14 ),
	.INPUT_X_RES_WIDTH ( 11 ),
	.INPUT_Y_RES_WIDTH ( 11 ),
	.OUTPUT_X_RES_WIDTH ( 11 ),
	.OUTPUT_Y_RES_WIDTH ( 11 ),
	.BUFFER_SIZE ( BUFFER_SIZE )				//Number of RAMs in RAM ring buffer
	) st_50x40to640x512clipped (
	.inputFilename( `INPUT640x512 ),
	.inputFilename1(  `INPUT1280x1024 ),
	.outputFilename( `OUTPUT_FRAME7 ),

	//Control
	.inputDiscardCnt( 640*3 ),		//Number of input pixels to discard before processing data. Used for clipping
	.leftOffset( {11'd249, 14'b0} ),
	.topFracOffset( 0 ),
	.nearestNeighbor( 0 ),
	.done ( done[6] )
		);
*/	
		
//	initial
//	begin
//	  #10
//	  while(done != 7'b0111111)
//	   #10
//	   ;
//		$stop;
//	end
endmodule

