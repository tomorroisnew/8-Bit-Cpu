module Machine(
    input logic reset, clk,
    //Pins
    output logic tx, led1, led2, led3, led4,
    input logic rx
);

    //logic clk;
    //SB_LFOSC clkclk(
    //    .CLKLFEN(1'b1),
    //    .CLKLFPU(1'b1),
    //    .CLKLF(clk)
    //);

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
        .tx(tx), .rx(rx), .led1(led1), .led2(led2), .led3(led3), .led4(led4) 
    );

endmodule