module Control_Unit_tb();

    logic [3:0] opCode;
    logic zero_flag;
    //Outputs
    logic PC_Enable, RA_Enable, Reg_const4, RegWrite_Enable, Reg_Imm, MemWrite_Enable;
    logic [1:0] PC_RA_ALU_REG, Alu_Move_Mem, Reg_4_PC;
    logic [2:0] ALUOP;

    Control_Unit Control_Unit_dut(
        .opCode(opCode), .zero_flag(zero_flag),
        .PC_Enable(PC_Enable), .RA_Enable(RA_Enable), .Reg_const4(Reg_const4),
        .RegWrite_Enable(RegWrite_Enable), .Reg_Imm(Reg_Imm), .MemWrite_Enable(MemWrite_Enable),
        .PC_RA_ALU_REG(PC_RA_ALU_REG), .Alu_Move_Mem(Alu_Move_Mem), .Reg_4_PC(Reg_4_PC), .ALUOP(ALUOP)
    );

    reg [3:0] value;
    initial begin
        $dumpfile(".\\test\\vcd\\ALU.vcd");
        $dumpvars(0, Control_Unit_tb);

        zero_flag = 1'b1;
        opCode = 4'b0000;
        #15 opCode = 4'b0000;
        #15 opCode = 4'b0001;
        #15 opCode = 4'b0010;
        #15 opCode = 4'b0011;
        #15 opCode = 4'b0100;
        #15 opCode = 4'b0101;
        #15 opCode = 4'b0110;
        #15 opCode = 4'b0111;
        #15 opCode = 4'b1000;
        #15 opCode = 4'b1001;
        #15 opCode = 4'b1010;
        #15 opCode = 4'b1011;
        #15 opCode = 4'b1100;
        #15 opCode = 4'b1101;
        #15 opCode = 4'b1110;
        #15 opCode = 4'b1111;
    end

    initial
        $monitor("opCode: %b, MemWrite_Enable: %b", opCode, MemWrite_Enable);

endmodule