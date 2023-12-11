module Baud_Rate_Generator(
    input logic clk, reset,
    output logic baudclk
);

parameter DIVISOR = 2;
reg [8:0] counter;

always_ff @( posedge clk, posedge reset ) begin
    if(reset) begin
        counter <= 0;
        baudclk <= 0;
    end else begin
        if(counter == (DIVISOR - 1)) begin
            counter <= 0;
            baudclk <= ~baudclk;
        end else begin
            counter <= counter + 1;
        end
    end
end

endmodule