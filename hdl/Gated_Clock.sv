module Gated_Clock(
    input logic clk, start, reset,
    output logic gatedclock
);
    logic started = 0;
    always_ff @(posedge clk, posedge reset) begin
        if(reset) begin
            started <= 0;
        end else if(start) begin
            started <= 1;
        end
    end

    assign gatedclock = started & clk;
endmodule