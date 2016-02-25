module Buffer32_32(input [31:0] IN,input Store,output [31:0] OUT);
assign OUT = Store ? IN : 32'bZ;
endmodule