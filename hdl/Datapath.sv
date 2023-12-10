module Datapath(
    input logic clk, reset, 
    // Signals from the Control Unit
    input logic PC_Enable, RA_Enable, Reg_const4, RegWrite_Enable, Reg_Imm, MemWrite_Enable,
    input logic [1:0] PC_RA_ALU_REG, Alu_Move_Mem, Reg_4_PC,
    input logic [2:0] ALUOP,
    //Signals to Control Unit
    output logic zero_flag,
    output logic [3:0] opCode,

    //Signals to memory Controller
    input logic [7:0] ReadData,
    output logic [7:0] Address, WriteData
);
    //Wire to the input of PC
    logic [7:0] toPC;
    //Value of PC register
    logic [7:0] PCval, RAval;
    logic [7:0] instruction; // Instruction from Instruction Memory

    logic [1:0] toRd1, toRd2; // Wire connecting to rd1 and rd2 of Register File
    logic [3:0] imm;
    logic [7:0] toWriteData;
    logic [7:0] D1, D2; // Register Data 1 and 2 from the register file
    logic [7:0] Memout; // Output of memory 

    ////////////////////////////////////////
    ////////    Fetch   ////////////////////
    ///////////////////////////////////////
    Register PC(
        .clk(clk), .reset(reset), .writeEnable(PC_Enable), .In(toPC), .Out(PCval)
    );

    logic [7:0] pc_plus_one;
    assign pc_plus_one = PCval + 1;

    Register RA(
        .clk(clk), .reset(reset), .writeEnable(RA_Enable), .In(pc_plus_one), .Out(RAval)
    );

    always_comb begin
        if (PC_RA_ALU_REG == 2'b00) begin
            toPC = pc_plus_one;
        end else if (PC_RA_ALU_REG == 2'b01) begin
            toPC = RAval;
        end else if (PC_RA_ALU_REG == 2'b10) begin
            toPC = result; // Result of alu if branch instruction
        end else if (PC_RA_ALU_REG == 2'b11) begin
            toPC = D2; // From Register if it is a jump instruction
        end else begin
            toPC = pc_plus_one;
        end
    end

    ///////////////////////////////////////
    ////////   Decode    //////////////////
    ///////////////////////////////////////
    Instruction_Memory Inst(
        .Address(PCval), .Instruction(instruction)
    );

    always_comb begin
        if (Reg_const4 == 1'b0) begin
            toRd1 = instruction[3:2];
        end else if (Reg_const4 == 1'b1) begin
            toRd1 = 2'b11;
        end else begin
            toRd1 = instruction[3:2];
        end
    end

    assign toRd2 = instruction[1:0];
    assign imm = {{4{1'b0}}, instruction[3:0]}; // Zero Extend
    assign opCode = instruction[7:4];

    Register_File RegFile(
        .clk(clk), .RegWrite_Enable(RegWrite_Enable), .reset(reset), 
        .RegisterData1(toRd1), .RegisterData2(toRd2), .WriteRegister(toRd1),
        .WriteData(toWriteData), .Data1(D1), .Data2(D2)
    );

    ///////////////////////////////////////////////////
    //////////////    Execute    //////////////////////
    ///////////////////////////////////////////////////

    // Input to alu and output
    logic [7:0] IN1, IN2, result;

    // Multiplexers for the input of alu
    always_comb begin
        if (Reg_4_PC == 2'b00) begin
            IN2 = D1;
        end else if (Reg_4_PC == 2'b01) begin
            IN2 = 8'b00000100; //4
        end else if (Reg_4_PC == 2'b10) begin
            IN2 = PCval;
        end else begin
            IN2 = D1; // Default to the value of Register
        end

        if (Reg_Imm == 1'b0) begin
            IN1 = D2;
        end else if (Reg_Imm == 1'b1) begin
            IN1 = imm;
        end else begin
            IN1 = D2;
        end
    end

    ALU alu(
        .input1(IN1), .input2(IN2), .op(ALUOP), .result(result), .zero(zero_flag)
    );

    //////////////////////////////////////////////////
    //////////////   Memory    ///////////////////////
    //////////////////////////////////////////////////
    //Data_Memory memory(
    //    .clk(clk), .writeEnable(MemWrite_Enable), .reset(reset),
    //    .Address(D2), .WriteData(D1), .Data(Memout)
    //);
    // Send the address and data to the address bus and data bus
    assign Memout = ReadData;
    assign Address = D2;
    assign WriteData = D1;


    //////////////////////////////////////////////////
    //////////////  WriteBack    /////////////////////
    //////////////////////////////////////////////////
    //Multiplexer For toWriteData
    always_comb begin
        if(Alu_Move_Mem == 2'b00) begin
            toWriteData = result;
        end else if (Alu_Move_Mem == 2'b01) begin
            toWriteData = D2;
        end else if (Alu_Move_Mem == 2'b10) begin
            toWriteData = Memout;
        end else begin
            toWriteData = result;
        end
    end

endmodule