module CPU_tb();

    logic clk, reset;
    logic [7:0] PCdebug, RADebug;

    CPU cpu(
        .clk(clk), .reset(reset)
    );

    initial begin
        $dumpfile(".\\test\\vcd\\CPU.vcd");
        $dumpvars(0, cpu);
        //$dumpvars(1, cpu.dp.memory.memory[0]);

        #15 clk = 0; reset = 0;
        #15 clk = 1; reset = 1;
        #15 clk = 0; reset = 0;
        #15 clk = 1; #15 clk = 0; 
        #15 clk = 1; #15 clk = 0; 
        #15 clk = 1; #15 clk = 0; 
        #15 clk = 1; #15 clk = 0; 
        #15 clk = 1; #15 clk = 0; 
        #15 clk = 1; #15 clk = 0; 
        #15 clk = 1; #15 clk = 0; 
        #15 clk = 1; #15 clk = 0; 
        #15 clk = 1; #15 clk = 0; 
        #15 clk = 1; #15 clk = 0; 
        #15 clk = 1; #15 clk = 0; 
        #15 clk = 1; #15 clk = 0; 
        #15 clk = 1; #15 clk = 0; 
        #15 clk = 1; #15 clk = 0; 
        #15 clk = 1; #15 clk = 0; 
        #15 clk = 1; #15 clk = 0; 
        #15 clk = 1; #15 clk = 0; 
        #15 clk = 1; #15 clk = 0; 
        #15 clk = 1; #15 clk = 0; 
        #15 clk = 1; #15 clk = 0; 
        #15 clk = 1; #15 clk = 0; 
        #15 clk = 1; #15 clk = 0; 
        #15 clk = 1; #15 clk = 0; 
        #15 clk = 1; #15 clk = 0; 
    end

    initial
        $monitor("clk: %b, PCdebug: %b, RADebug:%s", clk, PCdebug, RADebug);
endmodule