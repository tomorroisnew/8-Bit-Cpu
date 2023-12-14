module Control_Unit(
    input logic [3:0] opCode,
    input logic zero_flag, 
    //Control Signals
    output logic PC_Enable, RA_Enable, Reg_const4, RegWrite_Enable, Reg_Imm, MemWrite_Enable, Unsigned_Signed,
    output logic [1:0] PC_RA_ALU_REG, Alu_Move_Mem, Reg_4_PC,
    output logic [2:0] ALUOP
);
    always_comb begin
        case (opCode)
            
            //Halt
            4'b0000: begin
                {PC_Enable, RA_Enable, Reg_const4, RegWrite_Enable, Reg_Imm,
                 MemWrite_Enable, PC_RA_ALU_REG, Alu_Move_Mem, Reg_4_PC, ALUOP} = {15{1'b0}};
                 Unsigned_Signed = 1'b0;
            end

            //lui
            4'b0001: begin
                {PC_Enable, Reg_const4, RegWrite_Enable, Reg_Imm} = {4{1'b1}};
                Reg_4_PC = 2'b01;
                ALUOP = 3'b010;
                {
                    RA_Enable, PC_RA_ALU_REG, Alu_Move_Mem, MemWrite_Enable
                } = {6{1'b0}};
                Unsigned_Signed = 1'b0;
            end

            //ori
            4'b0010: begin
                {PC_Enable, Reg_const4, RegWrite_Enable, Reg_Imm} = {4{1'b1}};
                ALUOP = 3'b101;
                {RA_Enable, PC_RA_ALU_REG, Alu_Move_Mem, Reg_4_PC, MemWrite_Enable} = {8{1'b0}};
                Unsigned_Signed = 1'b0;
            end

            //Read Mem
            4'b0011: begin
                {PC_Enable, RegWrite_Enable} = {2{1'b1}};
                Alu_Move_Mem = 2'b10;
                {RA_Enable, PC_RA_ALU_REG, Reg_const4, Reg_Imm, Reg_4_PC, ALUOP, MemWrite_Enable} = {11{1'b0}};
                Unsigned_Signed = 1'b0;
            end

            //Write Mem
            4'b0100: begin
                {PC_Enable, MemWrite_Enable} = {2{1'b1}};
                {RA_Enable, PC_RA_ALU_REG, Reg_const4, RegWrite_Enable, Alu_Move_Mem, Reg_Imm, Reg_4_PC, ALUOP} = {13{1'b0}};
                Unsigned_Signed = 1'b0;
            end

            //Move
            4'b0101: begin
                {PC_Enable, RegWrite_Enable} = {2{1'b1}};
                Alu_Move_Mem = 2'b01;
                {RA_Enable, PC_RA_ALU_REG, Reg_const4, Reg_Imm, Reg_4_PC, ALUOP, MemWrite_Enable} = {11{1'b0}};
                Unsigned_Signed = 1'b0;
            end

            //Add
            4'b0110: begin
                {PC_Enable, RegWrite_Enable} = {2{1'b1}};
                ALUOP = 3'b001;
                {RA_Enable, PC_RA_ALU_REG, Reg_const4, Alu_Move_Mem, Reg_Imm, Reg_4_PC, MemWrite_Enable} = {10{1'b0}};
                Unsigned_Signed = 1'b0;
            end

            //Nand
            4'b0111: begin
                {PC_Enable, RegWrite_Enable} = {2{1'b1}};
                ALUOP = 3'b011;
                {RA_Enable, PC_RA_ALU_REG, Reg_const4, Alu_Move_Mem, Reg_Imm, Reg_4_PC, MemWrite_Enable} = {10{1'b0}};
                Unsigned_Signed = 1'b0;
            end

            //And
            4'b1000: begin
                {PC_Enable, RegWrite_Enable} = {2{1'b1}};
                ALUOP = 3'b100;
                {RA_Enable, PC_RA_ALU_REG, Reg_const4, Alu_Move_Mem, Reg_Imm, Reg_4_PC, MemWrite_Enable} = {10{1'b0}};
                Unsigned_Signed = 1'b0;
            end

            //Or
            4'b1001: begin
                {PC_Enable, RegWrite_Enable} = {2{1'b1}};
                ALUOP = 3'b101;
                {RA_Enable, PC_RA_ALU_REG, Reg_const4, Alu_Move_Mem, Reg_Imm, Reg_4_PC, MemWrite_Enable} = {10{1'b0}};
                Unsigned_Signed = 1'b0;
            end

            //Xor
            4'b1010: begin
                {PC_Enable, RegWrite_Enable} = {2{1'b1}};
                ALUOP = 3'b110;
                {RA_Enable, PC_RA_ALU_REG, Reg_const4, Alu_Move_Mem, Reg_Imm, Reg_4_PC, MemWrite_Enable} = {10{1'b0}};
                Unsigned_Signed = 1'b0;
            end

            //Call
            4'b1011: begin
                {RA_Enable, PC_RA_ALU_REG} = {3{1'b1}};
                PC_Enable = 1'b1;
                {Reg_const4, RegWrite_Enable, Alu_Move_Mem, Reg_Imm, Reg_4_PC, ALUOP, MemWrite_Enable} = {10{1'b0}};
                Unsigned_Signed = 1'b0;
            end

            //Call if zero
            4'b1100: begin
                PC_Enable = 1'b1;
                if(zero_flag == 1'b1) begin
                    {RA_Enable, PC_RA_ALU_REG} = {3{1'b1}};
                end else begin
                    {RA_Enable, PC_RA_ALU_REG} = {3{1'b0}};
                end
                {Reg_const4, RegWrite_Enable, Alu_Move_Mem, Reg_Imm, Reg_4_PC, ALUOP, MemWrite_Enable} = {10{1'b0}};
                Unsigned_Signed = 1'b0;
            end

            //Return
            4'b1101: begin
                PC_Enable = 1'b1;
                PC_RA_ALU_REG = 2'b01;
                {RA_Enable, Reg_const4, RegWrite_Enable, Alu_Move_Mem, Reg_Imm, Reg_4_PC, ALUOP, MemWrite_Enable} = {12{1'b0}};
                Unsigned_Signed = 1'b0;
            end

            //Branch if zero unsigned
            4'b1110: begin
                {PC_Enable, Reg_Imm} = {2{1'b1}};
                if(zero_flag == 1'b1) begin
                    PC_RA_ALU_REG = 2'b10;
                end else begin
                    PC_RA_ALU_REG = 2'b0;
                end
                Reg_4_PC = 2'b10;
                ALUOP = 3'b001;
                {RA_Enable, Reg_const4, RegWrite_Enable, Alu_Move_Mem, MemWrite_Enable} = {6{1'b0}};
                Unsigned_Signed = 1'b0;
            end

            //Branch if signed
            4'b1111: begin
                {PC_Enable, Reg_Imm} = {2{1'b1}};
                if(zero_flag == 1'b1) begin
                    PC_RA_ALU_REG = 2'b10;
                end else begin
                    PC_RA_ALU_REG = 2'b0;
                end
                Reg_4_PC = 2'b10;
                ALUOP = 3'b001;
                {RA_Enable, Reg_const4, RegWrite_Enable, Alu_Move_Mem, MemWrite_Enable} = {6{1'b0}};
                Unsigned_Signed = 1'b1;
            end

            default: begin
                //Set all to zero
                PC_Enable = 1'b1;
                {RA_Enable, Reg_const4, RegWrite_Enable, Reg_Imm,
                 MemWrite_Enable, PC_RA_ALU_REG, Alu_Move_Mem, Reg_4_PC, ALUOP} = {14{1'b0}};
            end
        endcase
    end
endmodule