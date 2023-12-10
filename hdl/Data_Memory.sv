module Data_Memory(
    input logic clk, writeEnable, readEnable, reset,
    input logic [7:0] Address, WriteData,
    output logic [7:0] Data
);
    logic [7:0] memory [255:0];

    integer i;
    always_ff @(posedge clk, posedge reset) begin
        if(reset) begin
            for (i = 0; i < 256; i = i + 1 ) begin
                memory[i] <= 8'b00000000;
            end
        end else if(writeEnable) begin
            memory[Address] <= WriteData;
        end
    end

    always_comb begin
        if(readEnable == 1'b1) begin
            Data = memory[Address];
        end else begin
            Data = 8'bz;
        end
    end
endmodule