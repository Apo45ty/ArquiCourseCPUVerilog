module RegisterFileTestBench2;

parameter sim_time = 750*2; // Num of Cycles * 2 

reg [31:0] in,Pcin;
reg [19:0] RSLCT;
reg Clk, RESET, LOADPC, LOAD,IR_CU;
wire [31:0] Rn,Rm,Rs,PCout;
//RegisterFile(input [31:0] in,Pcin,input [19:0] RSLCT,input Clk, RESET, LOADPC, LOAD,IR_CU, output [31:0] Rn,Rm,Rs,PCout);
RegisterFile RF(in,Pcin,RSLCT,Clk, RESET, LOADPC, LOAD,IR_CU, Rn,Rm,Rs,PCout);

initial fork
	//Clk 0 
	Clk = 0 ; RESET = 1 ; Pcin = 32'bz ; in = 32'bz ; LOADPC = 0 ; LOAD = 0 ;IR_CU = 1 ; RSLCT[3:0] = 0 ; RSLCT[7:4] = 0 ; RSLCT[11:8] = 0 ; RSLCT[15:12] = 0 ; RSLCT[19:16] = 0 ;
	//Clk 1 (Rising Edge) 
	#1 RESET = 0 ; #1 Pcin = 32'bz ; #1 in = 1 ; #1 LOADPC = 0 ; #1 LOAD = 1 ; #1 IR_CU = 1 ; #1 RSLCT[3:0] = 0 ; #1 RSLCT[7:4] = 0 ; #1 RSLCT[11:8] = 0 ; #1 RSLCT[15:12] = 0 ; #1 RSLCT[19:16] = 0 ;
	//Clk 0 (Falling Edge)
	#2 Pcin = 32'bz ; #2 in = 1 ; #2 LOADPC = 0 ; #2 LOAD = 1 ; #2 IR_CU = 1 ; #2 RSLCT[3:0] = 0 ; #2 RSLCT[7:4] = 0 ; #2 RSLCT[11:8] = 0 ; #2 RSLCT[15:12] = 0 ; #2 RSLCT[19:16] = 0 ;
	//Clk 1 (Rising Edge)
	#3 Pcin = 32'bz ; #3 in =  Rn ; #3 LOADPC = 0 ; #3 LOAD = 1 ; #3 IR_CU = 1 ; #3 RSLCT[3:0] = 0 ; #3 RSLCT[7:4] = 0 ; #3 RSLCT[11:8] = 0 ; #3 RSLCT[15:12] = 1 ; #3 RSLCT[19:16] = 0 ;
	//Clk 0 (Falling Edge)
	#4 Pcin = 32'bz ; #4 in = Rn ; #4 LOADPC = 0 ; #4 LOAD = 1 ; #4 IR_CU = 1 ; #4 RSLCT[3:0] = 0 ; #4 RSLCT[7:4] = 0 ; #4 RSLCT[11:8] = 0 ; #4 RSLCT[15:12] = 1 ; #4 RSLCT[19:16] = 0 ;
	//Clk 1 (Rising Edge)
	#5 Pcin = 32'bz ; #5 in =  Rn ; #5 LOADPC = 0 ; #5 LOAD = 1 ; #5 IR_CU = 1 ; #5 RSLCT[3:0] = 0 ; #5 RSLCT[7:4] = 0 ; #5 RSLCT[11:8] = 0 ; #5 RSLCT[15:12] = 2 ; #5 RSLCT[19:16] = 0 ;
	//Clk 0 (Falling Edge)
	#6 Pcin = 32'bz ; #6 in =  Rn ; #6 LOADPC = 0 ; #6 LOAD = 1 ; #6 IR_CU = 1 ; #6 RSLCT[3:0] = 0 ; #6 RSLCT[7:4] = 0 ; #6 RSLCT[11:8] = 0 ; #6 RSLCT[15:12] = 2 ; #6 RSLCT[19:16] = 0 ;
join

always 
	#1 Clk = ~Clk;
	
initial #sim_time $finish; 

initial begin
	$dumpfile("RegisterFileTestBench2.vcd");
	$dumpvars(0,RegisterFileTestBench2);
	$display(" Test Results" );
	$monitor("time = %3d ,Pcin = %3d , in = %3d , LOADPC = %3d , LOAD = %3d , IR_CU = %3d , RSLCT = %3d , Rn = %3d ,Rm = %3d ,Rs = %3d ,PCout = %3d",$time,Pcin, in, LOADPC, LOAD, IR_CU, RSLCT,Rn,Rm,Rs,PCout);
end

endmodule
//iverilog Buffer32_32.v Decoder4x16.v Multiplexer2x1_32b.v Register.v RegisterFile.v RegisterFileTestBench2.v