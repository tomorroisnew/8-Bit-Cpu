module Memory_Controller(
    input logic writeEnable,
    input logic [7:0] Address,
    output logic memReadEnable, memWriteEnable //Signals
);

    always_comb begin
        case (Address)
            default: begin
                memReadEnable = 1;
                memWriteEnable = writeEnable;
            end
        endcase
    end
endmodule