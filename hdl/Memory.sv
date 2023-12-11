module Memory(
    input logic clk, writeEnable, reset,
    input logic [7:0] Address, WriteData,
    output logic [7:0] Data,

    //Pins
    input logic rx,
    output logic tx, led1, led2, led3, led4
);
    logic [1:0] regSelect; // To slect which register of the io device. Each io device can have up to 4
    //Flags for different devices
    logic DataMemoryReadEnable, DataMemoryWriteEnable;
    logic Io1ReadEnable, Io1WriteEnable;
    logic Io2ReadEnable, Io2WriteEnable; // Simple Led

    logic [7:0] uart1Data, ramData;


    //Generate the signals needed for io mapping
    Memory_Controller controller(
        .writeEnable(writeEnable), .Address(Address), 
        .memReadEnable(DataMemoryReadEnable), .memWriteEnable(DataMemoryWriteEnable),
        .Io1ReadEnable(Io1ReadEnable), .Io1WriteEnable(Io1WriteEnable), .regSelect(regSelect),
        .Io2ReadEnable(Io2ReadEnable), .Io2WriteEnable(Io2WriteEnable)
    );

    //Memory
    Data_Memory ram(
        .clk(clk), .writeEnable(DataMemoryWriteEnable), .readEnable(DataMemoryReadEnable),
        .reset(reset), .Address(Address), .WriteData(WriteData), .Data(ramData)
    );

    //Uart
    Uart uart1(
        .reset(reset), .writeEnable(Io1WriteEnable), .readEnable(Io1ReadEnable), .rx(rx), 
        .Data(uart1Data), .writeData(WriteData), .regSelect(regSelect), .tx(tx), .clk(clk)
    );

    Led led(
        .clk(clk), .reset(reset), .writeEnable(Io2WriteEnable), .readEnable(Io2ReadEnable), .writeData(WriteData),
        .led1(led1), .led2(led2), .led3(led3), .led4(led4)
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