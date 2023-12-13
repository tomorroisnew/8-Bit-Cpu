yosys -p "read_verilog -sv .\hdl\Led.sv .\hdl\ALU.sv .\hdl\Control_Unit.sv .\hdl\CPU.sv .\hdl\Data_Memory.sv .\hdl\Datapath.sv .\hdl\Instruction_Memory.sv .\hdl\Machine.sv .\hdl\Memory_Controller.sv .\hdl\Memory.sv .\hdl\top.sv .\hdl\Register_File.sv .\hdl\Register.sv .\hdl\Gated_Clock.sv .\hdl\Uart\Uart.sv .\hdl\Uart\Uart_Transmitter.sv .\hdl\Baud_Rate_Generator.sv; synth_ice40 -top top -json .\synthesis\Machine.json"

nextpnr-ice40 --up5k --json .\synthesis\Machine.json --pcf .\hdl\Machine.pcf --asc .\synthesis\Machine.asc

icepack .\synthesis\Machine.asc .\synthesis\Machine.bin

iceprog .\synthesis\Machine.bin

python3 .\utils\uart.py