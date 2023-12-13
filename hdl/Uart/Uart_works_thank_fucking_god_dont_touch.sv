module Uart(
    input logic reset, writeEnable, readEnable, rx, clk,
    //Pins 
    input logic [7:0] writeData,
    input logic [1:0] regSelect, 
    output logic tx,
    output logic [7:0] Data
);
        // UART configuration parameters
    parameter DATA_BITS = 8;
    parameter STOP_BITS = 1;
    parameter DIVISOR = 104; // Adjust for your system clock and baud rate

    // UART control signals
    logic [DATA_BITS-1:0] data = 8'b01001000; // ASCII 'h'
    logic [2:0] data_index = 0;
    logic [6:0] baud_counter = 0;
    logic baud_clk = 0;

    // State machine states
    parameter s_IDLE = 2'b00, s_START = 2'b01, s_DATA = 2'b10, s_STOP = 2'b11;
    logic [1:0] state = s_IDLE;

    // Baud rate generation
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            baud_counter <= 0;
            baud_clk <= 0;
        end else if (baud_counter == (DIVISOR/2) - 1) begin
            baud_clk <= ~baud_clk;
            baud_counter <= 0;
        end else begin
            baud_counter <= baud_counter + 1;
        end
    end

    // UART state machine
    always_ff @(posedge baud_clk or posedge reset) begin
        if (reset) begin
            state <= s_IDLE;
            data_index <= 0;
            tx <= 1'b1; // Idle state is high
        end else begin
            case (state)
                s_IDLE : begin
                    // Transmit condition (can be replaced with an actual condition)
                        state <= s_START;
                end
                s_START: begin
                    tx <= 1'b0; // Start bit
                    state <= s_DATA;
                end
                s_DATA : begin
                    tx <= data[data_index];
                    if (data_index == DATA_BITS - 1) begin
                        state <= s_STOP;
                        data_index <= 0;
                    end else begin
                        data_index <= data_index + 1;
                    end
                end
                s_STOP : begin
                    tx <= 1'b1; // Stop bit
                    state <= s_IDLE;
                end
            endcase
        end
    end

endmodule
