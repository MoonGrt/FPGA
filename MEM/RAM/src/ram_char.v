/*
    // ram_char Parameters
    parameter DATA_WIDTH     = 8                      ;
    parameter ADDR_WIDTH     = 8                      ;
    parameter RAM_INIT_FILE  = "ram_init_file.inithex";

    // ram_char Inputs
    reg  [(ADDR_WIDTH-1):0] raddr = 0;
    reg                     re    = 0;
    reg                     rclk  = 0;

    // ram_char Outputs
    wire [(DATA_WIDTH-1):0] rdata;

    ram_char #(
        .DATA_WIDTH    ( DATA_WIDTH    ),
        .ADDR_WIDTH    ( ADDR_WIDTH    ),
        .RAM_INIT_FILE ( RAM_INIT_FILE ))
    ram_char (
        .raddr ( raddr ),
        .re    ( re    ),
        .rclk  ( rclk  ),
        .rdata ( rdata )
    );
*/

module ram_char #(
    parameter DATA_WIDTH	= 8,
    parameter ADDR_WIDTH	= 8,
    parameter RAM_INIT_FILE	= "ram_init_file.inithex"
)(
    input  [(ADDR_WIDTH-1):0] raddr,
    output [(DATA_WIDTH-1):0] rdata,
    input  re, rclk
);

    localparam MEMORY_DEPTH = 2**ADDR_WIDTH;
    localparam MAX_DATA = (1<<ADDR_WIDTH)-1;

    reg [DATA_WIDTH-1:0] ram[MEMORY_DEPTH-1:0];
    assign rdata <= ram[raddr];

    initial
    begin
        if (RAM_INIT_FILE != "")
            $readmemh(RAM_INIT_FILE, ram);
    end

endmodule
