import sys

def generate_bram_module(N=4, DP=512):
    header = f"""\
/*
    // BRAM{N} Parameters
    parameter FILE_BASE = "init";
    parameter DP = {DP};
    parameter N = {N};
    parameter AW = $clog2(DP) - 1;
    parameter DW = N * 8 - 1;
    // BRAM{N} Signals
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

    BRAM{N} #(
        .FILE_BASE(FILE_BASE),
        .DP       (DP),
        .N        (N),
        .AW       (AW),
        .DW       (DW)
    ) BRAM{N} (
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

module BRAM{N} #(
    parameter FILE_BASE = "init",   // File base name
    parameter DP = {DP},             // DPRAM depth (number of words)
    parameter N  = {N},               // Number of DPRAM instances (8-bit each)
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
"""

    insts = "\n"
    for i in range(N):
        insts += f"""\
    localparam INIT_FILE{i} = {{FILE_BASE, "{i}.hex"}};
"""
    for i in range(N):
        insts += f"""\
    DPRAM #(.INIT_FILE(INIT_FILE{i}), .DP(DP)) DPRAM{i} (.en(en),
        .clka(clka), .rsta(rsta), .wra(wra), .addra(addra), .dina(dina[{(i+1)*8-1}:{i*8}]), .douta(douta[{(i+1)*8-1}:{i*8}]),
        .clkb(clkb), .rstb(rstb), .wrb(wrb), .addrb(addrb), .dinb(dinb[{(i+1)*8-1}:{i*8}]), .doutb(doutb[{(i+1)*8-1}:{i*8}]));
"""

    footer = "\nendmodule\n"

    return header + insts + footer


def main():
    # 默认参数
    N = 4
    DP = 512

    # 读取命令行参数
    if len(sys.argv) > 1:
        try:
            N = int(sys.argv[1])
        except:
            print("Invalid n value, using default 4")
    if len(sys.argv) > 2:
        try:
            DP = int(sys.argv[2])
        except:
            print("Invalid dp value, using default 512")

    verilog_code = generate_bram_module(N, DP)

    filename = f"BRAM{N}.v"
    with open(filename, "w") as f:
        f.write(verilog_code)

    print(f"Generated {filename} with N={N}, DP={DP}")


if __name__ == "__main__":
    main()
