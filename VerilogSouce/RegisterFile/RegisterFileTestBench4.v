module RegisterFileTestBench4;

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
	#1 RESET = 0 ; #1 Pcin = 0 ; #1 in =0 ; #1 LOADPC = 0 ; #1 LOAD = 0 ; #1 IR_CU = 1 ; #1 RSLCT[3:0] = 0 /* Rn */ ; #1 RSLCT[7:4] = 0 /* Rm */; #1 RSLCT[11:8] = 0 /* Rs */; #1 RSLCT[15:12] = 0 /* Rd */; #1 RSLCT[19:16] = 0 /* Rn */ ;
	//Clk 0 (Falling Edge) 
	#2 Pcin = 1; #2 in = 0 ; #2 LOADPC = 1 ; #2 LOAD = 0 ; #2 IR_CU = 1 ; #2 RSLCT[3:0] = 0 /* Rn */ ; #2 RSLCT[7:4] = 0 /* Rm */; #2 RSLCT[11:8] = 0 /* Rs */; #2 RSLCT[15:12] = 0 /* Rd */; #2 RSLCT[19:16] = 0 /* Rn */ ;
	//Clk 1 (Rising Edge) 
	#3 Pcin = 1 ; #3 in =0 ; #3 LOADPC = 1 ; #3 LOAD = 0 ; #3 IR_CU = 1 ; #3 RSLCT[3:0] = 0 /* Rn */ ; #3 RSLCT[7:4] = 0 /* Rm */; #3 RSLCT[11:8] = 0 /* Rs */; #3 RSLCT[15:12] = 0 /* Rd */; #3 RSLCT[19:16] = 0 /* Rn */ ;
	//Clk 0 (Falling Edge) 
	#4 Pcin = 1; #4 in = 0 ; #4 LOADPC = 1 ; #4 LOAD = 0 ; #4 IR_CU = 1 ; #4 RSLCT[3:0] = 0 /* Rn */ ; #4 RSLCT[7:4] = 0 /* Rm */; #4 RSLCT[11:8] = 0 /* Rs */; #4 RSLCT[15:12] = 0 /* Rd */; #4 RSLCT[19:16] = 0 /* Rn */ ;
	//Clk 1 (Rising Edge) 
	#5 Pcin = in ; #5 in =1 ; #5 LOADPC = 0 ; #5 LOAD = 0 ; #5 IR_CU = 1 ; #5 RSLCT[3:0] = 0 /* Rn */ ; #5 RSLCT[7:4] = 0 /* Rm */; #5 RSLCT[11:8] = 0 /* Rs */; #5 RSLCT[15:12] = 0 /* Rd */; #5 RSLCT[19:16] = 0 /* Rn */ ;
	//Clk 0 (Falling Edge) 
	#6 Pcin = in; #6 in = 1 ; #6 LOADPC = 1 ; #6 LOAD = 0 ; #6 IR_CU = 1 ; #6 RSLCT[3:0] = 0 /* Rn */ ; #6 RSLCT[7:4] = 0 /* Rm */; #6 RSLCT[11:8] = 0 /* Rs */; #6 RSLCT[15:12] = 0 /* Rd */; #6 RSLCT[19:16] = 0 /* Rn */ ;
	//Clk 1 (Rising Edge) 
	#7 Pcin = in ; #7 in =1 ; #7 LOADPC = 1 ; #7 LOAD = 0 ; #7 IR_CU = 1 ; #7 RSLCT[3:0] = 0 /* Rn */ ; #7 RSLCT[7:4] = 0 /* Rm */; #7 RSLCT[11:8] = 0 /* Rs */; #7 RSLCT[15:12] = 0 /* Rd */; #7 RSLCT[19:16] = 0 /* Rn */ ;
	//Clk 0 (Falling Edge) 
	#8 Pcin = in; #8 in = 1 ; #8 LOADPC = 1 ; #8 LOAD = 0 ; #8 IR_CU = 1 ; #8 RSLCT[3:0] = 0 /* Rn */ ; #8 RSLCT[7:4] = 0 /* Rm */; #8 RSLCT[11:8] = 0 /* Rs */; #8 RSLCT[15:12] = 0 /* Rd */; #8 RSLCT[19:16] = 0 /* Rn */ ;
	//Clk 1 (Rising Edge) 
	#9 Pcin = in ; #9 in =2 ; #9 LOADPC = 0 ; #9 LOAD = 0 ; #9 IR_CU = 1 ; #9 RSLCT[3:0] = 0 /* Rn */ ; #9 RSLCT[7:4] = 0 /* Rm */; #9 RSLCT[11:8] = 0 /* Rs */; #9 RSLCT[15:12] = 0 /* Rd */; #9 RSLCT[19:16] = 0 /* Rn */ ;
	//Clk 0 (Falling Edge) 
	#10 Pcin = in; #10 in = 2 ; #10 LOADPC = 0 ; #10 LOAD = 1 ; #10 IR_CU = 1 ; #10 RSLCT[3:0] = 0 /* Rn */ ; #10 RSLCT[7:4] = 0 /* Rm */; #10 RSLCT[11:8] = 0 /* Rs */; #10 RSLCT[15:12] = 0 /* Rd */; #10 RSLCT[19:16] = 0 /* Rn */ ;
	//Clk 1 (Rising Edge) 
	#11 Pcin = in ; #11 in =2 ; #11 LOADPC = 0 ; #11 LOAD = 1 ; #11 IR_CU = 1 ; #11 RSLCT[3:0] = 0 /* Rn */ ; #11 RSLCT[7:4] = 0 /* Rm */; #11 RSLCT[11:8] = 0 /* Rs */; #11 RSLCT[15:12] = 0 /* Rd */; #11 RSLCT[19:16] = 0 /* Rn */ ;
	//Clk 0 (Falling Edge) 
	#12 Pcin = in; #12 in = 2 ; #12 LOADPC = 0 ; #12 LOAD = 1 ; #12 IR_CU = 1 ; #12 RSLCT[3:0] = 0 /* Rn */ ; #12 RSLCT[7:4] = 0 /* Rm */; #12 RSLCT[11:8] = 0 /* Rs */; #12 RSLCT[15:12] = 0 /* Rd */; #12 RSLCT[19:16] = 0 /* Rn */ ;
join

always 
	#1 Clk = ~Clk;
	
initial #sim_time $finish; 

initial begin
	$dumpfile("RegisterFileTestBench4.vcd");
	$dumpvars(0,RegisterFileTestBench4);
	$display(" Test Results" );
	$monitor("time = %3d ,Pcin = %3d , in = %3d , LOADPC = %3d , LOAD = %3d , IR_CU = %3d , RSLCT = %3d , Rn = %3d ,Rm = %3d ,Rs = %3d ,PCout = %3d",$time,Pcin, in, LOADPC, LOAD, IR_CU, RSLCT,Rn,Rm,Rs,PCout);
end

endmodule
//iverilog Buffer32_32.v Decoder4x16.v Multiplexer2x1_32b.v Register.v RegisterFile.v RegisterFileTestBench4.v