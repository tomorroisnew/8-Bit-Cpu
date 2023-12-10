module ALU(
    input logic [7:0] input1, input2,
    input logic [2:0] op,
    output logic [7:0] result,
    output logic zero
    );

    always_comb begin
        case (op)
            3'b000: begin
                result = 8'b00000000;
            end

            //Addition
            3'b001: begin 
                result = input1 + input2;
            end

            //Shift Right
            3'b010: begin
                result = input1 << input2;
            end

            //Nand
            3'b011: begin
                result = ~(input1 & input2);
            end

            //And
            3'b100: begin
                result = input1 & input2;
            end

            //Or
            3'b101: begin
                result = input1 | input2;
            end

            3'b110: begin
                result = input1 ^ input2;
            end

            //Default similar to op 000
            default: begin
                result = 8'b00000000;
            end
        endcase
        
        //Set the zero flag if the result is zero
        if(result == 8'b00000000) begin
            zero = 1;
        end else begin
            zero = 0;
        end
    end

endmodule