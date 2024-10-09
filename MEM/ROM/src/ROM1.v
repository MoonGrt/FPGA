/*
    // ROM1 Inputs
    reg  [7:0] address = 0;
    reg        read_en = 0;
    reg        ce      = 0;

    // ROM1 Outputs
    wire [7:0] data;

    ROM1 ROM1 (
        .address ( address ),
        .read_en ( read_en ),
        .ce      ( ce      ),
        .data    ( data    )
    );
*/

module ROM1 (
    input  [7:0] address,  // Address input
    output [7:0] data,     // Data output
    input        read_en,  // Read Enable
    input        ce        // Chip Enable
);

    reg [7:0] mem [0:255] ;
    assign data = (ce && read_en) ? mem[address] : 8'b0;

    initial begin
        // $readmemb("F:/Project/FPAG/Vivado_18.3/MEM/ROM/ROM.srcs/sources_1/init_memb", mem);  // memory_list is memory file
        $readmemh("F:/Project/FPAG/Vivado_18.3/MEM/ROM/ROM.srcs/sources_1/init_memh", mem);  // memory_list is memory file
    end

endmodule