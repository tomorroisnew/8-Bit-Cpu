module CPU(
    input logic clk, reset, 
    input logic [7:0] ReadDataBus,
    output logic [7:0] WriteDataBus,
    output logic [7:0] AddressBus,
    output logic MemwriteEnable
);
    // From Datapath
    logic zero_flag;
    logic [3:0] opCode;

    //From Control Unit
    logic PC_Enable, RA_Enable, Reg_const4, RegWrite_Enable, Reg_Imm, MemWrite_Enable, Unsigned_Signed;
    logic [1:0] PC_RA_ALU_REG, Alu_Move_Mem, Reg_4_PC;
    logic [2:0] ALUOP;

    Control_Unit ctrl(
        .opCode(opCode), .zero_flag(zero_flag), //Inputs
        .PC_Enable(PC_Enable), .RA_Enable(RA_Enable), .Reg_const4(Reg_const4),
        .RegWrite_Enable(RegWrite_Enable), .Reg_Imm(Reg_Imm), .MemWrite_Enable(MemwriteEnable),
        .PC_RA_ALU_REG(PC_RA_ALU_REG), .Alu_Move_Mem(Alu_Move_Mem), .Reg_4_PC(Reg_4_PC), .ALUOP(ALUOP), .Unsigned_Signed(Unsigned_Signed)
    );

    Datapath dp(
        .clk(clk), .reset(reset), .PC_Enable(PC_Enable), .RA_Enable(RA_Enable), .Reg_const4(Reg_const4),
        .RegWrite_Enable(RegWrite_Enable), .Reg_Imm(Reg_Imm), .MemWrite_Enable(MemWrite_Enable), 
        .PC_RA_ALU_REG(PC_RA_ALU_REG), .Alu_Move_Mem(Alu_Move_Mem), .Reg_4_PC(Reg_4_PC),
        .ALUOP(ALUOP), .zero_flag(zero_flag), .opCode(opCode),
        .ReadData(ReadDataBus), .Address(AddressBus), .WriteData(WriteDataBus), .Unsigned_Signed(Unsigned_Signed)
    );

endmodule