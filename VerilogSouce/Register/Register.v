module Register(input [31:0] IN,input Clk, Reset,Load,output [31:0] OUT);
reg [31:0] d;
assign OUT = d;
always@(negedge Clk)
begin
	if(Load)
		d=IN;
end

always@(Reset)
	d=0;

endmodule