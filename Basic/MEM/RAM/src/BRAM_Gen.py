import sys

def BRAM_DPRAM_Gen(N=4, DP=512, DW=8):
    header = f"""\
/*
    // DPBRAM{N} Parameters
    parameter FILE_BASE = "init";
    parameter DP = {DP};
    parameter DW = {DW};
    parameter N = {N};
    parameter AW = $clog2(DP) - 1;
    parameter BDW = N * DW - 1;
    // DPBRAM{N} Signals
    reg          en;
    reg          clka;
    reg          rsta;
    reg          wra;
    reg  [ AW:0] addra;
    reg  [BDW:0] dina;
    wire [BDW:0] douta;
    reg          clkb;
    reg          rstb;
    reg          wrb;
    reg  [ AW:0] addrb;
    reg  [BDW:0] dinb;
    wire [BDW:0] doutb;
    // DPBRAM{N} Instance
    DPBRAM{N} #(
        .FILE_BASE(FILE_BASE),
        .DP       (DP),
        .DW       (DW),
        .N        (N),
        .AW       (AW),
        .BDW      (BDW)
    ) DPBRAM{N} (
        .clka (clka),
        .rsta (rsta),
        .cea  (cea),
        .wra  (wra),
        .addra(addra),
        .dina (dina),
        .douta(douta),
        .clkb (clkb),
        .rstb (rstb),
        .ceb  (ceb),
        .wrb  (wrb),
        .addrb(addrb),
        .dinb (dinb),
        .doutb(doutb)
    );
*/

module DPBRAM{N} #(
    parameter FILE_BASE = "init",   // File base name
    parameter DP = {DP},             // DPRAM depth
    parameter DW = {DW},               // DPRAM width
    parameter N  = {N},               // Number of DPRAM instances (DW-bit each)
    parameter AW = $clog2(DP) - 1,  // Address width (log2(DP))
    parameter BDW = N * DW - 1      // Data width
) (
    input  wire         clka,
    input  wire         rsta,
    input  wire         cea,
    input  wire         wra,
    input  wire [ AW:0] addra,
    input  wire [BDW:0] dina,
    output wire [BDW:0] douta,

    input  wire         clkb,
    input  wire         rstb,
    input  wire         ceb,
    input  wire         wrb,
    input  wire [ AW:0] addrb,
    input  wire [BDW:0] dinb,
    output wire [BDW:0] doutb
);
"""

    insts = "\n"
    for i in range(N):
        insts += f"""\
    localparam INIT_FILE{i} = {{FILE_BASE, "{i}.hex"}};
"""
    for i in range(N):
        insts += f"""\
    DPRAM #(.INIT_FILE(INIT_FILE{i}), .DP(DP), .DW(DW)) DPRAM{i} (
        .clka(clka), .rsta(rsta), .cea(cea), .wra(wra), .addra(addra), .dina(dina[{(i+1)*8-1}:{i*8}]), .douta(douta[{(i+1)*8-1}:{i*8}]),
        .clkb(clkb), .rstb(rstb), .ceb(ceb), .wrb(wrb), .addrb(addrb), .dinb(dinb[{(i+1)*8-1}:{i*8}]), .doutb(doutb[{(i+1)*8-1}:{i*8}]));
"""

    footer = "\nendmodule\n"

    return header + insts + footer

def BRAM_SDPRAM_Gen(N=4, DP=512, DW=8):
    header = f"""\
/*
    // SDPBRAM{N} Parameters
    parameter T = 10;
    parameter FILE_BASE = "init";
    parameter DP = {DP};
    parameter DW = {DW};
    parameter N = {N};
    parameter AW = $clog2(DP) - 1;
    parameter BDW = N * DW - 1;
    // SDPBRAM{N} Inputs
    reg          clka;
    reg          rsta;
    reg          cea;
    reg  [ AW:0] addra;
    reg  [BDW:0] dina;
    reg          clkb;
    reg          rstb;
    reg          ceb;
    reg  [ AW:0] addrb;
    wire [BDW:0] doutb;
    // SDPBRAM{N} Instance
    SDPBRAM{N} #(
        .FILE_BASE(FILE_BASE),
        .DP       (DP),
        .DW       (DW),
        .N        (N),
        .AW       (AW),
        .BDW      (BDW)
    ) SDPBRAM{N} (
        .clka (clka),
        .rsta (rsta),
        .cea  (cea),
        .addra(addra),
        .dina (dina),
        .clkb (clkb),
        .rstb (rstb),
        .ceb  (ceb),
        .addrb(addrb),
        .doutb(doutb)
    );
*/

module SDPBRAM{N} #(
    parameter FILE_BASE = "init",   // File base name
    parameter DP = {DP},             // DPRAM depth
    parameter DW = {DW},               // DPRAM width
    parameter N  = {N},               // Number of DPRAM instances (DW-bit each)
    parameter AW = $clog2(DP) - 1,  // Address width (log2(DP))
    parameter BDW = N * DW - 1      // Data width
) (
    input  wire         clka,
    input  wire         rsta,
    input  wire         cea,
    input  wire [ AW:0] addra,
    input  wire [BDW:0] dina,

    input  wire         clkb,
    input  wire         rstb,
    input  wire         ceb,
    input  wire [ AW:0] addrb,
    output wire [BDW:0] doutb
);
"""

    insts = "\n"
    for i in range(N):
        insts += f"""\
    localparam INIT_FILE{i} = {{FILE_BASE, "{i}.hex"}};
"""
    for i in range(N):
        insts += f"""\
    SDPRAM #(.INIT_FILE(INIT_FILE{i}), .DP(DP), .DW(DW)) SDPRAM{i} (
        .clka (clka), .rsta (rsta), .cea  (cea), .addra(addra), .dina(dina[{(i+1)*8-1}:{i*8}]),
        .clkb (clkb), .rstb (rstb), .ceb  (ceb), .addrb(addrb), .doutb(doutb[{(i+1)*8-1}:{i*8}]));
"""

    footer = "\nendmodule\n"

    return header + insts + footer


def main():
    # 默认参数
    N = 4
    DP = 512
    DW = 8

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
    if len(sys.argv) > 3:
        try:
            DW = int(sys.argv[3])
        except:
            print("Invalid dw value, using default 8")

    # BRAM_DPRAM_Gen
    verilog_code = BRAM_DPRAM_Gen(N, DP, DW)
    filename = f"DPBRAM{N}.v"
    with open(filename, "w") as f:
        f.write(verilog_code)
    print(f"Generated {filename} with N={N}, DP={DP}, DW={DW}")

    # BRAM_SDPRAM_Gen
    verilog_code = BRAM_SDPRAM_Gen(N, DP, DW)
    filename = f"SDPBRAM{N}.v"
    with open(filename, "w") as f:
        f.write(verilog_code)
    print(f"Generated {filename} with N={N}, DP={DP}, DW={DW}")

if __name__ == "__main__":
    main()
