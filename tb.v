`timescale 1ns/1ps

module tb();

reg clk = 0;
reg rst_n;
wire [7:0] leds;

always #1 clk = ~clk; // Clock generation

core_top #(
    .MEMORY_FILE("programa.txt") // Specify the memory file
) t (
    .clk(clk),
    .rst_n(rst_n)
);

integer i;
reg [7:0] counter = 0;

integer base_address = 128; // Starting address for the sequence

initial begin
    $dumpfile("saida.vcd");
    $dumpvars(0, tb);

    rst_n = 0; // Reset the system
    #5;
    rst_n = 1; // Release reset

    #500; // wait for the end of the program

    if (t.mem.memory[(base_address + 0)/4] === 0) begin
        $display("=== OK Primeiro valor da sequência é 0.");
    end else begin
        $display("=== ERRO Primeiro valor da sequência deveria ser 0. Encontrei %h", t.mem.memory[(base_address + 0)/4]);
    end

    if (t.mem.memory[(base_address + 4)/4] === 1) begin
        $display("=== OK Segundo valor da sequência é 1.");
    end else begin
        $display("=== ERRO Segundo valor da sequência deveria ser 1. Encontrei %h", t.mem.memory[(base_address + 4)/4]);
    end

    if (t.mem.memory[(base_address + 8)/4] === 1) begin
        $display("=== OK Terceiro valor da sequência é 1.");
    end else begin
        $display("=== ERRO Terceiro valor da sequência deveria ser 1. Encontrei %h", t.mem.memory[(base_address + 8)/4]);
    end

    if (t.mem.memory[(base_address + 12)/4] === 2) begin
        $display("=== OK Quarto valor da sequência é 2.");
    end else begin
        $display("=== ERRO Quarto valor da sequência deveria ser 2. Encontrei %h", t.mem.memory[(base_address + 12)/4]);
    end

    if (t.mem.memory[(base_address + 16)/4] === 3) begin
        $display("=== OK Quinto valor da sequência é 3.");
    end else begin
        $display("=== ERRO Quinto valor da sequência deveria ser 3. Encontrei %h", t.mem.memory[(base_address + 16)/4]);
    end

    $finish; // End simulation
end

endmodule
