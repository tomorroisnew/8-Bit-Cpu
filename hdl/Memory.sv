module Memory(
    input logic clk, writeEnable, reset,
    input logic [7:0] Address, WriteData,
    output logic [7:0] Data
);
    //Flags for different devices
    logic DataMemoryReadEnable, DataMemoryWriteEnable;

    //Generate the signals needed for io mapping
    Memory_Controller controller(
        .writeEnable(writeEnable), .Address(Address), 
        .memReadEnable(DataMemoryReadEnable), .memWriteEnable(DataMemoryWriteEnable)
    );

    //Memory
    Data_Memory ram(
        .clk(clk), .writeEnable(DataMemoryWriteEnable), .readEnable(DataMemoryReadEnable),
        .reset(reset), .Address(Address), .WriteData(WriteData), .Data(Data)
    );
endmodule