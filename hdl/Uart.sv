module Uart(
    input logic reset, writeEnable, readEnable, rx, clk,
    //Pins 
    input logic [7:0] writeData,
    input logic [1:0] regSelect, 
    output logic tx,
    output logic [7:0] Data
);

    //Use the lattice builtin oscilitaor.
    //logic uartclk; 
    //SB_HFOSC osc(
    //    .CLKHFPU(1'b1),
    //    .CLKHFEN(1'b1),
    //    .CLKHF(uartclk)
    //);

    logic uartclk;
    Baud_Rate_Generator brg(
        .clk(clk), .reset(reset), .baudclk(uartclk)
    );

    //Registers
    logic [7:0] DOUT; // Data Out
    logic [7:0] DIN; //
    logic [7:0] Status; // Set lowest bit to 1 to start sending. The second bit is set when it is sending.

    // States
    parameter s_IDLE = 2'b00;
    parameter s_START = 2'b01;
    parameter s_DATA = 2'b10;
    parameter s_STOP = 2'b11;

    logic [3:0] r_Bit_Index;
    logic [1:0] state; 
    logic stop_Index;

    always_comb begin
        if(readEnable) begin
            case (regSelect)
                2'b00: begin
                    Data = DOUT;
                end
                2'b01: begin
                    Data = DIN;
                end
                2'b10: begin
                    Data = Status;
                end
                default: begin
                    Data = DOUT;
                end
            endcase
        end else begin
            Data = 8'bz;
        end
    end
    
    always_ff @(posedge clk, posedge reset) begin
        if(reset) begin
            state <= s_IDLE;
            DOUT <= 8'b00000000;
            DIN <= 8'b00000000;
            Status <= 8'b00000000;
            r_Bit_Index <= 3'b000;
        end else if (writeEnable) begin
            case (regSelect)
                2'b00: DOUT <= writeData;
                2'b01: DIN <= writeData;
                2'b10: Status <= writeData;
                default: begin
                    DOUT <= writeData;
                end
            endcase
        end
    end

    always_ff @(posedge uartclk) begin
        case (state)
            s_IDLE: begin //Idle Wait for the lowest bit of Status reg to be 1 to start sending
                if(Status[0] == 1'b1) begin
                    state <= s_START;
                end else if(Status[0] == 1'b0) begin
                    state <= s_IDLE;
                end
                //tx <= 1;
                stop_Index <= 0;
            end

            s_START: begin
                Status[1] <= 1'b1; 
                //tx <= 1'b0; //First bit, must be 0
                state <= s_DATA;
                r_Bit_Index <= 3'b000;
            end

            s_DATA: begin
                if(r_Bit_Index == 3'b111) begin
                    state <= s_STOP;
                end
                //tx <= DOUT[r_Bit_Index];
                r_Bit_Index <= r_Bit_Index + 1;
            end

            s_STOP: begin
                if(stop_Index == 1'b0) begin
                    //tx <= 1'b1;
                    stop_Index <= stop_Index + 1;
                end else if(stop_Index == 1'b1) begin // CleanUp
                    //tx <= 1'b1;
                    state <= s_IDLE;
                    r_Bit_Index <= 3'b000;
                    Status <= 8'b00000000;
                    DOUT <= 8'b00000000;
                end
            end

            default: begin
                tx <= 1;
                state <= s_IDLE;
            end
        endcase
    end

    always_comb begin
        case (state)
            s_IDLE: begin
                tx = 1'b1;
            end

            s_START: begin
                tx = 1'b0;
            end

            s_DATA: begin
                tx = DOUT[r_Bit_Index];
            end

            s_STOP: begin
                tx = 1'b1;
            end
            default: begin
                tx = 1'b1;
            end
        endcase
    end
endmodule