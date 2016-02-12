module ARM_ALU(input wire [31:0] A,B,input wire[4:0] OP,input wire [3:0] FLAGS,output wire [31:0] Out,output wire [3:0] FLAGS_OUT, input wire S,ALU_OUT);


parameter HIGHZ = 32'hzzzzzzzz;
reg [31:0] buffer=32'h00000000;
reg [3:0] FLAGS_buff=4'h0;

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
FLAGS_buff=4'h0;
casez(OP)
  //AND, Out = A & B
  //TST, perform an AND but dont transfer it to a register
  5'b00000,5'b01000:
	begin
	  buffer <=  A & B ;
	end
  //EOR Logical Exclusive OR, Out= A XOR B
  //TEQ, perform an EOR but dont transfer it to a register
  5'b00001,5'b01001:buffer <= A ^ B ;
  //Sub Substract, Out = A - B
  //CMP, perform an SUB but dont transfer it to a register
  5'b00010,5'b01010:buffer <= A - B ;
  //RSB, OUT = B - A
  5'b00011:buffer <= B - A;
  //ADD, OUT = A + B
  //CMN, perform an ADD but dont transfer it to a register
  5'b00100,5'b01011:
	  begin
		{FLAGS_buff[1],buffer} <= A + B ;
	  end
  //ADC, OUT = A + B + C
  5'b00101:buffer <= A + B + FLAGS[1];
  //SBC, OUT = A-B-(~C)
  5'b00110:buffer <= A - B - !FLAGS[1];
  //RSC, OUT = B-A-(~C)
  5'b00111:buffer <= B - A - !FLAGS[1];
  //ORR, OUT = A or B
  5'b01100:buffer <= A | B;
  //BIC, OUT = A or not(B)
  5'b01110:buffer <= A & !B;
  //BYPASS
  5'bzzzzz, 5'b10000:buffer <= B;
  //add 4 A
  5'b10001:buffer <= A + 1;
  default: buffer <= B;
endcase
end
  
always@(buffer)
begin
  FLAGS_buff[3] = buffer[31];
  FLAGS_buff[2] = buffer == 32'h0;
  FLAGS_buff[0] = A[31] == B[31] && A[31] != buffer[31];
end

assign FLAGS_OUT = S ? FLAGS_buff : FLAGS;
assign Out =   buffer ;

endmodule
