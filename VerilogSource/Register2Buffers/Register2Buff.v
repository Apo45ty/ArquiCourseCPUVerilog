module Register2Buff(inout [31:0] IN,IN2,input Clk, Reset,Load,Load2,Store,Store2);
wire [31:0] _OUT;
//module Register2(input [31:0] IN,IN2,input Clk, Reset,Load,Load2,output [31:0] OUT);
Register2 register( IN,IN2, Clk, Reset,Load,Load2, _OUT);
//Buffer32_32(input [31:0] IN,input Store,output [31:0] OUT);
Buffer32_32 buff1( _OUT, Store, IN);
//Buffer32_32(input [31:0] IN,input Store,output [31:0] OUT);
Buffer32_32 buff2( _OUT, Store2,IN2);
endmodule