module Register_File(
    input logic clk, RegWrite_Enable, reset,
    input logic [1:0] RegisterData1, RegisterData2, WriteRegister,
    input logic [7:0] WriteData,
    output logic [7:0] Data1, Data2,
    output logic [31:0] DebugOut
);

    logic [7:0] registers [3:0];

    always_comb begin
        Data1 = registers[RegisterData1];
        Data2 = registers[RegisterData2];
    end

    integer i;
    always_ff @( posedge clk, posedge reset) begin
        if(reset) begin
            for (i = 0; i < 4 ; i = i + 1) begin
                registers[i] <= 8'b00000000;
            end
        end else if(RegWrite_Enable) begin
            registers[WriteRegister] <= WriteData;
        end
    end
    
    assign DebugOut = {registers[0], registers[1], registers[2], registers[3]};

endmodule