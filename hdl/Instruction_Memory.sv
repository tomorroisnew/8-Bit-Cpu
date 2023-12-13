module Instruction_Memory(
    input logic [7:0] Address,
    output logic [7:0] Instruction
);

    logic [7:0] memory [0:255];

    initial begin
        $readmemh("Y:/design/8-Bit-Cpu/simulation/out.txt", memory);
        for (int i = 0; i < 256; i++) begin
            //$display("Memory[%0d] = %b", i, memory[i]);
        end
    end

    always_comb begin
        Instruction = memory[Address];
    end
endmodule