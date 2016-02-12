module RegisterFile_nogenerate(input [31:0] Rd,Mem,Pcin,input [19:0] RSLCT,input Clk, RESET, LOADPC, LOAD,IR_CU, output [31:0] Rn,Rm,Rs,PCout);

wire [31:0] in;
assign in = (Rd | Mem);
wire [31:0] Q[15:0];

//Rd
wire [15:0] DecoderRd; // signal outputs of decoder
//Decoder4x16(input [3:0] IN,output reg [15:0] OUT)
Decoder4x16 DRd(.IN(RSLCT[15:12]),.OUT(DecoderRd)); //Decoder assembly

//Rn_CU
wire [3:0] _RN_CU; 
//Multiplexer(input [31:0] IN1,IN2,input IR_CU,output [31:0] OUT);
Multiplexer mux(RSLCT[19:16],RSLCT[3:0],IR_CU,_RN_CU);
wire [15:0] DecoderRn_CU; // signal outputs of decoder
//Decoder4x16(input [3:0] IN,output reg [15:0] OUT)
Decoder4x16 DRn_CU(.IN(_RN_CU),.OUT(DecoderRn_CU));//Decoder assembly

//Rm
wire [15:0] DecoderRm; // signal outputs of decoder
//Decoder4x16(input [3:0] IN,output reg [15:0] OUT)
Decoder4x16 DRm(.IN(RSLCT[7:4]),.OUT(DecoderRm));//Decoder assembly

//Rs
wire [15:0] DecoderRs; // signal outputs of decoder
//Decoder4x16(input [3:0] IN,output reg [15:0] OUT)
Decoder4x16 DRs(.IN(RSLCT[11:8]),.OUT(DecoderRs));//Decoder assembly
 
//Register 0
//Register(input [31:0] IN,input Clk, Reset,Load,output [31:0] OUT);
Register test_reg0(.IN(in),
				  .Clk(Clk),
				  .Reset(RESET),
				  .Load(DecoderRd[0]&LOAD),
				  .OUT(Q[0]));
//Buffer32_32(input [31:0] IN,input Store,output [31:0] OUT);
Buffer32_32 bufffer0(.IN(Q[0]),.Store(DecoderRn_CU[0]),.OUT(Rn));
//Buffer32_32(input [31:0] IN,input Store,output [31:0] OUT);
Buffer32_32 bufffer02(.IN(Q[0]),.Store(DecoderRm[0]),.OUT(Rm));
//Buffer32_32(input [31:0] IN,input Store,output [31:0] OUT);
Buffer32_32 bufffer03(.IN(Q[0]),.Store(DecoderRs[0]),.OUT(Rs));

//Register 1
//Register(input [31:0] IN,input Clk, Reset,Load,output [31:0] OUT);
Register test_reg1(.IN(in),
				  .Clk(Clk),
				  .Reset(RESET),
				  .Load(DecoderRd[1]&LOAD),
				  .OUT(Q[1]));
//Buffer32_32(input [31:0] IN,input Store,output [31:0] OUT);
Buffer32_32 bufffer1(.IN(Q[1]),.Store(DecoderRn_CU[1]),.OUT(Rn));
//Buffer32_32(input [31:0] IN,input Store,output [31:0] OUT);
Buffer32_32 bufffer12(.IN(Q[1]),.Store(DecoderRm[1]),.OUT(Rm));
//Buffer32_32(input [31:0] IN,input Store,output [31:0] OUT);
Buffer32_32 bufffer13(.IN(Q[1]),.Store(DecoderRs[1]),.OUT(Rs));

//Register 2
//Register(input [31:0] IN,input Clk, Reset,Load,output [31:0] OUT);
Register test_reg2(.IN(in),
				  .Clk(Clk),
				  .Reset(RESET),
				  .Load(DecoderRd[2]&LOAD),
				  .OUT(Q[2]));
//Buffer32_32(input [31:0] IN,input Store,output [31:0] OUT);
Buffer32_32 bufffer2(.IN(Q[2]),.Store(DecoderRn_CU[2]),.OUT(Rn));
//Buffer32_32(input [31:0] IN,input Store,output [31:0] OUT);
Buffer32_32 bufffer22(.IN(Q[2]),.Store(DecoderRm[2]),.OUT(Rm));
//Buffer32_32(input [31:0] IN,input Store,output [31:0] OUT);
Buffer32_32 bufffer23(.IN(Q[2]),.Store(DecoderRs[2]),.OUT(Rs));

//Register 3
//Register(input [31:0] IN,input Clk, Reset,Load,output [31:0] OUT);
Register test_reg3(.IN(in),
				  .Clk(Clk),
				  .Reset(RESET),
				  .Load(DecoderRd[3]&LOAD),
				  .OUT(Q[3]));
//Buffer32_32(input [31:0] IN,input Store,output [31:0] OUT);
Buffer32_32 bufffer3(.IN(Q[3]),.Store(DecoderRn_CU[3]),.OUT(Rn));
//Buffer32_32(input [31:0] IN,input Store,output [31:0] OUT);
Buffer32_32 bufffer32(.IN(Q[3]),.Store(DecoderRm[3]),.OUT(Rm));
//Buffer32_32(input [31:0] IN,input Store,output [31:0] OUT);
Buffer32_32 bufffer33(.IN(Q[3]),.Store(DecoderRs[3]),.OUT(Rs));

//Register 4
//Register(input [31:0] IN,input Clk, Reset,Load,output [31:0] OUT);
Register test_reg4(.IN(in),
				  .Clk(Clk),
				  .Reset(RESET),
				  .Load(DecoderRd[4]&LOAD),
				  .OUT(Q[4]));
//Buffer32_32(input [31:0] IN,input Store,output [31:0] OUT);
Buffer32_32 bufffer4(.IN(Q[4]),.Store(DecoderRn_CU[4]),.OUT(Rn));
//Buffer32_32(input [31:0] IN,input Store,output [31:0] OUT);
Buffer32_32 bufffer42(.IN(Q[4]),.Store(DecoderRm[4]),.OUT(Rm));
//Buffer32_32(input [31:0] IN,input Store,output [31:0] OUT);
Buffer32_32 bufffer43(.IN(Q[4]),.Store(DecoderRs[4]),.OUT(Rs));

//Register 5
//Register(input [31:0] IN,input Clk, Reset,Load,output [31:0] OUT);
Register test_reg5(.IN(in),
				  .Clk(Clk),
				  .Reset(RESET),
				  .Load(DecoderRd[5]&LOAD),
				  .OUT(Q[5]));
//Buffer32_32(input [31:0] IN,input Store,output [31:0] OUT);
Buffer32_32 bufffer5(.IN(Q[5]),.Store(DecoderRn_CU[5]),.OUT(Rn));
//Buffer32_32(input [31:0] IN,input Store,output [31:0] OUT);
Buffer32_32 bufffer52(.IN(Q[5]),.Store(DecoderRm[5]),.OUT(Rm));
//Buffer32_32(input [31:0] IN,input Store,output [31:0] OUT);
Buffer32_32 bufffer53(.IN(Q[5]),.Store(DecoderRs[5]),.OUT(Rs));

//Register 6
//Register(input [31:0] IN,input Clk, Reset,Load,output [31:0] OUT);
Register test_reg6(.IN(in),
				  .Clk(Clk),
				  .Reset(RESET),
				  .Load(DecoderRd[6]&LOAD),
				  .OUT(Q[6]));
//Buffer32_32(input [31:0] IN,input Store,output [31:0] OUT);
Buffer32_32 bufffer6(.IN(Q[6]),.Store(DecoderRn_CU[6]),.OUT(Rn));
//Buffer32_32(input [31:0] IN,input Store,output [31:0] OUT);
Buffer32_32 bufffer62(.IN(Q[6]),.Store(DecoderRm[6]),.OUT(Rm));
//Buffer32_32(input [31:0] IN,input Store,output [31:0] OUT);
Buffer32_32 bufffer63(.IN(Q[6]),.Store(DecoderRs[6]),.OUT(Rs));

//Register 7
//Register(input [31:0] IN,input Clk, Reset,Load,output [31:0] OUT);
Register test_reg7(.IN(in),
				  .Clk(Clk),
				  .Reset(RESET),
				  .Load(DecoderRd[7]&LOAD),
				  .OUT(Q[7]));
//Buffer32_32(input [31:0] IN,input Store,output [31:0] OUT);
Buffer32_32 bufffer7(.IN(Q[7]),.Store(DecoderRn_CU[7]),.OUT(Rn));
//Buffer32_32(input [31:0] IN,input Store,output [31:0] OUT);
Buffer32_32 bufffer72(.IN(Q[7]),.Store(DecoderRm[7]),.OUT(Rm));
//Buffer32_32(input [31:0] IN,input Store,output [31:0] OUT);
Buffer32_32 bufffer73(.IN(Q[7]),.Store(DecoderRs[7]),.OUT(Rs));

//Register 8
//Register(input [31:0] IN,input Clk, Reset,Load,output [31:0] OUT);
Register test_reg8(.IN(in),
				  .Clk(Clk),
				  .Reset(RESET),
				  .Load(DecoderRd[8]&LOAD),
				  .OUT(Q[8]));
//Buffer32_32(input [31:0] IN,input Store,output [31:0] OUT);
Buffer32_32 bufffer8(.IN(Q[8]),.Store(DecoderRn_CU[8]),.OUT(Rn));
//Buffer32_32(input [31:0] IN,input Store,output [31:0] OUT);
Buffer32_32 bufffer82(.IN(Q[8]),.Store(DecoderRm[8]),.OUT(Rm));
//Buffer32_32(input [31:0] IN,input Store,output [31:0] OUT);
Buffer32_32 bufffer83(.IN(Q[8]),.Store(DecoderRs[8]),.OUT(Rs));

//Register 9
//Register(input [31:0] IN,input Clk, Reset,Load,output [31:0] OUT);
Register test_reg9(.IN(in),
				  .Clk(Clk),
				  .Reset(RESET),
				  .Load(DecoderRd[9]&LOAD),
				  .OUT(Q[9]));
//Buffer32_32(input [31:0] IN,input Store,output [31:0] OUT);
Buffer32_32 bufffer9(.IN(Q[9]),.Store(DecoderRn_CU[9]),.OUT(Rn));
//Buffer32_32(input [31:0] IN,input Store,output [31:0] OUT);
Buffer32_32 bufffer92(.IN(Q[9]),.Store(DecoderRm[9]),.OUT(Rm));
//Buffer32_32(input [31:0] IN,input Store,output [31:0] OUT);
Buffer32_32 bufffer93(.IN(Q[9]),.Store(DecoderRs[9]),.OUT(Rs));

//Register 10
//Register(input [31:0] IN,input Clk, Reset,Load,output [31:0] OUT);
Register test_reg10(.IN(in),
				  .Clk(Clk),
				  .Reset(RESET),
				  .Load(DecoderRd[10]&LOAD),
				  .OUT(Q[10]));
//Buffer32_32(input [31:0] IN,input Store,output [31:0] OUT);
Buffer32_32 bufffer10(.IN(Q[10]),.Store(DecoderRn_CU[10]),.OUT(Rn));
//Buffer32_32(input [31:0] IN,input Store,output [31:0] OUT);
Buffer32_32 bufffer102(.IN(Q[10]),.Store(DecoderRm[10]),.OUT(Rm));
//Buffer32_32(input [31:0] IN,input Store,output [31:0] OUT);
Buffer32_32 bufffer103(.IN(Q[10]),.Store(DecoderRs[10]),.OUT(Rs));

//Register 11
//Register(input [31:0] IN,input Clk, Reset,Load,output [31:0] OUT);
Register test_reg11(.IN(in),
				  .Clk(Clk),
				  .Reset(RESET),
				  .Load(DecoderRd[11]&LOAD),
				  .OUT(Q[11]));
//Buffer32_32(input [31:0] IN,input Store,output [31:0] OUT);
Buffer32_32 bufffer11(.IN(Q[11]),.Store(DecoderRn_CU[11]),.OUT(Rn));
//Buffer32_32(input [31:0] IN,input Store,output [31:0] OUT);
Buffer32_32 bufffer112(.IN(Q[11]),.Store(DecoderRm[11]),.OUT(Rm));
//Buffer32_32(input [31:0] IN,input Store,output [31:0] OUT);
Buffer32_32 bufffer113(.IN(Q[11]),.Store(DecoderRs[11]),.OUT(Rs));

//Register 12
//Register(input [31:0] IN,input Clk, Reset,Load,output [31:0] OUT);
Register test_reg12(.IN(in),
				  .Clk(Clk),
				  .Reset(RESET),
				  .Load(DecoderRd[12]&LOAD),
				  .OUT(Q[12]));
//Buffer32_32(input [31:0] IN,input Store,output [31:0] OUT);
Buffer32_32 bufffer121(.IN(Q[12]),.Store(DecoderRn_CU[12]),.OUT(Rn));
//Buffer32_32(input [31:0] IN,input Store,output [31:0] OUT);
Buffer32_32 bufffer122(.IN(Q[12]),.Store(DecoderRm[12]),.OUT(Rm));
//Buffer32_32(input [31:0] IN,input Store,output [31:0] OUT);
Buffer32_32 bufffer123(.IN(Q[12]),.Store(DecoderRs[12]),.OUT(Rs));

//Register 13
//Register(input [31:0] IN,input Clk, Reset,Load,output [31:0] OUT);
Register test_reg13(.IN(in),
				  .Clk(Clk),
				  .Reset(RESET),
				  .Load(DecoderRd[13]&LOAD),
				  .OUT(Q[13]));
//Buffer32_32(input [31:0] IN,input Store,output [31:0] OUT);
Buffer32_32 bufffer131(.IN(Q[13]),.Store(DecoderRn_CU[13]),.OUT(Rn));
//Buffer32_32(input [31:0] IN,input Store,output [31:0] OUT);
Buffer32_32 bufffer132(.IN(Q[13]),.Store(DecoderRm[13]),.OUT(Rm));
//Buffer32_32(input [31:0] IN,input Store,output [31:0] OUT);
Buffer32_32 bufffer133(.IN(Q[13]),.Store(DecoderRs[13]),.OUT(Rs));

//Register 14
//Register(input [31:0] IN,input Clk, Reset,Load,output [31:0] OUT);
Register test_reg14(.IN(in),
				  .Clk(Clk),
				  .Reset(RESET),
				  .Load(DecoderRd[14]&LOAD),
				  .OUT(Q[14]));
//Buffer32_32(input [31:0] IN,input Store,output [31:0] OUT);
Buffer32_32 bufffer14(.IN(Q[14]),.Store(DecoderRn_CU[14]),.OUT(Rn));
//Buffer32_32(input [31:0] IN,input Store,output [31:0] OUT);
Buffer32_32 bufffer142(.IN(Q[14]),.Store(DecoderRm[14]),.OUT(Rm));
//Buffer32_32(input [31:0] IN,input Store,output [31:0] OUT);
Buffer32_32 bufffer143(.IN(Q[14]),.Store(DecoderRs[14]),.OUT(Rs));

//Register 15
//Register(input [31:0] IN,input Clk, Reset,Load,output [31:0] OUT);
Register test_reg15(.IN(in),
				  .Clk(Clk),
				  .Reset(RESET),
				  .Load(DecoderRd[15]&LOAD),
				  .OUT(Q[15]));
//Buffer32_32(input [31:0] IN,input Store,output [31:0] OUT);
Buffer32_32 bufffer15(.IN(Q[15]),.Store(DecoderRn_CU[15]),.OUT(Rn));
//Buffer32_32(input [31:0] IN,input Store,output [31:0] OUT);
Buffer32_32 bufffer152(.IN(Q[15]),.Store(DecoderRm[15]),.OUT(Rm));
//Buffer32_32(input [31:0] IN,input Store,output [31:0] OUT);
Buffer32_32 bufffer153(.IN(Q[15]),.Store(DecoderRs[15]),.OUT(Rs));

endmodule