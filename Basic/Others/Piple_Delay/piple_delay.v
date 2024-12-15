/*
    // piple_delay Parameters
    parameter DLY  = 3;

    // piple_delay Inputs
    reg   siganl_i = 0;

    // piple_delay Outputs
    wire  siganl_o;

    piple_delay #(
        .DLY ( DLY ))
    piple_delay (
        .clk      ( clk      ),
        .siganl_i ( siganl_i ),
        .siganl_o ( siganl_o )
    );
*/

module piple_delay #(
    parameter DLY = 3
) (
    input  wire clk,
    input  wire siganl_i,
    output wire siganl_o
);

    // reg [DLY:0] rst_dly = {DLY{1'b0}};
    reg [DLY:0] rst_dly = {(DLY + 1) {1'b0}};
    always @(posedge clk) rst_dly <= {siganl_i, rst_dly[DLY:1]};
    assign siganl_o = rst_dly[0];

endmodule
