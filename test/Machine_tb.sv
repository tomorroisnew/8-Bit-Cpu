module Machine_tb();

    logic clk, reset;

    Machine computer(
        .clk(clk), .reset(reset)
    );

    initial begin
        $dumpfile(".\\test\\vcd\\Machine.vcd");
        $dumpvars(0, computer);

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
    end

    initial
        $monitor("clk: %b", clk);
endmodule