module ARM_CU_ALU;

wire IR_CU,  RFLOAD,  PCLOAD,  SRLOAD,  SRENABLED,  ALUSTORE,  MFA,  WORD_BYTE, READ_WRITE, IRLOAD, MBRLOAD, MBRSTORE, MARLOAD;
wire [4:0] opcode; 
wire [3:0] CU; 
reg [31:0] IR;
reg [3:0] SR;
reg MFC , Reset , Clk ;
//ControlUnit (output reg IR_CU, RFLOAD, PCLOAD, SRLOAD, SRENABLED, ALUSTORE, MFA, WORD_BYTE,READ_WRITE,IRLOAD,MBRLOAD,MBRSTORE,MARLOAD,output reg[4:0] opcode, output[3:0] CU,  input MFC, Reset,Clk);
ControlUnit cu(IR_CU,  RFLOAD,  PCLOAD,  SRLOAD,  SRENABLED,  ALUSTORE,  MFA,  WORD_BYTE, READ_WRITE, IRLOAD, MBRLOAD, MBRSTORE, MARLOAD,opcode,CU,MFC,Reset,Clk,IR,SR);

always@(IR)
begin
	RSLCT = {IR[15:8],IR[3:1], IR[19:16]};
end

reg [19:0] RSLCT;
wire [31:0] Rn,Rm,Rs,PCout,Out;
//RegisterFile(input [31:0] in,Pcin,input [19:0] RSLCT,input Clk, RESET, LOADPC, LOAD,IR_CU, output [31:0] Rn,Rm,Rs,PCout);
RegisterFile RF(Out,Out,RSLCT,Clk, Reset, PCLOAD, RFLOAD,IR_CU, Rn,Rm,Rs,PCout);

reg S;
wire [3:0] FLAGS_OUT;
//ARM_ALU(input wire [31:0] A,B,input wire[4:0] OP,input wire [3:0] FLAGS,output wire [31:0] Out,output wire [3:0] FLAGS_OUT, input wire S,ALU_OUT,);
ARM_ALU alu(Rn,Rm, opcode, SR, Out,FLAGS_OUT,S,ALUSTORE);
endmodule