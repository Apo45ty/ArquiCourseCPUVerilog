module prefab_alu_rf_bs;

parameter sim_time = 750*2; // Num of Cycles * 2 

reg [31:0] Pcin;
reg [19:0] RSLCT;
reg Clk, RESET, LOADPC, LOAD,IR_CU;
wire [31:0] Rn,Rm,Rs,PCout,in;
//RegisterFile(input [31:0] in,Pcin,input [19:0] RSLCT,input Clk, RESET, LOADPC, LOAD,IR_CU, output [31:0] Rn,Rm,Rs,PCout);
RegisterFile RF(in,Pcin,RSLCT,Clk, RESET, LOADPC, LOAD,IR_CU, Rn,Rm,Rs,PCout);

reg [31:0] IR;
wire SR29_OUT;
wire [31:0] Out;
wire [3:0] FLAGS;
wire [3:0] FLAGS_OUT;

//BarrelShifter(input [31:0] Rs,Rm,IR,input SR29_IN,output SR29_OUT,output [31:0] Out);
BarrelShifter bs(Rs,Rm,IR,FLAGS[1],FLAGS_OUT[1], Out);

//reg  [31:0] A,B; //Rn Rm
reg [4:0] OP;
reg S,ALU_OUT;

//ARM_ALU(input wire [31:0] A,B,input wire[4:0] OP,input wire [3:0] FLAGS,output wire [31:0] Out,output wire [3:0] FLAGS_OUT, input wire S,ALU_OUT,);
ARM_ALU alu(Rn,Out, OP, FLAGS_OUT, in,FLAGS,S,ALU_OUT);



initial fork
	//Clk 0 
	Clk = 0 ; RESET = 1 ; Pcin = 32'bz ;  LOADPC = 0 ; LOAD = 0 ;IR_CU = 1 ; RSLCT[3:0] = 0 ; RSLCT[7:4] = 0 ; RSLCT[11:8] = 0 ; RSLCT[15:12] = 0 ; RSLCT[19:16] = 0 ; OP=17;  S=1;ALU_OUT=1;
	//Clk 1 (Rising Edge) Send CU signals
	#1 IR=0;#1 IR[4]=1;#1 RESET = 0 ;#1 Pcin = 32'bz ; #1 LOADPC = 0 ; #1 LOAD = 1 ; #1 IR_CU = 1 ; #1 RSLCT[3:0] = 0 /* Rn */ ; #1 RSLCT[7:4] = 0 /* Rm */; #1 RSLCT[11:8] = 0 /* Rs */; #1 RSLCT[15:12] = 0 /* Rd */; #1 RSLCT[19:16] = 0 /* Rn */ ; #1 OP=17;#1 S=1;#1 ALU_OUT=1;
	//Clk 0 (Falling Edge)
	#2 IR=0;#2 IR[4]=1;#2 Pcin = 32'bz ; #2 LOADPC = 0 ; #2 LOAD = 1 ; #2 IR_CU = 1 ; #2 RSLCT[3:0] = 0 /* Rn */ ; #2 RSLCT[7:4] = 0 /* Rm */; #2 RSLCT[11:8] = 0 /* Rs */; #2 RSLCT[15:12] = 0 /* Rd */; #2 RSLCT[19:16] = 0 /* Rn */ ; #2 OP=17;#2 S=1; #2 ALU_OUT=1;
	//Clk 1 (Rising Edge)Send CU signals
	#3 IR=0;#3 IR[4]=1;#3 Pcin = 32'bz ; #3 LOADPC = 0 ; #3 LOAD = 1 ; #3 IR_CU = 1 ; #3 RSLCT[3:0] = 0 /* Rn */ ; #3 RSLCT[7:4] = 0 /* Rm */; #3 RSLCT[11:8] = 0 /* Rs */; #3 RSLCT[15:12] = 1 /* Rd */; #3 RSLCT[19:16] = 0 /* Rn */ ; #3 OP=17;#3 S=1; #3 ALU_OUT=1;
	//Clk 0 (Falling Edge)
	#4 IR=0;#4 IR[4]=1;#4 Pcin = 32'bz ; #4 LOADPC = 0 ; #4 LOAD = 1 ; #4 IR_CU = 1 ; #4 RSLCT[3:0] = 0 /* Rn */ ; #4 RSLCT[7:4] = 0 /* Rm */; #4 RSLCT[11:8] = 0 /* Rs */; #4 RSLCT[15:12] = 1 /* Rd */; #4 RSLCT[19:16] = 0 /* Rn */ ; #4 OP=4;#4 S=1; #4 ALU_OUT=1;
	//Clk 1 (Rising Edge)Send CU signals
	#5 IR=0;#5 IR[4]=1;#5 Pcin = 32'bz ; #5 LOADPC = 0 ; #5 LOAD = 1 ; #5 IR_CU = 1 ; #5 RSLCT[3:0] = 0 /* Rn */ ; #5 RSLCT[7:4] = 0 /* Rm */; #5 RSLCT[11:8] = 0 /* Rs */; #5 RSLCT[15:12] = 2 /* Rd */; #5 RSLCT[19:16] = 0 /* Rn */ ; #5 OP=4;#5 S=1; #5 ALU_OUT=1;
	//Clk 0 (Falling Edge)Store Data
	#6 IR=0;#6 IR[4]=1;#6 Pcin = 32'bz ; #6 LOADPC = 0 ; #6 LOAD = 1 ; #6 IR_CU = 1 ; #6 RSLCT[3:0] = 1 /* Rn */ ; #6 RSLCT[7:4] = 0 /* Rm */; #6 RSLCT[11:8] = 0 /* Rs */; #6 RSLCT[15:12] = 2 /* Rd */; #6 RSLCT[19:16] = 0 /* Rn */ ; #6 OP=4;#6 S=1; #6 ALU_OUT=1;
join

always 
	#1 Clk = ~Clk;
	
initial #sim_time $finish; 

initial begin
	$dumpfile("prefab_alu_rf_bs.vcd");
	$dumpvars(0,prefab_alu_rf_bs);
	$display(" Test Results" );
	$monitor("time = %3d ,Pcin = %3d , in = %3d , LOADPC = %3d , LOAD = %3d , IR_CU = %3d , RSLCT = %3h, Rn = %3d ,Rm = %3d ,Rs = %3d ,PCout = %3d,OP=%3d;FLAGS=0; S=%1b;ALU_OUT=%1b;",$time,Pcin, in, LOADPC, LOAD, IR_CU, RSLCT,Rn,Rm,Rs,PCout,OP,FLAGS,S,ALU_OUT);
end

endmodule
//iverilog Buffer32_32.v Decoder4x16.v Multiplexer2x1_32b.v Register.v RegisterFile.v ARM_ALU.v BarrelShifter.v prefab_alu_rf_bs.v