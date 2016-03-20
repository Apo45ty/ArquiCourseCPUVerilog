module Register2(input [31:0] IN,IN2,input Clk, Reset,Load,Load2,output [31:0] OUT,OUT2);
reg [31:0] d;
assign OUT = d;
assign OUT2 = d;
always@(negedge Clk)
begin
	if(Load)
		d=IN;
	else if(Load2)
		d=IN2;
end

always@(Reset)
	d=0;

endmodule