module ALU_tb();
    logic [7:0] input1, input2;
    logic [7:0] result;
    logic [2:0] op;
    logic zero_flag;
    
    initial begin
        $dumpfile("ALU.vcd");
        $dumpvars(0,ALU_tb);
        # 15 input1 = 8'b00000000; input2 = 8'b00000001; op = 8'b001;
        # 15 input1 = 8'b00000001; input2 = 8'b00000001; op = 8'b001;
        # 15 input1 = 8'b00001011; input2 = 8'b00000100; op = 8'b010;
        # 15 input1 = 8'b10110000; input2 = 8'b00001011; op = 8'b110;
    end

    ALU dut(
        .input1(input1),
        .input2(input2),
        .op(op),
        .result(result),
        .zero(zero_flag)
    );

    initial
        $monitor("input1: %b, input2: %b, op: %b, result: %b, zf: %b", input1, input2, op, result, zero_flag);
endmodule