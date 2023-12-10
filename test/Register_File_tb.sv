module Register_File_tb();

    logic clk, RegWrite_Enable, reset;
    logic [1:0] RegisterData1, RegisterData2, WriteRegister;
    logic [7:0] WriteData;
    logic [7:0] Data1, Data2;


    initial begin
        $dumpfile(".\\test\\vcd\\Register_File.vcd");
        $dumpvars(0, Register_File_tb);

        #15 reset = 0; #15 reset = 1;
        #15 clk = 0;
        #15 clk = 1; RegisterData1 = 2'b01; RegisterData2 = 2'b11; WriteData = 8'b00000000; WriteRegister = 2'b00; RegWrite_Enable = 0;
        #15 clk = 0;
        #15 clk = 1; RegisterData1 = 2'b01; RegisterData2 = 2'b11; WriteData = 8'b00000001; WriteRegister = 2'b00; RegWrite_Enable = 1;
        #15 clk = 0;
        #15 clk = 1; RegisterData1 = 2'b00; RegisterData2 = 2'b11; WriteData = 8'b00000000; WriteRegister = 2'b00; RegWrite_Enable = 0;
        
    end

    Register_File dut(
        .clk(clk), .RegWrite_Enable(RegWrite_Enable), .reset(reset), .RegisterData1(RegisterData1),
        .RegisterData2(RegisterData2), .WriteRegister(WriteRegister), .WriteData(WriteData),
        .Data1(Data1), .Data2(Data2)
    );

    initial
        $monitor("RegisterData1: %b, RegisterData2: %b, Data1: %b, Data2: %b, clk: %b", RegisterData1, RegisterData2, Data1, Data2, clk);

endmodule