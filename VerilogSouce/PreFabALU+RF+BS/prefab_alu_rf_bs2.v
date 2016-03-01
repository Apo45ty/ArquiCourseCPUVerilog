module prefab_alu_rf_bs2;

parameter sim_time = 750*2; // Num of Cycles * 2 

reg [19:0] RSLCT;
reg Clk, RESET, LOADPC, LOAD,IR_CU;
wire [31:0] Rn,Rm,Rs,PCout,in;
//RegisterFile(input [31:0] in,Pcin,input [19:0] RSLCT,input Clk, RESET, LOADPC, LOAD,IR_CU, output [31:0] Rn,Rm,Rs,PCout);
RegisterFile RF(in,in,RSLCT,Clk, RESET, LOADPC, LOAD,IR_CU, Rn,Rm,Rs,PCout);

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

always@(IR)
begin
	RSLCT = {IR[15:8],IR[3:1], IR[19:16]};
end

initial fork
	//Clk 0 
	IR = 0 ; Clk = 0 ; RESET = 1 ;   LOADPC = 0 ; LOAD = 0 ;IR_CU = 1 ; RSLCT[3:0] = 0 ; RSLCT[7:4] = 0 ; RSLCT[11:8] = 0 ; RSLCT[15:12] = 0 ; RSLCT[19:16] = 0 ; OP=17;  S=1;ALU_OUT=1;
	//Clk 1 (Rising Edge) 
	#1 OP = 0  ; #1 IR[27:25] = 0/* instruction type */ ; #1 IR[11:7] = 0 /*immediate rm shift amount*/; #1 IR[6:5] = 0 /*shiftType */; #1 IR[4]=1 /*0 = imediate, 1 register*/ ; #1 IR[19:16] = 0 /* Rn */ ; #1 IR[3:0] = 0 /* Rm */; #1 IR[11:8] = 0 /* Rs */; #1 IR[15:12] = 0 /* Rd */; #1 RSLCT[19:16] = 0 /* Rn */ ;#1 RESET = 0 ; #1 LOADPC = 0 ; #1 LOAD = 0 ; #1 IR_CU = 1 ;#1 S=0;#1 ALU_OUT=0;
	//Clk 0 (Falling Edge) Send CU signals
	#2 OP = 17; #2 IR[27:25] = 0/* instruction type */ ; #2 IR[11:7] = 0 /*immediate rm shift amount*/; #2 IR[6:5] = 1 /*shiftType */; #2 IR[4]=0 /*0 = imediate, 1 register*/ ; #2 IR[19:16] = 0 /* Rn */ ; #2 IR[3:0] = 0 /* Rm */; #2 IR[11:8] = 0 /* Rs */; #2 IR[15:12] = 0 /* Rd */; #2 RSLCT[19:16] = 0 /* Rn */ ;#2 RESET = 0 ; #2 LOADPC = 0 ; #2 LOAD = 0 ; #2 IR_CU = 1 ;#2 S=1;#2 ALU_OUT=1;
	//Clk 1 (Rising Edge) 
	#3 OP = 17 ; #3 IR[27:25] = 0/* instruction type */ ; #3 IR[11:7] = 0 /*immediate rm shift amount*/; #3 IR[6:5] = 1 /*shiftType */; #3 IR[4]=0 /*0 = imediate, 1 register*/ ; #3 IR[19:16] = 0 /* Rn */ ; #3 IR[3:0] = 0 /* Rm */; #3 IR[11:8] = 0 /* Rs */; #3 IR[15:12] = 0 /* Rd */; #3 RSLCT[19:16] = 0 /* Rn */ ;#3 RESET = 0 ; #3 LOADPC = 0 ; #3 LOAD = 0 ; #3 IR_CU = 1 ;#3 S=1;#3 ALU_OUT=1;
	//Clk 0 (Falling Edge) Send CU signals
	#4 OP = 17; #4 IR[27:25] = 0/* instruction type */ ; #4 IR[11:7] = 0 /*immediate rm shift amount*/; #4 IR[6:5] = 1 /*shiftType */; #4 IR[4]=0 /*0 = imediate, 1 register*/ ; #4 IR[19:16] = 0 /* Rn */ ; #4 IR[3:0] = 0 /* Rm */; #4 IR[11:8] = 0 /* Rs */; #4 IR[15:12] = 0 /* Rd */; #4 RSLCT[19:16] = 0 /* Rn */ ;#4 RESET = 0 ; #4 LOADPC = 0 ; #4 LOAD = 1 ; #4 IR_CU = 1 ;#4 S=1;#4 ALU_OUT=1;
	//Clk 1 (Rising Edge) 
	#5 OP = 17 ; #5 IR[27:25] = 0/* instruction type */ ; #5 IR[11:7] = 0 /*immediate rm shift amount*/; #5 IR[6:5] = 1 /*shiftType */; #5 IR[4]=0 /*0 = imediate, 1 register*/ ; #5 IR[19:16] = 0 /* Rn */ ; #5 IR[3:0] = 0 /* Rm */; #5 IR[11:8] = 0 /* Rs */; #5 IR[15:12] = 0 /* Rd */; #5 RSLCT[19:16] = 0 /* Rn */ ;#5 RESET = 0 ; #5 LOADPC = 0 ; #5 LOAD = 1 ; #5 IR_CU = 1 ;#5 S=1;#5 ALU_OUT=1;
	//Clk 0 (Falling Edge) Send CU signals
	#6 OP = 0  ; #6 IR[27:25] = 0/* instruction type */ ; #6 IR[11:7] = 0 /*immediate rm shift amount*/; #6 IR[6:5] = 0 /*shiftType */; #6 IR[4]=1 /*0 = imediate, 1 register*/ ; #6 IR[19:16] = 0 /* Rn */ ; #6 IR[3:0] = 0 /* Rm */; #6 IR[11:8] = 0 /* Rs */; #6 IR[15:12] = 0 /* Rd */; #6 RSLCT[19:16] = 0 /* Rn */ ;#6 RESET = 0 ; #6 LOADPC = 0 ; #6 LOAD = 0 ; #6 IR_CU = 1 ;#6 S=0;#6 ALU_OUT=0;
	//Clk 1 (Rising Edge) 
	#7 OP = 0  ; #7 IR[27:25] = 0/* instruction type */ ; #7 IR[11:7] = 0 /*immediate rm shift amount*/; #7 IR[6:5] = 0 /*shiftType */; #7 IR[4]=1 /*0 = imediate, 1 register*/ ; #7 IR[19:16] = 0 /* Rn */ ; #7 IR[3:0] = 0 /* Rm */; #7 IR[11:8] = 0 /* Rs */; #7 IR[15:12] = 0 /* Rd */; #7 RSLCT[19:16] = 0 /* Rn */ ;#7 RESET = 0 ; #7 LOADPC = 0 ; #7 LOAD = 0 ; #7 IR_CU = 1 ;#7 S=0;#7 ALU_OUT=0;
	//Clk 0 (Falling Edge) Send CU signals
	#8 OP = 16; #8 IR[27:25] = 0/* instruction type */ ; #8 IR[11:7] = 1 /*immediate rm shift amount*/; #8 IR[6:5] = 0 /*shiftType */; #8 IR[4]=0 /*0 = imediate, 1 register*/ ; #8 IR[19:16] = 0 /* Rn */ ; #8 IR[3:0] = 0 /* Rm */; #8 IR[11:8] = 0 /* Rs */; #8 IR[15:12] = 0 /* Rd */; #8 RSLCT[19:16] = 0 /* Rn */ ;#8 RESET = 0 ; #8 LOADPC = 0 ; #8 LOAD = 0 ; #8 IR_CU = 1 ;#8 S=1;#8 ALU_OUT=1;
	//Clk 1 (Rising Edge) 
	#9 OP = 16 ; #9 IR[27:25] = 0/* instruction type */ ; #9 IR[11:7] = 1 /*immediate rm shift amount*/; #9 IR[6:5] = 0 /*shiftType */; #9 IR[4]=0 /*0 = imediate, 1 register*/ ; #9 IR[19:16] = 0 /* Rn */ ; #9 IR[3:0] = 0 /* Rm */; #9 IR[11:8] = 0 /* Rs */; #9 IR[15:12] = 0 /* Rd */; #9 RSLCT[19:16] = 0 /* Rn */ ;#9 RESET = 0 ; #9 LOADPC = 0 ; #9 LOAD = 0 ; #9 IR_CU = 1 ;#9 S=1;#9 ALU_OUT=1;
	//Clk 0 (Falling Edge) Send CU signals
	#10 OP = 16 ; #10 IR[27:25] = 0/* instruction type */ ; #10 IR[11:7] = 1 /*immediate rm shift amount*/; #10 IR[6:5] = 0 /*shiftType */; #10 IR[4]=0 /*0 = imediate, 1 register*/ ; #10 IR[19:16] = 0 /* Rn */ ; #10 IR[3:0] = 0 /* Rm */; #10 IR[11:8] = 0 /* Rs */; #10 IR[15:12] = 0 /* Rd */; #10 RSLCT[19:16] = 0 /* Rn */ ;#10 RESET = 0 ; #10 LOADPC = 0 ; #10 LOAD = 1 ; #10 IR_CU = 1 ;#10 S=1;#10 ALU_OUT=1;
//	#4 OP = 17 ; #4 IR[27:25] = 0/* instruction type */ ; #4 IR[6:5] = 0 /*shiftType */; #4 IR[4]=0 /*0 = imediate, 1 register*/ ; #4 IR[7:0] = 0 /*shiftVal*/;#4 IR[11:8] = 0/*shiftAmount*/ ; #4 IR[11:7] = 1 /*immediate rm shift amount*/;  #4 IR[19:16] = 0 /* Rn */ ; #4 IR[3:0] = 0 /* Rm */; #4 IR[11:8] = 0 /* Rs */; #4 IR[15:12] = 0 /* Rd */; #4 RSLCT[19:16] = 0 /* Rn */ ;#4 RESET = 0 ; #4 LOADPC = 0 ; #4 LOAD = 1 ; #4 IR_CU = 1 ;#4 S=1;#4 ALU_OUT=1;
join

always 
	#1 Clk = ~Clk;
	
initial #sim_time $finish; 

initial begin
	$dumpfile("prefab_alu_rf_bs2.vcd");
	$dumpvars(0,prefab_alu_rf_bs2);
	$display(" Test Results" );
	$monitor("time = %3d , in = %3d , LOADPC = %3d , LOAD = %3d , IR_CU = %3d , RSLCT = %3h, Rn = %3d ,Rm = %3d ,Rs = %3d ,PCout = %3d,OP=%3d;FLAGS=0; S=%1b;ALU_OUT=%1b;",$time, in, LOADPC, LOAD, IR_CU, RSLCT,Rn,Rm,Rs,PCout,OP,FLAGS,S,ALU_OUT);
end

endmodule
//iverilog Buffer32_32.v Decoder4x16.v Multiplexer2x1_32b.v Register.v RegisterFile.v ARM_ALU.v BarrelShifter.v prefab_alu_rf_bs2.v