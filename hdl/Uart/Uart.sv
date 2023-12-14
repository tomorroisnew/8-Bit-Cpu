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
    parameter DIVISOR = 53; // Adjust for your system clock and baud rate

    // UART control signals
    logic [DATA_BITS-1:0] data = 8'b01001000; // ASCII 'h'
    logic [7:0] control;
    logic [7:0] status = 8'b00000000;
    logic [7:0] busyReg = 8'b00000000;
    logic [2:0] data_index = 0;
    logic [6:0] baud_counter = 0;
    logic baud_clk = 0;
    logic busy, previousBusy;

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
            status <= 8'b00000000;
        end else if (writeEnable) begin
            case (regSelect)
                2'b00 : data <= writeData;
                2'b10 : begin
                    busyReg <= 8'b00000001;
                    control <= writeData;
                end
            endcase
        end else if (control[0] && busy) begin
            control <= 8'b00000000;
        end else begin
            previousBusy <= busy;
            if(previousBusy && !busy) begin
                busyReg <= 8'b00000000;
            end
        end
    end

    Uart_Transmitter transmitter(
        .baud_clk(baud_clk), .reset(reset), .Data(data), .start(control[0]), .tx(tx), .busy(busy)
    );

    //assign status[0] = busy;

    always_comb begin
        case (regSelect)
                2'b00: Data = data; //DataOutBuffer
                2'b01: Data = data;//DataInBuffer Not Implemented Yet. Use data for now
                2'b10: Data = control;
                2'b11: Data = busyReg;
                default: begin
                    Data = busyReg;
                end
            endcase
    end

endmodule
