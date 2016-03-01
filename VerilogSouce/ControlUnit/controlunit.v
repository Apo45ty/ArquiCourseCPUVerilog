module ControlUnit (output IR_CU, RFLOAD, PCLOAD, SRLOAD, SRENABLED, ALUSTORE, MFA, WORD_BYTE,READ_WRITE,IRLOAD,MBRLOAD,MBRSTORE,MARLOAD,output[4:0] opcode, output[3:0] CU,  input MFC, Reset,Clk);

reg [4:0] State, NextState;

assign State <= NextState;

always @ (posedge Clk, negedge Reset)
	if (!Reset) begin 
		State <= 3'b000; end
	else 
		State <= NextState;

always @ (State, Done)
	case (State)
		3'b000 : NextState = 3'b001;
		3'b001 : NextState = 3'b010;
		3'b010 : NextState = 3'b011;
		3'b011 : if (Done) NextState = 3'b100; else NextState = 3'b011;
		3'b100 : NextState = 3'b000;
		default : NextSate = 3'b000;
	endcase 
	
always @ (State, Done)
	case (State)
		3'b000 : begin  end
		3'b001 : begin  end
		3'b010 : begin  end
		3'b011 : begin  end
		3'b100 : begin  end
		default : begin end
	endcase
endmodule