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
		State <= 5'b00000; end
	else 
		State <= NextState;

always @ (State, MFC)
	case (State)
		5'b00000 : if(Reset)  NextState = 5'b00000; else NextState = 5'b00001;
		5'b00001 : NextState = 5'b00010;
		5'b00010 : NextState = 5'b00011;
		5'b00011 : NextState = 5'b00100; 
		5'b00100 : NextState = 5'b00101;
		5'b00101 : NextState = 5'b00110;
		5'b00110 : NextState = 5'b00111;
		5'b00111 : NextState = 5'b01000;
		5'b01000 : NextState = 5'b01001; 
		5'b01001 : NextState = 5'b01010;
		5'b01010 : NextState = 5'b01011;
		5'b01011 : NextState = 5'b01100;
		5'b01100 : NextState = 5'b01101;
		5'b01101 : NextState = 5'b01110; 
		5'b01110 : NextState = 5'b01111;
		5'b01111 : NextState = 5'b10000;
		5'b10000 : NextState = 5'b10001;
		5'b10001 : NextState = 5'b00000;
	endcase 
always @ (State, MFC)
	case (State)
		5'b00000 : begin  opcode = 0; ALUSTORE = 1 ; end
		5'b00001 : begin  opcode = 1; ALUSTORE = 1 ; end // send pc to mar: ircu = 1 cu = 1111,MARLOAD = 1
		5'b00010 : begin  opcode = 2; ALUSTORE = 1 ; end // increment pc : loadpc = 1 ircu = 1 cu = 1111 op = 17 
		5'b00011 : begin  opcode = 3; ALUSTORE = 1 ; end //  wait for MFC: MFA = 1 LOADIR = 1 read_write = 1 word_byte = 1
		5'b00100 : begin  opcode = 4; ALUSTORE = 1 ; end // transfer data to IR 
		5'b00101 : begin  opcode = 5; ALUSTORE = 1 ; end // Check status codes 
		5'b00110 : begin  opcode = 6; ALUSTORE = 1 ; end // Decode instruction type and set out signals
		5'b00111 : begin  opcode = 7; ALUSTORE = 1 ; end 
		5'b01000 : begin  opcode = 8; ALUSTORE = 1 ; end 
		5'b01001 : begin  opcode = 9; ALUSTORE = 1 ; end 
		5'b01010 : begin  opcode = 10; ALUSTORE = 1 ; end 
		5'b01011 : begin  opcode = 11; ALUSTORE = 1 ; end 
		5'b01100 : begin  opcode = 12; ALUSTORE = 1 ; end 
		5'b01101 : begin  opcode = 13; ALUSTORE = 1 ; end 
		5'b01110 : begin  opcode = 14; ALUSTORE = 1 ; end 
		5'b01111 : begin  opcode = 15; ALUSTORE = 1 ; end 
		5'b10000 : begin  opcode = 16; ALUSTORE = 1 ; end 
		5'b10001 : begin  opcode = 17; ALUSTORE = 1 ; end 
		/*branch and load_store instruction*/
		default : begin end
	endcase
endmodule