module ARM_ALU(input wire [31:0] A,B,input wire[4:0] OP,input wire [3:0] FLAGS,output wire [31:0] Out,output wire [3:0] FLAGS_OUT, input wire S,ALU_OUT);

parameter HIGHZ = 32'hzzzzzzzz;
reg [31:0] buffer,_A,_B;
reg [3:0] FLAGS_buff;
initial begin 
	FLAGS_buff=4'h0;
end
/*
STATUS REGISTER FLAGS
WE FETCH INSTRUCTIONS 8BITS AT A TIME 8BIT DATAPATH
31. Negatice, N = (ADD)&&(A[31]==B[31])&&(A[31]!=OUT[31]) || (SUB)
30. Zero, Z = OUT == 0
29. Carry, C = CARRY
28. Overflow, V = OVERFLOW
END
*/
always @(A or B or OP)
begin
_A=A;
_B=B;
casez(OP)
  //AND, Out = A & B
  //TST, perform an AND but dont transfer it to a register
  5'b00000,5'b01000:
	begin
		FLAGS_buff=4'h0;
		buffer <=  A & B ;	  
		FLAGS_buff[3] = buffer[31];
		FLAGS_buff[2] = buffer == 32'h0;
		FLAGS_buff[0] = _A[31] == _B[31] && _A[31] != buffer[31];
	end
  //EOR Logical Exclusive OR, Out= A XOR B
  //TEQ, perform an EOR but dont transfer it to a register
  5'b00001,5'b01001:
  begin 
		FLAGS_buff=4'h0;
		buffer <= A ^ B ;	  
		FLAGS_buff[3] = buffer[31];
		FLAGS_buff[2] = buffer == 32'h0;
		FLAGS_buff[0] = _A[31] == _B[31] && _A[31] != buffer[31];
  end
  //Sub Substract, Out = A - B
  //CMP, perform an SUB but dont transfer it to a register
  5'b00010,5'b01010:
	begin 
		FLAGS_buff=4'h0;
		_B = ~B+1;
		{FLAGS_buff[1],buffer} <= _A + _B ;
		FLAGS_buff[3] = buffer[31];
		FLAGS_buff[2] = buffer == 32'h0;
		FLAGS_buff[0] = _A[31] == _B[31] && _A[31] != buffer[31];
	end
  //RSB, OUT = B - A
  5'b00011:
	begin 
		FLAGS_buff=4'h0;
		_A = ~A+1;
		{FLAGS_buff[1],buffer} <= _B + _A;	  
		FLAGS_buff[3] = buffer[31];
		FLAGS_buff[2] = buffer == 32'h0;
		FLAGS_buff[0] = _A[31] == _B[31] && _A[31] != buffer[31];
	end
  //ADD, OUT = A + B
  //CMN, perform an ADD but dont transfer it to a register
  5'b00100,5'b01011:
	  begin
		FLAGS_buff=4'h0;
		{FLAGS_buff[1],buffer} <= A + B ;		  
		FLAGS_buff[3] = buffer[31];
		FLAGS_buff[2] = buffer == 32'h0;
		FLAGS_buff[0] = _A[31] == _B[31] && _A[31] != buffer[31];
	  end
  //ADC, OUT = A + B + C
  5'b00101:
  begin
		FLAGS_buff=4'h0;
		{FLAGS_buff[1],buffer} <= A + B + FLAGS[1];  
		FLAGS_buff[3] = buffer[31];
		FLAGS_buff[2] = buffer == 32'h0;
		FLAGS_buff[0] = _A[31] == _B[31] && _A[31] != buffer[31];
  end
  //SBC, OUT = A-B-(~C)
  5'b00110:
	begin 
		FLAGS_buff=4'h0;
		_B = ~B+1;
		{FLAGS_buff[1],buffer} <= _A + _B - !FLAGS[1];		  
		FLAGS_buff[3] = buffer[31];
		FLAGS_buff[2] = buffer == 32'h0;
		FLAGS_buff[0] = _A[31] == _B[31] && _A[31] != buffer[31];
	end
  //RSC, OUT = B-A-(~C)
  5'b00111:
	begin 
		FLAGS_buff=4'h0;
		_A = ~A+1;
		{FLAGS_buff[1],buffer} <= B + _A - !FLAGS[1];		  
		FLAGS_buff[3] = buffer[31];
		FLAGS_buff[2] = buffer == 32'h0;
		FLAGS_buff[0] = _A[31] == _B[31] && _A[31] != buffer[31];
	end
  //ORR, OUT = A or B
  5'b01100:
  begin 
		FLAGS_buff=4'h0;
		buffer <= A | B;
		FLAGS_buff[3] = buffer[31];
		FLAGS_buff[2] = buffer == 32'h0;
		FLAGS_buff[0] = _A[31] == _B[31] && _A[31] != buffer[31];
  end
  //BIC, OUT = A or not(B)
  5'b01110:
	begin
		FLAGS_buff=4'h0;
		buffer <= A & ~B;
		FLAGS_buff[3] = buffer[31];
		FLAGS_buff[2] = buffer == 32'h0;
		FLAGS_buff[0] = _A[31] == _B[31] && _A[31] != buffer[31];
		//$display("A=%3h,B=%3h,!B=%3h, A & B! =%3h",A,B,~B,A & ~B);
	end
  //MVN Rd := NOT shifter_operand (no first operand)
  5'b01111:
    begin 
		FLAGS_buff=4'h0;
		buffer <= ~ B;		  
		FLAGS_buff[3] = buffer[31];
		FLAGS_buff[2] = buffer == 32'h0;
		FLAGS_buff[0] = _A[31] == _B[31] && _A[31] != buffer[31];
		//$display("B=%3h,~B=%3h",B,~B);
	end
  //BYPASS B
  5'b10000:buffer <= B;
  //add 4 A
  5'b10001:buffer <= A + 4;
  //BYPASS A
  5'b10010,5'b01101:buffer <= A;
endcase
end
  

assign FLAGS_OUT =  FLAGS_buff ;
assign Out =  ALU_OUT ?  buffer : HIGHZ;

endmodule
