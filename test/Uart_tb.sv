module Uart_tb();

    logic clk, reset, writeEnable, readEnable, rx;
    logic [7:0] Data, writeData;
    logic [1:0] regselect;
    logic tx;

    Uart uart(
        .clk(clk), .reset(reset), .writeEnable(writeEnable), .readEnable(readEnable), .rx(rx),
        .Data(Data), .writeData(writeData), .regSelect(regselect), .tx(tx)
    );

    initial begin
        $dumpfile(".\\test\\vcd\\Uart.vcd");
        $dumpvars(0, Uart_tb);

        #15 clk = 0; reset = 0;
        #15 clk = 1; reset = 1;
        #15 clk = 0; reset = 0;
        #15 clk = 1; #15 clk = 0; writeEnable = 1; writeData = 8'b10101010; regselect = 2'b00;
        #15 clk = 1; #15 clk = 0; writeEnable = 1; writeData = 8'b00000001; regselect = 2'b10;
        #15 clk = 1; #15 clk = 0; writeEnable = 0;
        #15 clk = 1; #15 clk = 0; 
        #15 clk = 1; #15 clk = 0; 
        #15 clk = 1; #15 clk = 0; 
        #15 clk = 1; #15 clk = 0; 
        #15 clk = 1; #15 clk = 0; 
        #15 clk = 1; #15 clk = 0; 
        #15 clk = 1; #15 clk = 0; 
        #15 clk = 1; #15 clk = 0; 
        #15 clk = 1; #15 clk = 0; 
        #15 clk = 1; #15 clk = 0; 
        #15 clk = 1; #15 clk = 0; 
        #15 clk = 1; #15 clk = 0; 
        #15 clk = 1; #15 clk = 0; 
        #15 clk = 1; #15 clk = 0; 
        #15 clk = 1; #15 clk = 0; 
        #15 clk = 1; #15 clk = 0; 
        #15 clk = 1; #15 clk = 0; 
        #15 clk = 1; #15 clk = 0; 
        #15 clk = 1; #15 clk = 0; 
        #15 clk = 1; #15 clk = 0; 
        #15 clk = 1; #15 clk = 0; 

    end

    initial
        $monitor("clk: %b", clk);
endmodule