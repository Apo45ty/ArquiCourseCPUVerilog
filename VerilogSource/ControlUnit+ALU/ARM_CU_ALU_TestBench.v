module ARM_CU_ALU_TestBench;

parameter sim_time = 750*2; // Num of Cycles * 2 
wire [17:0] signals;
wire IR_CU,  RFLOAD,  PCLOAD,  SRLOAD,  SRENABLED,  ALUSTORE,  MFA,  WORD_BYTE, READ_WRITE, IRLOAD, MBRLOAD, MBRSTORE, MARLOAD;
wire [4:0] opcode; 
wire [3:0] CU; 
reg [31:0] IR;
reg [3:0] SR;
reg MFC , Reset , Clk ;
//ControlUnit (output reg IR_CU, RFLOAD, PCLOAD, SRLOAD, SRENABLED, ALUSTORE, MFA, WORD_BYTE,READ_WRITE,IRLOAD,MBRLOAD,MBRSTORE,MARLOAD,output reg[4:0] opcode, output[3:0] CU,  input MFC, Reset,Clk);
ControlUnit cu(IR_CU,  RFLOAD,  PCLOAD,  SRLOAD,  SRENABLED,  ALUSTORE,  MFA,  WORD_BYTE, READ_WRITE, IRLOAD, MBRLOAD, MBRSTORE, MARLOAD,opcode,CU,MFC,Reset,Clk,IR,SR);

reg  [31:0] A,B;
reg [3:0] FLAGS;
reg S,ALU_OUT;
wire [31:0] Out;
wire [3:0] FLAGS_OUT;
//ARM_ALU(input wire [31:0] A,B,input wire[4:0] OP,input wire [3:0] FLAGS,output wire [31:0] Out,output wire [3:0] FLAGS_OUT, input wire S,ALU_OUT,);
ARM_ALU alu(A,B, opcode, FLAGS, Out,FLAGS_OUT,S,ALUSTORE);

reg [19:0] RSLCT;
wire [31:0] Rn,Rm,Rs,PCout;
//RegisterFile(input [31:0] in,Pcin,input [19:0] RSLCT,input Clk, RESET, LOADPC, LOAD,IR_CU, output [31:0] Rn,Rm,Rs,PCout);
RegisterFile RF(Out,Out,RSLCT,Clk, Reset, PCLOAD, RFLOAD,IR_CU, Rn,Rm,Rs,PCout);

initial fork
	MFC = 0; Reset=1 ; Clk=0 ; FLAGS =0;
	#1 MFC = 1;#1 Reset=0 ;#1 A=1; #1 B=0; #1 FLAGS=FLAGS_OUT;#1 S=1; 
join
	
	
always 
	#1 Clk = ~Clk;
	
initial #sim_time $finish; 

initial begin
	$dumpfile("ARM_CU_ALU_TestBench.vcd");
	$dumpvars(0,ARM_CU_ALU_TestBench);
	$display(" Test Results" );
	$monitor("A=%4h,B=%4h,opcode=%3d,Out=%3h,FLAGS_OUT=%3d,FLAGS=%3d,S=%3d,ALUSTORE=%3d",A,B,opcode,Out,FLAGS_OUT,FLAGS,S,ALUSTORE);
end

endmodule
//iverilog ARM_ALU.v controlunit.v Buffer32_32.v Decoder4x16.v Multiplexer2x1_32b.v Register.v RegisterFile.v ARM_CU_ALU_TestBench.v