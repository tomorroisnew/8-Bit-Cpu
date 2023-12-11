module Led(
    input logic reset, writeEnable, readEnable, clk,
    //Pins 
    input logic [7:0] writeData,
    output logic led1, led2, led3, led4
);

    logic [7:0] register;

    always_ff @(posedge clk, posedge reset) begin
        if(reset) begin
            register <= 8'b11111111;
        end else if (writeEnable) begin
            register <= writeData;
        end
    end

    assign led1 = register[0];
    assign led2 = register[1];
    assign led3 = register[2];
    assign led4 = register[4];

endmodule