module Machine(
    input logic clk, reset,
    //Pins
    output logic tx,
    input logic rx
);

    logic [7:0] ReadDataBus, WriteDataBus, AddressBus;
    logic writeEnable; 

    // Main Cpu
    CPU cpu(
        .clk(clk), .reset(reset), .ReadDataBus(ReadDataBus), .WriteDataBus(WriteDataBus), .AddressBus(AddressBus),
        .MemwriteEnable(writeEnable)
    );

    //Memory
    Memory mem(
        .clk(clk), .writeEnable(writeEnable), .reset(reset), .Address(AddressBus), .WriteData(WriteDataBus), .Data(ReadDataBus),
        .tx(tx), .rx(rx)
    );

endmodule