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
		State <= 5'b00001;ALUSTORE = 0 ; IR_CU= 0 ; RFLOAD= 0 ; PCLOAD= 0 ; SRLOAD= 0 ; SRENABLED= 0 ; MFA= 0 ; WORD_BYTE= 0 ;READ_WRITE= 0 ;IRLOAD= 0 ;MBRLOAD= 0 ;MBRSTORE= 0 ;MARLOAD = 0 ;CU=0; opcode=5'b10010;end
	else 
		State <= NextState;

always @ (State, MFC)
	case (State)
		5'b00000 : NextState = 5'b00000; 
		5'b00001 : NextState = 5'b00010;
		5'b00010 : NextState = 5'b00011;
		5'b00011 : if(MFC)NextState = 5'b00100; else  NextState = 5'b00011;
		5'b00100 : NextState = 5'b00101;
		5'b00101 : NextState = 5'b00110;//Decode Begin
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
		5'b10001 : NextState = 5'b00001;
	endcase 
always @ (State, MFC)
	case (State)
		5'b00000 : begin  end
		5'b00001 : begin  ALUSTORE = 1 ;IR_CU= 0 ; RFLOAD= 0 ; PCLOAD= 0 ; SRLOAD= 0 ; SRENABLED= 0 ; MFA= 0 ; WORD_BYTE= 0 ;READ_WRITE= 0 ;IRLOAD= 0 ;MBRLOAD= 0 ;MBRSTORE= 0 ;MARLOAD = 1 ; CU=4'hf;opcode=5'b10010;end // send pc to mar: ircu = 1 cu = 1111,MARLOAD = 1
		5'b00010 : begin  ALUSTORE = 1 ;IR_CU= 0 ; RFLOAD= 0 ; PCLOAD= 1 ; SRLOAD= 0 ; SRENABLED= 0 ; MFA= 1 ; WORD_BYTE= 1 ;READ_WRITE= 1 ;IRLOAD= 0 ;MBRLOAD= 0 ;MBRSTORE= 0 ;MARLOAD = 0 ; CU=4'hf;opcode=5'b10001;end // increment pc : loadpc = 1 ircu = 1 cu = 1111 op = 17 
		5'b00011 : begin  ALUSTORE = 0 ;IR_CU= 0 ; RFLOAD= 0 ; PCLOAD= 0 ; SRLOAD= 0 ; SRENABLED= 0 ; MFA= 1 ; WORD_BYTE= 1 ;READ_WRITE= 1 ;IRLOAD= 0 ;MBRLOAD= 0 ;MBRSTORE= 0 ;MARLOAD = 0 ; CU=4'hf;opcode=5'b10010;end //  wait for MFC: MFA = 1 LOADIR = 1 read_write = 1 word_byte = 1
		5'b00100 : begin  ALUSTORE = 0 ;IR_CU= 0 ; RFLOAD= 0 ; PCLOAD= 0 ; SRLOAD= 0 ; SRENABLED= 0 ; MFA= 0 ; WORD_BYTE= 0 ;READ_WRITE= 0 ;IRLOAD= 1 ;MBRLOAD= 0 ;MBRSTORE= 1 ;MARLOAD = 0 ; CU=4'hf;opcode=5'b10010;end // transfer data to IR 
		5'b00101 : begin  end // Check status codes 
		5'b00110 : begin  end // Decode instruction type and set out signals
		5'b00111 : begin  end 
		5'b01000 : begin  end 
		5'b01001 : begin  end 
		5'b01010 : begin  end 
		5'b01011 : begin  end 
		5'b01100 : begin  end 
		5'b01101 : begin  end 
		5'b01110 : begin  end 
		5'b01111 : begin  end 
		5'b10000 : begin  end 
		5'b10001 : begin  end 
		/*branch and load_store instruction*/
		default : begin end
	endcase
endmodule