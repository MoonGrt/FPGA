module DPRAM #(
    parameter INIT_FILE = "init.hex",
    parameter DP = 512,
    parameter AW = $clog2(DP) - 1
) (
    input wire en,

    input  wire        clka,
    input  wire        rsta,
    input  wire        wra,
    input  wire [AW:0] addra,
    input  wire [ 7:0] dina,
    output reg  [ 7:0] douta,

    input  wire        clkb,
    input  wire        rstb,
    input  wire        wrb,
    input  wire [AW:0] addrb,
    input  wire [ 7:0] dinb,
    output reg  [ 7:0] doutb
);

    // Memory declaration
    reg [7:0] ram[0:DP-1];
    initial begin // Initialize memory from file
        `define HEX_INIT_FILE
        // `define BIN_INIT_FILE
        if (INIT_FILE != "") begin
        `ifdef HEX_INIT_FILE
            $readmemh(INIT_FILE, ram);
        `elsif BIN_INIT_FILE
            $readmemb(INIT_FILE, ram);
        `else
            $error("Unsupported INIT_FILE_FORMAT");
        `endif
        end
    end

    // Port A logic
    always @(posedge clka) begin
        if (rsta) douta <= 8'b0;
        else if (en) begin
            if (wra) begin
                ram[addra] <= dina;
                douta <= dina;
            end else douta <= ram[addra];
        end
    end

    // Port B logic
    always @(posedge clkb) begin
        if (rstb) doutb <= 8'b0;
        else if (en) begin
            if (wrb) begin
                ram[addrb] <= dinb;
                doutb <= dinb;
            end else doutb <= ram[addrb];
        end
    end

endmodule
