module RegisterFile(input [31:0] in,Pcin,input [19:0] RSLCT,input Clk, RESET, LOADPC, LOAD,IR_CU, output [31:0] Rn,Rm,Rs,PCout);

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

wire [31:0] _pcin;
Buffer32_32 pcbufffer1(.IN(Pcin),.Store(LOADPC&!(DecoderRd[15]&LOAD)),.OUT(_pcin));
Buffer32_32 pcbufffer2(.IN(in),.Store((DecoderRd[15]&LOAD)),.OUT(_pcin));
			

generate
  genvar i;
  for (i=0; i<=15; i=i+1) begin : registers
	if(i<15)
		//Register(input [31:0] IN,input Clk, Reset,Load,output [31:0] OUT);
		Register test_reg(.IN(in),
					  .Clk(Clk),
					  .Reset(RESET),
					  .Load(DecoderRd[i]&LOAD),
					  .OUT(Q[i]));
	else
		begin
			//Register(input [31:0] IN,input Clk, Reset,Load,output [31:0] OUT);
			Register test_reg(.IN(_pcin),
						  .Clk(Clk),
						  .Reset(RESET),
						  .Load((DecoderRd[i]&LOAD)||LOADPC),
						  .OUT(Q[i]));
		end
  end
  for (i=0; i<=15; i=i+1) begin : buffers
	//Buffer32_32(input [31:0] IN,input Store,output [31:0] OUT);
	Buffer32_32 bufffer(.IN(Q[i]),.Store(DecoderRn_CU[i]),.OUT(Rn));
  end
  for (i=0; i<=15; i=i+1) begin : buffers2
	//Buffer32_32(input [31:0] IN,input Store,output [31:0] OUT);
	Buffer32_32 bufffer2(.IN(Q[i]),.Store(DecoderRm[i]),.OUT(Rm));
  end
  for (i=0; i<=15; i=i+1) begin : buffers3
	//Buffer32_32(input [31:0] IN,input Store,output [31:0] OUT);
	Buffer32_32 bufffer3(.IN(Q[i]),.Store(DecoderRs[i]),.OUT(Rs));
  end
endgenerate

endmodule