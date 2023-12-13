module Uart(
    input logic reset, writeEnable, readEnable, rx, clk,
    //Pins 
    input logic [7:0] writeData,
    input logic [1:0] regSelect, 
    output logic tx,
    output logic [7:0] Data
);
    //logic fastclk;
    //SB_HFOSC clkclk(
    //    .CLKHFEN(1'b1),
    //    .CLKHFPU(1'b1),
    //    .CLKHF(fastclk)
    //);
    //defparam clkclk.CLKHF_DIV = "0b00";

    // UART configuration parameters
    parameter DATA_BITS = 8;
    parameter STOP_BITS = 1;
    parameter DIVISOR = 208;//417;//104;//416;//104; // Adjust for your system clock and baud rate

    // UART control signals
    logic [DATA_BITS-1:0] data = 8'b00000000; // ASCII 'h'
    logic [7:0] status;
    logic [7:0] control;
    logic [2:0] data_index = 0;
    logic [6:0] baud_counter = 0;
    logic baud_clk = 0;

    // State machine states
    parameter s_IDLE = 2'b00, s_START = 2'b01, s_DATA = 2'b10, s_STOP = 2'b11;
    logic [1:0] state = s_IDLE;

    // Hacky Stuff
    logic state_update;

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
    
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            data <= 8'b00000000;
            control <= 8'b00000000;
        end else if(writeEnable) begin
            case (regSelect)
                2'b00 :  data <= writeData;
                2'b10 : control <= writeData;
            endcase
        end else begin
            if (status[0]) begin //If transmitting set reset control to 0
                control <= 8'b00000000;
            end
        end
    end

    // UART state machine
    always_ff @(posedge baud_clk or posedge reset) begin
        if (reset) begin
            state <= s_IDLE;
            data_index <= 0;
            tx <= 1'b1; // Idle state is high
            status <= 8'b00000000;
        end else begin
            case (state)
                s_IDLE : begin
                    if (control[0] == 1'b1) begin
                        state <= s_START;
                        status[0] <= 1'b1;
                    end
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
                    status[0] <= 1'b0;
                end
            endcase
        end
    end

    always_comb begin
        case (regSelect)
            2'b00 : Data = data;
            2'b10 : Data = control;
            2'b11 : Data = status;
            default: Data = data;
        endcase
    end

endmodule
