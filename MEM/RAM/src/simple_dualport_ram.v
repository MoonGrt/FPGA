/*
    // simple_dualport_ram Parameters
    parameter DATA_WIDTH     = 8                      ;
    parameter ADDR_WIDTH     = 9                      ;
    parameter OUTPUT_REG     = "FALSE"                ;
    parameter RAM_INIT_FILE  = "ram_init_file.inithex";

    // simple_dualport_ram Inputs
    reg  [(DATA_WIDTH-1):0] wdata = 0;
    reg  [(ADDR_WIDTH-1):0] waddr = 0;
    reg  [(ADDR_WIDTH-1):0] raddr = 0;
    reg                     we    = 0;
    reg                     wclk  = 0;
    reg                     re    = 0;
    reg                     rclk  = 0;

    // simple_dualport_ram Outputs
    wire [(DATA_WIDTH-1):0] rdata;

    simple_dualport_ram #(
        .DATA_WIDTH    ( DATA_WIDTH    ),
        .ADDR_WIDTH    ( ADDR_WIDTH    ),
        .OUTPUT_REG    ( OUTPUT_REG    ),
        .RAM_INIT_FILE ( RAM_INIT_FILE ))
    simple_dualport_ram (
        .wdata ( wdata ),
        .waddr ( waddr ),
        .raddr ( raddr ),
        .we    ( we    ),
        .wclk  ( wclk  ),
        .re    ( re    ),
        .rclk  ( rclk  ),
        .rdata ( rdata )
    );
*/

module simple_dualport_ram #(
    parameter DATA_WIDTH    = 8,
    parameter ADDR_WIDTH    = 9,
    parameter OUTPUT_REG    = "FALSE",
    parameter RAM_INIT_FILE = "ram_init_file.inithex"
)(
    input  [(DATA_WIDTH-1):0] wdata,
    input  [(ADDR_WIDTH-1):0] waddr, raddr,
    input  we, wclk, re, rclk,
    output [(DATA_WIDTH-1):0] rdata
);

    localparam MEMORY_DEPTH = 2 ** ADDR_WIDTH;
    //localparam MAX_DATA = (1<<ADDR_WIDTH)-1;

    reg [DATA_WIDTH-1:0] ram [MEMORY_DEPTH-1:0];
    reg [DATA_WIDTH-1:0] r_rdata_1P = 0;
    reg [DATA_WIDTH-1:0] r_rdata_2P = 0;

    initial begin
        // By default the Efinix memory will initialize to 0
        if (RAM_INIT_FILE != "") begin
            $readmemh(RAM_INIT_FILE, ram);
        end
    end

    always @(posedge wclk) if (we) ram[waddr] <= wdata;

    always @(posedge rclk) begin
        if (re) r_rdata_1P <= ram[raddr];
        r_rdata_2P <= r_rdata_1P;
    end

    generate
        if (OUTPUT_REG == "TRUE") assign rdata = r_rdata_2P;
        else assign rdata = r_rdata_1P;
    endgenerate

endmodule
