module BarrelShifter(input [31:0] Rs,Rm,IR,input SR29_IN,output SR29_OUT,output [31:0] Out);
/* 
Data processing immediate IR[27:25] == 000 & IR[4] = 0/ IR[6:5] Shiftype / IR[11:7] Shift Amount/ Shift val Rm
Data register shift IR[27:25] == 000 / IR[6:5] Shiftype / Rs Shift Amount/ Shift val Rm
Data processing immediate IR[27:25] == 001 / ROR Shiftype / IR[11:7] Shift Amount / Shift val IR[7:0]
Load/Store immediate IR[27:25] == 010
Load/Store register offset IR[27:25] == 011
branch and branch with link IR[27:25] == 101
*/
reg [31:0] shiftVal,shiftAmount;
reg [1:0]  shiftType;
always@(IR or Rm or Rs or SR29_IN)
begin 
	case(IR[27:25])
		3'b000:
			begin
				if(!IR[4])//Immediate Rs
					begin
						$display("Immediate Rm");
						shiftVal = Rm;
						shiftAmount = IR[11:7];
						shiftType = IR[6:5];
					end
				else
					begin
						$display("Registe rm");	// Registe rs		
						shiftVal = Rm;
						shiftAmount = Rs[5:0];
						shiftType = IR[6:5];
					end
			end
		3'b001:
			begin//Imediate IR[7:0]
				$display("Imediate IR[7:0]");
				shiftVal = IR[7:0];
				shiftAmount = IR[11:8]*2;
				shiftType = 2'b11;
			end
		3'b101:
			begin//branch 
				$display("Branch");
			end
	endcase
end

reg [32:0] temp,temp2;
reg [31:0] _Out;
reg _SR29_OUT;
integer i=0;

assign Out = _Out;
assign SR29_OUT = _SR29_OUT;

always@(*)
begin
	case(shiftType)
		2'b00:
			begin
				$display("LSL");
				if(shiftAmount==32)
					_Out = 0 ;
				else if (shiftAmount>=33)
					{_SR29_OUT,_Out} = 0 ;
				else begin
				temp = {SR29_IN,shiftVal };
				temp2 = 0;				
				for(i = 0; i <= 32- shiftAmount[4:0] ;i = i + 1) begin
						temp2[32-i] = temp[32-i-shiftAmount] ; 
				end
				{_SR29_OUT,_Out} = temp2; 
				end
			end
		2'b01:	
			begin
				$display("LSR");
				if(shiftAmount==32)
					_Out = 0 ;
				else if (shiftAmount>=33)
					{_SR29_OUT,_Out} = 0 ;
				else begin
				temp = {SR29_IN,shiftVal };
				temp2 = 0;				
				for(i = 0; i <= shiftAmount[4:0] ;i = i + 1) begin
						temp2[i] = temp[i+shiftAmount] ; 
				end
				{_Out,_SR29_OUT} = temp2; 
				end
			end
		2'b10:$display("ASR");
		2'b11:$display("ROR");
	endcase
end

endmodule
