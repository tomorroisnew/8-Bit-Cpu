iverilog -g 2012 -s %1_tb -o .\test\vvp\%1 .\test\%1_tb.sv .\hdl\%1.sv .\hdl\Datapath.sv .\hdl\CPU.sv .\hdl\Control_Unit.sv .\hdl\ALU.sv .\hdl\Data_Memory.sv .\hdl\Instruction_Memory.sv .\hdl\Register.sv .\hdl\Register_File.sv .\hdl\Memory_Controller.sv .\hdl\Memory.sv .\hdl\Uart.sv
REM iverilog -g 2012 -s %1_tb -o .\test\vvp\%1 .\test\%1_tb.sv .\hdl\%1.sv 
vvp .\test\vvp\%1