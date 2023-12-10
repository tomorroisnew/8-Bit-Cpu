module Register(
    input logic clk, reset, writeEnable, 
    input logic [7:0] In,
    output logic [7:0] Out
);
    logic [7:0] Data;

    always_comb begin
        Out = Data;
    end

    always_ff @(posedge clk, posedge reset) begin
        if(reset) begin
            Data <= 8'b00000000;
        end else if(writeEnable) begin
            Data <= In;
        end
    end
endmodule