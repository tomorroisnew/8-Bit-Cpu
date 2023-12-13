module Memory_Controller(
    input logic writeEnable,
    input logic [7:0] Address,
    output logic memReadEnable, memWriteEnable, //Signals
    output logic Io1ReadEnable, Io1WriteEnable, Io2WriteEnable, Io2ReadEnable,
    output logic [1:0] regSelect
);

    //input logic io1Enable;

    always_comb begin
        case (Address)
            8'b11111011: begin //251, led
                regSelect = 2'b00;
                Io2ReadEnable = 1'b1;
                Io2WriteEnable = writeEnable;

                Io1ReadEnable = 1'b0;
                Io1WriteEnable = 1'b0;
                memReadEnable = 1'b0;
                memWriteEnable = 1'b0;
            end

            8'b11111100: begin //252, DataOutBuffer
                regSelect = 2'b00;
                Io1ReadEnable = 1'b1;
                Io1WriteEnable = writeEnable;

                memReadEnable = 1'b0;
                memWriteEnable = 1'b0;
                Io2ReadEnable = 1'b0;
                Io2WriteEnable = 1'b0;
            end
            8'b11111101: begin // 253 DataInBuffer
                regSelect = 2'b01;
                Io1ReadEnable = 1'b1;
                Io1WriteEnable = writeEnable;

                memReadEnable = 1'b0;
                memWriteEnable = 1'b0;
                Io2ReadEnable = 1'b0;
                Io2WriteEnable = 1'b0;
            end 

            8'b11111110: begin // 254 // uart control
                regSelect = 2'b10;
                Io1ReadEnable = 1'b1;
                Io1WriteEnable = writeEnable;

                memReadEnable = 1'b0;
                memWriteEnable = 1'b0;
                Io2ReadEnable = 1'b0;
                Io2WriteEnable = 1'b0;
            end 

            8'b11111111: begin // 255 //uart status
                regSelect = 2'b11;
                Io1ReadEnable = 1'b1;
                Io1WriteEnable = writeEnable;

                memReadEnable = 1'b0;
                memWriteEnable = 1'b0;
                Io2ReadEnable = 1'b0;
                Io2WriteEnable = 1'b0;
            end 

            default: begin
                memReadEnable = 1'b1;
                memWriteEnable = writeEnable;
                regSelect = 2'b00;

                Io1ReadEnable = 1'b0;
                Io1WriteEnable = 1'b0;
                Io2ReadEnable = 1'b0;
                Io2WriteEnable = 1'b0;
            end
        endcase
    end
endmodule