module Uart_Transmitter(
    input logic baud_clk, reset,
    input logic [7:0] Data,
    input logic start,
    output logic tx,
    output logic busy
);
    parameter DATA_BITS = 8;

    logic [2:0] data_index = 0;
    // State machine states
    parameter s_IDLE = 2'b00, s_START = 2'b01, s_DATA = 2'b10, s_STOP = 2'b11;
    logic [1:0] state = s_IDLE;

    always_ff @(posedge baud_clk or posedge reset) begin
        if (reset) begin
            state <= s_IDLE;
            data_index <= 0;
            tx <= 1'b1; // Idle state is high
            busy <= 0;
        end else begin
            case (state)
                s_IDLE : begin
                    if(start) begin
                        state <= s_START;
                    end
                    tx <= 1'b1;
                    busy <= 0;
                end
                s_START: begin
                    tx <= 1'b0; // Start bit
                    state <= s_DATA;
                    busy <= 1;
                end
                s_DATA : begin
                    tx <= Data[data_index];
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
                default:  state <= s_IDLE;
            endcase
        end
    end
endmodule