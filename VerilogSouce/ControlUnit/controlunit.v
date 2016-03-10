module ControlUnit (output reg IR_CU, RFLOAD, PCLOAD, SRLOAD, SRENABLED, ALUSTORE, MFA, WORD_BYTE,READ_WRITE,IRLOAD,MBRLOAD,MBRSTORE,MARLOAD,output reg[4:0] opcode, output reg[3:0] CU,  input MFC, Reset,Clk, input [31:0] IR,input [3:0] SR);

reg [4:0] State, NextState;

task registerTask;
input [17:0] signals;
//6 7 8 12 14 16 
fork
	//#2 set the alu signals
	#2 {CU,IR_CU, RFLOAD, PCLOAD, SRLOAD,opcode, SRENABLED, ALUSTORE, MARLOAD,MBRSTORE,MBRLOAD,IRLOAD,MFA,READ_WRITE, WORD_BYTE} = {signals[17],1'b0,signals[15],1'b0,signals[13],1'b0,signals[11:9],1'b0,1'b0,1'b0,signals[5:0]};
	//#4 set the register signals
	#4 {CU,IR_CU, RFLOAD, PCLOAD, SRLOAD,opcode, SRENABLED, ALUSTORE, MARLOAD,MBRSTORE,MBRLOAD,IRLOAD,MFA,READ_WRITE, WORD_BYTE} = signals;
	//#6 let data be saved
	#6 {CU,IR_CU, RFLOAD, PCLOAD, SRLOAD,opcode, SRENABLED, ALUSTORE, MARLOAD,MBRSTORE,MBRLOAD,IRLOAD,MFA,READ_WRITE, WORD_BYTE} = signals;
join
endtask

always @ (negedge Clk, posedge Reset)
	if (Reset) begin 
		State <= 3'b001; end
	else 
		State <= NextState;

always @ (State, MFC)
	case (State)
		3'b000 : if(!Reset)  NextState = 3'b001; else NextState = 3'b000;
		3'b001 : NextState = 3'b010;
		3'b010 : NextState = 3'b011;
		3'b011 : if(!MFC) NextState = 3'b010; else NextState = 3'b011;
		3'b100 : NextState = 3'b101;
		3'b101 : 
		begin
			case(IR[31:28])
				4'b0000:
					begin 
						NextState = 3'b110;
					end
				4'b0001:
					begin 
					end
			endcase
		end
		3'b110 :
		begin
			case(IR[24:21])
				4'b0000:
					begin 
					  NextState = 3'b000;
					end
				4'b0001:
					begin 
					end
			endcase
		end
		default : NextState = 3'b000;
	endcase 
always @ (State, MFC)
	case (State)
		3'b000 : begin  end
		3'b001 : begin  end // send pc to mar: ircu = 1 cu = 1111,MARLOAD = 1
		3'b010 : begin  end // increment pc : loadpc = 1 ircu = 1 cu = 1111 op = 17 
		3'b011 : begin  end //  wait for MFC: MFA = 1 LOADIR = 1 read_write = 1 word_byte = 1
		3'b100 : begin  end // transfer data to IR 
		3'b101 : begin  end // Check status codes 
		3'b110 : begin  end // Decode instruction type and set out signals
		/*branch and load_store instruction*/
		default : begin end
	endcase
endmodule