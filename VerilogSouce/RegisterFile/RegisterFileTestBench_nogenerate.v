module RegisterFileTestBench_nogenerate;

parameter sim_time = 750*2; // Num of Cycles * 2 

reg [31:0] Rd,Mem,Pcin;
reg [19:0] RSLCT;
reg Clk, RESET, LOADPC, LOAD,IR_CU;
wire [31:0] Rn,Rm,Rs,PCout;
RegisterFile_nogenerate RF(Rd,Mem,Pcin,RSLCT,Clk, RESET, LOADPC, LOAD,IR_CU, Rn,Rm,Rs,PCout);

initial fork
	//Clk 0 
	Clk = 0 ; RESET = 0 ; Pcin = 32'bz ; Rd = 32'bz ; Mem = 32'bz ; LOADPC = 0 ; LOAD = 0 ; IR_CU = 0 ; RSLCT = 0 ;
	//Clk 1 (Rising Edge) 
	#1 Pcin = 32'bz ; #1 Rd = 1 ; #1 Mem = 32'bz ; #1 LOADPC = 0 ; #1 LOAD = 1 ; #1 IR_CU = 0 ; #1 RSLCT = 0 ;
	//Clk 0 (Falling Edge)
	#2 Pcin = 32'bz ; #2 Rd = 1 ; #2 Mem = 32'bz ; #2 LOADPC = 0 ; #2 LOAD = 1 ; #2 IR_CU = 0 ; #2 RSLCT = 0 ;
	//Clk 1 (Rising Edge)
	#3 Pcin = 32'bz ; #3 Rd = 1 ; #3 Mem = 32'bz ; #3 LOADPC = 0 ; #3 LOAD = 1 ; #3 IR_CU = 0 ; #3 RSLCT = 2 ;
	//Clk 0 (Falling Edge)
	#4 Pcin = 32'bz ; #4 Rd = 1 ; #4 Mem = 32'bz ; #4 LOADPC = 0 ; #4 LOAD = 1 ; #4 IR_CU = 0 ; #4 RSLCT = 2 ;
	//Clk 1 (Rising Edge)
	#5 Pcin = 32'bz ; #5 Rd = 1 ; #5 Mem = 32'bz ; #5 LOADPC = 0 ; #5 LOAD = 1 ; #5 IR_CU = 0 ; #5 RSLCT = 2 ;
	//Clk 0 (Falling Edge)
	#6 Pcin = 32'bz ; #6 Rd = 1 ; #6 Mem = 32'bz ; #6 LOADPC = 0 ; #6 LOAD = 1 ; #6 IR_CU = 0 ; #6 RSLCT = 2 ;
join

always 
	#1 Clk = ~Clk;
	
initial #sim_time $finish; 

initial begin
	$dumpfile("RegisterFileTestBench_nogenerate.vcd");
	$dumpvars(0,RegisterFileTestBench_nogenerate);
	$display(" Test Results" );
	$monitor("time = %3d ,Pcin = %3d , Rd = %3d , Mem = %3d , LOADPC = %3d , LOAD = %3d , IR_CU = %3d , RSLCT = %3d , Rn = %3d ,Rm = %3d ,Rs = %3d ,PCout = %3d",$time,Pcin, Rd, Mem, LOADPC, LOAD, IR_CU, RSLCT,Rn,Rm,Rs,PCout);
end

endmodule
//iverilog Buffer32_32.v Decoder4x16.v Multiplexer2x1_32b.v Register.v RegisterFile_nogenerate.v RegisterFileTestBench_nogenerate.v