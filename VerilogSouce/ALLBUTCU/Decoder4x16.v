module Decoder4x16(input [3:0] IN,output reg [15:0] OUT);
integer i=0;
always@(IN)
begin
	for(i=0;i<=15;i=i+1)
	begin
		OUT[i] = 0;
	end
	OUT[IN]=1;
end 
endmodule