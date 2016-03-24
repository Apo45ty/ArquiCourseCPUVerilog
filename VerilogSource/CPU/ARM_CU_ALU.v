module ARM_CU_ALU( input MFC , Reset , Clk , MEMSTORE,MEMLOAD, input [31:0] MEMDAT, output [7:0] MEMADD, output MFA,READ_WRITE,WORD_BYTE);

wire[31:0] IR;
wire IR_CU,  RFLOAD,  PCLOAD,  SRLOAD,  SRENABLED,  ALUSTORE,  MFA,  WORD_BYTE, READ_WRITE, IRLOAD, MBRLOAD, MBRSTORE, MARLOAD;
wire [4:0] opcode; 
wire [3:0] CU; 
reg [19:0] RSLCT;
wire [31:0] Rn,Rm,Rs,PCout,Out;
wire [3:0] SRIN, _SRIN,SROUT;
wire SR29_OUT;
wire[31:0] _B;

//ControlUnit (output reg IR_CU, RFLOAD, PCLOAD, SRLOAD, SRENABLED, ALUSTORE, MFA, WORD_BYTE,READ_WRITE,IRLOAD,MBRLOAD,MBRSTORE,MARLOAD,output reg[4:0] opcode, output[3:0] CU,  input MFC, Reset,Clk);
ControlUnit cu(IR_CU,  RFLOAD,  PCLOAD,  SRLOAD,  SRENABLED,  ALUSTORE,  MFA,  WORD_BYTE, READ_WRITE, IRLOAD, MBRLOAD, MBRSTORE, MARLOAD,opcode,CU,MFC,Reset,Clk,IR,SROUT);

always@(IR or CU)
begin
	RSLCT = {CU,IR[15:8],IR[3:0], IR[19:16]};
end

//RegisterFile(input [31:0] in,Pcin,input [19:0] RSLCT,input Clk, RESET, LOADPC, LOAD,IR_CU, output [31:0] Rn,Rm,Rs,PCout);
RegisterFile RF(Out,Out,RSLCT,Clk, Reset, PCLOAD, RFLOAD,IR_CU, Rn,Rm,Rs,PCout);

assign _SRIN = {SROUT[3],SR29_OUT,SROUT[1],SROUT[0]};
//ARM_ALU(input wire [31:0] A,B,input wire[4:0] OP,input wire [3:0] FLAGS,output wire [31:0] Out,output wire [3:0] FLAGS_OUT, input wire S,ALU_OUT,);
ARM_ALU alu(Rn,_B, opcode, _SRIN, Out,SRIN,IR[20],ALUSTORE);


//BarrelShifter(input [31] Rs,Rm,IR,input SR29_IN,output SR29_OUT,output [31:0] Out);
BarrelShifter bs(Rs,Rm,IR,SROUT[3],SR29_OUT,_B);

//IR
//module Register(input [31:0] IN,input Clk, Reset,Load,output [31:0] OUT);
Register IRR( .IN(Out),
			  .Clk(Clk),
			  .Reset(Reset),
			  .Load(IRLOAD),
			  .OUT(IR));
//MBR
//Register2Buff(inout [31:0] IN,IN2,input Clk, Reset,Load,Load2,Store,Store2);
Register2Buff register(
			  .IN(Out),
			  .IN2(MEMDAT),
			  .Clk(Clk), 
			  .Reset(Reset),
			  .Load(MBRLOAD),
			  .Load2(MEMLOAD),
			  .Store(MBRSTORE),
			  .Store2(MEMSTORE));

//MAR
//module Register(input [31:0] IN,input Clk, Reset,Load,output [31:0] OUT);
Register MAR( .IN(Out),
			  .Clk(Clk),
			  .Reset(Reset),
			  .Load(MARLOAD),
			  .OUT(MEMADD));
//SR
//module Register(input [31:0] IN,input Clk, Reset,Load,output [31:0] OUT);
Register SR( .IN(SRIN),
			  .Clk(Clk),
			  .Reset(Reset),
			  .Load(1),
			  .OUT(SROUT));			  

			  
endmodule
//iverilog ARM_ALU.v BarrelShifter.v Buffer32_32.v controlunit2.v  Decoder4x16.v Multiplexer2x1_32b.v Register.v Register2.v RegisterFile.v Register2Buff.v ARM_CU_ALU.v