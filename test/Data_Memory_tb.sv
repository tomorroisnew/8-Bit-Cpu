module Data_Memory_tb();

    logic clk, writeEnable, reset;
    logic [7:0] Address, WriteData;
    logic [7:0] Data;

    Data_Memory dut(
        .clk(clk), .writeEnable(writeEnable), .reset(reset),
        .Address(Address), .WriteData(WriteData), .Data(Data)
    );

    initial begin
        # 15 clk = 0; reset = 0;
        # 15 clk = 1; reset = 1;
        # 15 clk = 0; reset = 0;
        # 15 clk = 1; Address = 8'b00000001;
        # 15 clk = 0; Address = 8'b00000010;
        # 15 clk = 1; Address = 8'b00000010; WriteData = 8'b00011111; writeEnable = 1;
        # 15 clk = 0; Address = 8'b00000010; writeEnable = 0;
    end

    initial
        $monitor("Address: %b, Data: %b", Address, Data);

endmodule