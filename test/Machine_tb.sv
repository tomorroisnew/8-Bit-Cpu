module Machine_tb();

    logic clk, reset, tx, rx, led1, led2, led3, led4;

    Machine computer(
        .clk(clk), .reset(reset), .tx(tx), .rx(rx), .led1(led1), .led2(led2), .led3(led3), .led4(led4)
    );

    initial begin
        $dumpfile(".\\test\\vcd\\Machine.vcd");
        $dumpvars(0, Machine_tb);
        #15 clk = 0; reset = 0;  rx = 0;
        #15 clk = 0; reset = 0;
        #15 clk = 1; reset = 1;
        #15 clk = 0; reset = 0;
        #15 clk = 1; #15 clk = 0; #15 clk = 1; #15 clk = 0;
        #15 clk = 1; #15 clk = 0; #15 clk = 1; #15 clk = 0; 
        #15 clk = 1; #15 clk = 0; #15 clk = 1; #15 clk = 0; 
        #15 clk = 1; #15 clk = 0; #15 clk = 1; #15 clk = 0; 
        #15 clk = 1; #15 clk = 0; #15 clk = 1; #15 clk = 0; 
        #15 clk = 1; #15 clk = 0; #15 clk = 1; #15 clk = 0; 
        #15 clk = 1; #15 clk = 0; #15 clk = 1; #15 clk = 0; 
        #15 clk = 1; #15 clk = 0; #15 clk = 1; #15 clk = 0; 
        #15 clk = 1; #15 clk = 0; #15 clk = 1; #15 clk = 0; 
        #15 clk = 1; #15 clk = 0; #15 clk = 1; #15 clk = 0; 
        #15 clk = 1; #15 clk = 0; #15 clk = 1; #15 clk = 0; 
        #15 clk = 1; #15 clk = 0; #15 clk = 1; #15 clk = 0; 
        #15 clk = 1; #15 clk = 0; #15 clk = 1; #15 clk = 0; 
        #15 clk = 1; #15 clk = 0; #15 clk = 1; #15 clk = 0; 
        #15 clk = 1; #15 clk = 0; #15 clk = 1; #15 clk = 0; 
        #15 clk = 1; #15 clk = 0; #15 clk = 1; #15 clk = 0; 
        #15 clk = 1; #15 clk = 0; #15 clk = 1; #15 clk = 0; 
        #15 clk = 1; #15 clk = 0; #15 clk = 1; #15 clk = 0; 
        #15 clk = 1; #15 clk = 0; #15 clk = 1; #15 clk = 0; 
        #15 clk = 1; #15 clk = 0; #15 clk = 1; #15 clk = 0; 
        #15 clk = 1; #15 clk = 0; #15 clk = 1; #15 clk = 0; 
        #15 clk = 1; #15 clk = 0; #15 clk = 1; #15 clk = 0; 
        #15 clk = 1; #15 clk = 0; #15 clk = 1; #15 clk = 0; 
        #15 clk = 1; #15 clk = 0; #15 clk = 1; #15 clk = 0; 
                #15 clk = 1; #15 clk = 0; #15 clk = 1; #15 clk = 0;
        #15 clk = 1; #15 clk = 0; #15 clk = 1; #15 clk = 0; 
        #15 clk = 1; #15 clk = 0; #15 clk = 1; #15 clk = 0; 
        #15 clk = 1; #15 clk = 0; #15 clk = 1; #15 clk = 0; 
        #15 clk = 1; #15 clk = 0; #15 clk = 1; #15 clk = 0; 
        #15 clk = 1; #15 clk = 0; #15 clk = 1; #15 clk = 0; 
        #15 clk = 1; #15 clk = 0; #15 clk = 1; #15 clk = 0; 
        #15 clk = 1; #15 clk = 0; #15 clk = 1; #15 clk = 0; 
        #15 clk = 1; #15 clk = 0; #15 clk = 1; #15 clk = 0; 
        #15 clk = 1; #15 clk = 0; #15 clk = 1; #15 clk = 0; 
        #15 clk = 1; #15 clk = 0; #15 clk = 1; #15 clk = 0; 
        #15 clk = 1; #15 clk = 0; #15 clk = 1; #15 clk = 0; 
        #15 clk = 1; #15 clk = 0; #15 clk = 1; #15 clk = 0; 
        #15 clk = 1; #15 clk = 0; #15 clk = 1; #15 clk = 0; 
        #15 clk = 1; #15 clk = 0; #15 clk = 1; #15 clk = 0; 
        #15 clk = 1; #15 clk = 0; #15 clk = 1; #15 clk = 0; 
        #15 clk = 1; #15 clk = 0; #15 clk = 1; #15 clk = 0; 
        #15 clk = 1; #15 clk = 0; #15 clk = 1; #15 clk = 0; 
        #15 clk = 1; #15 clk = 0; #15 clk = 1; #15 clk = 0; 
        #15 clk = 1; #15 clk = 0; #15 clk = 1; #15 clk = 0; 
        #15 clk = 1; #15 clk = 0; #15 clk = 1; #15 clk = 0; 
        #15 clk = 1; #15 clk = 0; #15 clk = 1; #15 clk = 0; 
        #15 clk = 1; #15 clk = 0; #15 clk = 1; #15 clk = 0; 
        #15 clk = 1; #15 clk = 0; #15 clk = 1; #15 clk = 0; 
        #15 clk = 1; reset = 1; #15 clk = 0; reset = 0; #15 clk = 1; #15 clk = 0;
        #15 clk = 1; #15 clk = 0; #15 clk = 1; #15 clk = 0; 
        #15 clk = 1; #15 clk = 0; #15 clk = 1; #15 clk = 0; 
        #15 clk = 1; #15 clk = 0; #15 clk = 1; #15 clk = 0; 
        #15 clk = 1; #15 clk = 0; #15 clk = 1; #15 clk = 0; 
        #15 clk = 1; #15 clk = 0; #15 clk = 1; #15 clk = 0; 
        #15 clk = 1; #15 clk = 0; #15 clk = 1; #15 clk = 0; 
        #15 clk = 1; #15 clk = 0; #15 clk = 1; #15 clk = 0; 
        #15 clk = 1; #15 clk = 0; #15 clk = 1; #15 clk = 0; 
        #15 clk = 1; #15 clk = 0; #15 clk = 1; #15 clk = 0; 
        #15 clk = 1; #15 clk = 0; #15 clk = 1; #15 clk = 0; 
        #15 clk = 1; #15 clk = 0; #15 clk = 1; #15 clk = 0; 
        #15 clk = 1; #15 clk = 0; #15 clk = 1; #15 clk = 0; 
        #15 clk = 1; #15 clk = 0; #15 clk = 1; #15 clk = 0; 
        #15 clk = 1; #15 clk = 0; #15 clk = 1; #15 clk = 0; 
        #15 clk = 1; #15 clk = 0; #15 clk = 1; #15 clk = 0; 
        #15 clk = 1; #15 clk = 0; #15 clk = 1; #15 clk = 0; 
        #15 clk = 1; #15 clk = 0; #15 clk = 1; #15 clk = 0; 
        #15 clk = 1; #15 clk = 0; #15 clk = 1; #15 clk = 0; 
        #15 clk = 1; #15 clk = 0; #15 clk = 1; #15 clk = 0; 
        #15 clk = 1; #15 clk = 0; #15 clk = 1; #15 clk = 0; 
        #15 clk = 1; #15 clk = 0; #15 clk = 1; #15 clk = 0; 
        #15 clk = 1; #15 clk = 0; #15 clk = 1; #15 clk = 0; 
        #15 clk = 1; #15 clk = 0; #15 clk = 1; #15 clk = 0; 
    end

    initial
        $monitor("clk: %b", clk);
endmodule