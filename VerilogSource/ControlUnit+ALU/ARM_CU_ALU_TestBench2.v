module ARM_CU_ALU_TestBench2;

parameter sim_time = 750*2; // Num of Cycles * 2 
wire IR_CU,  RFLOAD,  PCLOAD,  SRLOAD,  SRENABLED,  ALUSTORE,  MFA,  WORD_BYTE, READ_WRITE, IRLOAD, MBRLOAD, MBRSTORE, MARLOAD;
wire [4:0] opcode; 
wire [3:0] CU; 
reg [31:0] IR;
reg [3:0] SR;
reg MFC , Reset , Clk ;
//ControlUnit (output reg IR_CU, RFLOAD, PCLOAD, SRLOAD, SRENABLED, ALUSTORE, MFA, WORD_BYTE,READ_WRITE,IRLOAD,MBRLOAD,MBRSTORE,MARLOAD,output reg[4:0] opcode, output[3:0] CU,  input MFC, Reset,Clk);
ControlUnit cu(IR_CU,  RFLOAD,  PCLOAD,  SRLOAD,  SRENABLED,  ALUSTORE,  MFA,  WORD_BYTE, READ_WRITE, IRLOAD, MBRLOAD, MBRSTORE, MARLOAD,opcode,CU,MFC,Reset,Clk,IR,SR);

always@(IR or CU)
begin
	RSLCT = {CU,IR[15:8],IR[3:1], IR[19:16]};
end

reg [19:0] RSLCT;
wire [31:0] Rn,Rm,Rs,PCout,Out;
//RegisterFile(input [31:0] in,Pcin,input [19:0] RSLCT,input Clk, RESET, LOADPC, LOAD,IR_CU, output [31:0] Rn,Rm,Rs,PCout);
RegisterFile RF(Out,Out,RSLCT,Clk, Reset, PCLOAD, RFLOAD,IR_CU, Rn,Rm,Rs,PCout);

reg S;
wire [3:0] FLAGS_OUT;
//ARM_ALU(input wire [31:0] A,B,input wire[4:0] OP,input wire [3:0] FLAGS,output wire [31:0] Out,output wire [3:0] FLAGS_OUT, input wire S,ALU_OUT,);
ARM_ALU alu(Rn,Rm, opcode, SR, Out,FLAGS_OUT,S,ALUSTORE);

initial fork
	MFC = 0; Reset=1 ; Clk=0 ; SR =0; IR = 0 ;
	#1 MFC = 1;#1 Reset=0 ;#1  #1 SR=FLAGS_OUT;#1 S=1; ; #1 IR[19:16] = 0 /* Rn */ ; #1 IR[3:0] = 0 /* Rm */; #1 IR[11:8] = 0 /* Rs */; #1 IR[15:12] = 0 /* Rd */;
join
	
	
always 
	#1 Clk = ~Clk;
	
initial #sim_time $finish; 

initial begin
	$dumpfile("ARM_CU_ALU_TestBench2.vcd");
	$dumpvars(0,ARM_CU_ALU_TestBench2);
	$display(" Test Results" );
	$monitor("Rn=%4h,Rm=%4h,opcode=%3d,Out=%3h,FLAGS_OUT=%3d,SR=%3d,S=%3d,ALUSTORE=%3d",Rn,Rm,opcode,Out,FLAGS_OUT,SR,S,ALUSTORE);
end

endmodule
//iverilog ARM_ALU.v controlunit2.v Buffer32_32.v Decoder4x16.v Multiplexer2x1_32b.v Register.v RegisterFile.v ARM_CU_ALU_TestBench2.v