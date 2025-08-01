module core_top #(
    parameter MEMORY_FILE = "",
    parameter MEMORY_SIZE = 4096
)(
    input  wire clk,
    input  wire rst_n
);

    wire        rd_en;
    wire        wr_en;
    wire [31:0] addr;
    wire [31:0] data_in;
    wire [31:0] data_out;

    Memory #(
        .MEMORY_FILE(MEMORY_FILE),
        .MEMORY_SIZE(MEMORY_SIZE)
    ) mem (
        .clk(clk),
        .rd_en_i(rd_en),
        .wr_en_i(wr_en),
        .addr_i(addr),
        .data_i(data_out),
        .data_o(data_in),
        .ack_o() 
    );

    Core #(
        .BOOT_ADDRESS(32'h00000000)
    ) core (
        .clk(clk),
        .rst_n(rst_n),
        .rd_en_o(rd_en),
        .wr_en_i(wr_en),
        .data_i(data_in),
        .addr_o(addr),
        .data_o(data_out)
    );

endmodule