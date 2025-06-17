/*
    // BRAM3 Parameters
    parameter FILE_BASE = "init";
    parameter DP = 512;
    parameter N = 3;
    parameter AW = $clog2(DP) - 1;
    parameter DW = N * 8 - 1;
    // BRAM3 Signals
    wire        en = 0;
    wire        clka = 0;
    wire        rsta = 0;
    wire        wra = 0;
    wire [AW:0] addra = 0;
    wire [DW:0] dina = 0;
    wire [DW:0] douta;
    wire        clkb = 0;
    wire        rstb = 0;
    wire        wrb = 0;
    wire [AW:0] addrb = 0;
    wire [DW:0] dinb = 0;
    wire [DW:0] doutb;

    BRAM3 #(
        .FILE_BASE(FILE_BASE),
        .DP       (DP),
        .N        (N),
        .AW       (AW),
        .DW       (DW)
    ) BRAM3 (
        .en   (en),
        .clka (clka),
        .rsta (rsta),
        .wra  (wra),
        .addra(addra),
        .dina (dina),
        .clkb (clkb),
        .rstb (rstb),
        .wrb  (wrb),
        .addrb(addrb),
        .dinb (dinb),
        .douta(douta),
        .doutb(doutb)
    );
*/

module BRAM3 #(
    parameter FILE_BASE = "init",   // File base name
    parameter DP = 512,             // DPRAM depth (number of words)
    parameter N  = 3,               // Number of DPRAM instances (8-bit each)
    parameter AW = $clog2(DP) - 1,  // Address width (log2(DP))
    parameter DW = N * 8 - 1        // Data width
) (
    input wire en,

    input  wire        clka,
    input  wire        rsta,
    input  wire        wra,
    input  wire [AW:0] addra,
    input  wire [DW:0] dina,
    output wire [DW:0] douta,

    input  wire        clkb,
    input  wire        rstb,
    input  wire        wrb,
    input  wire [AW:0] addrb,
    input  wire [DW:0] dinb,
    output wire [DW:0] doutb
);

    localparam INIT_FILE0 = {FILE_BASE, "0.hex"};
    localparam INIT_FILE1 = {FILE_BASE, "1.hex"};
    localparam INIT_FILE2 = {FILE_BASE, "2.hex"};
    DPRAM #(.INIT_FILE(INIT_FILE0), .DP(DP)) DPRAM0 (.en(en),
        .clka(clka), .rsta(rsta), .wra(wra), .addra(addra), .dina(dina[7:0]), .douta(douta[7:0]),
        .clkb(clkb), .rstb(rstb), .wrb(wrb), .addrb(addrb), .dinb(dinb[7:0]), .doutb(doutb[7:0]));
    DPRAM #(.INIT_FILE(INIT_FILE1), .DP(DP)) DPRAM1 (.en(en),
        .clka(clka), .rsta(rsta), .wra(wra), .addra(addra), .dina(dina[15:8]), .douta(douta[15:8]),
        .clkb(clkb), .rstb(rstb), .wrb(wrb), .addrb(addrb), .dinb(dinb[15:8]), .doutb(doutb[15:8]));
    DPRAM #(.INIT_FILE(INIT_FILE2), .DP(DP)) DPRAM2 (.en(en),
        .clka(clka), .rsta(rsta), .wra(wra), .addra(addra), .dina(dina[23:16]), .douta(douta[23:16]),
        .clkb(clkb), .rstb(rstb), .wrb(wrb), .addrb(addrb), .dinb(dinb[23:16]), .doutb(doutb[23:16]));

endmodule
