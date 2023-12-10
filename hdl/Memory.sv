module Memory(
    input logic clk, writeEnable, reset,
    input logic [7:0] Address, WriteData,
    output logic [7:0] Data,

    //Pins
    input logic rx,
    output logic tx
);
    logic [1:0] regSelect; // To slect which register of the io device. Each io device can have up to 4
    //Flags for different devices
    logic DataMemoryReadEnable, DataMemoryWriteEnable;
    logic Io1ReadEnable, Io1WriteEnable;

    logic [7:0] uart1Data, ramData;

    //Generate the signals needed for io mapping
    Memory_Controller controller(
        .writeEnable(writeEnable), .Address(Address), 
        .memReadEnable(DataMemoryReadEnable), .memWriteEnable(DataMemoryWriteEnable),
        .Io1ReadEnable(Io1ReadEnable), .Io1WriteEnable(Io1WriteEnable), .regSelect(regSelect)
    );

    //Memory
    Data_Memory ram(
        .clk(clk), .writeEnable(DataMemoryWriteEnable), .readEnable(DataMemoryReadEnable),
        .reset(reset), .Address(Address), .WriteData(WriteData), .Data(ramData)
    );

    //Uart
    Uart uart1(
        .clk(clk), .reset(reset), .writeEnable(Io1WriteEnable), .readEnable(Io1ReadEnable), .rx(rx), 
        .Data(uart1Data), .writeData(WriteData), .regSelect(regSelect), .tx(tx)
    );

    always_comb begin
        if(DataMemoryReadEnable) begin
            Data = ramData;
        end else if(Io1ReadEnable) begin
            Data = uart1Data;
        end else begin
            Data = ramData;
        end
    end
endmodule