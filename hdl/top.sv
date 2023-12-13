module top(
    input logic reset, rx, start, //clk,
    output logic tx, led1, led2, led3, led4
);

    logic clk;
    SB_HFOSC clkclk(
        .CLKHFEN(1'b1),
        .CLKHFPU(1'b1),
        .CLKHF(clk)
    );
    defparam clkclk.CLKHF_DIV = "0b11";

    logic gated;
    Gated_Clock gatedclk(
        .clk(clk), .start(start), .reset(reset), .gatedclock(gated)
    );

    Machine computer(
        .reset(reset), .clk(gated), .tx(tx), .rx(tx), .led1(led1), .led2(led2), .led3(led3), .led4(led4)
    );
endmodule