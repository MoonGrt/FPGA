/*
    // debounce Parameters
    parameter CNT_NMB = 100_0000;

    // debounce Inputs
    reg   key_i = 0;

    // debounce Outputs
    wire  key_o;

    debounce #(
        .CNT_NMB ( CNT_NMB ))
    debounce (
        .clk   ( clk   ),
        .key_i ( key_i ),
        .key_o ( key_o )
    );
*/
aaaaaaaaaaaaaaaaaaaaaa
module debounce #(
    parameter CNT_NMB = 100_0000  // delay 100_0000 * 20ns(1s/50MHz) = 20ms (50MHz)
) (
    input      clk,
    input      key_i,     // Key signal for external input
    output reg key_o = 0  // Key signal after dithering
);

    // reg define
    reg [31:0] cnt = 20'd0;
    reg        key_reg = 1'b0;

    // Key signal dithering
    always @(posedge clk) begin
        key_reg <= key_i;  // Delay the key signal by one beat
        if (key_reg != key_i)  // If the current key signal is not the same as the key signal of the previous beat, i.e., the key is pressed or released
            cnt <= CNT_NMB;  // Set counter to CNT_NMB
        else begin  // If the current key signal is the same as the previous key signal, i.e., the key has not changed
            if (cnt > 32'd0)  // Counter decreases to 0
                cnt <= cnt - 1'b1;
            else cnt <= 32'd0;
        end
    end

    // Send the final key signal after dithering.
    always @(posedge clk) begin
        if (cnt == 32'd1) key_o <= key_i;
        else key_o <= key_o;
    end

endmodule
