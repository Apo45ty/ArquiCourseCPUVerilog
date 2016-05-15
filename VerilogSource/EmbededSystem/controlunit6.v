module ControlUnit (output reg IR_CU, RFLOAD, PCLOAD, SRLOAD, SRENABLED, ALUSTORE, MFA, WORD_BYTE,READ_WRITE,IRLOAD,MBRLOAD,MBRSTORE,MARLOAD,output reg[4:0] opcode, output reg[3:0] CU,  input MFC, Reset,Clk, input [31:0] IR,input [3:0] SR);

reg [4:0] State, NextState;

always @ (negedge Clk, posedge Reset)
	if (Reset) begin 
		State <= 5'b00001;ALUSTORE = 0 ; IR_CU= 0 ; RFLOAD= 0 ; PCLOAD= 0 ; SRLOAD= 0 ; SRENABLED= 0 ; MFA= 0 ; WORD_BYTE= 0 ;READ_WRITE= 0 ;IRLOAD= 0 ;MBRLOAD= 0 ;MBRSTORE= 0 ;MARLOAD = 0 ;CU=0; opcode=5'b10010;end
	else 
		State <= NextState;
/*
STATUS REGISTER FLAGS
WE FETCH INSTRUCTIONS 8BITS AT A TIME 8BIT DATAPATH
31. Negative, N = (ADD)&&(A[31]==B[31])&&(A[31]!=OUT[31]) || (SUB)
30. Zero, Z = OUT == 0
29. Carry, C = CARRY
28. Overflow, V = OVERFLOW
END
*/
always @ (State, MFC)
	case (State)
		5'b00000 : NextState = 5'b00000; 
		5'b00001 : if(MFC) NextState = 5'b10001 ; else NextState = 5'b00010;// goto stall cycle if not ready
		5'b00010 : NextState = 5'b00011; 
		5'b00011 : if(MFC)NextState = 5'b00100; else  NextState = 5'b00011;
		5'b00100 : NextState = 5'b00101;
		5'b00101 : case(IR[31:28])//Decode Begin
						4'b0000: if(SR[2]==1) NextState = 5'b00110; else NextState = 5'b00001;
						4'b0001: if(SR[2]==0) NextState = 5'b00110; else NextState = 5'b00001;
						4'b0010: if(SR[1]==1) NextState = 5'b00110; else NextState = 5'b00001;
						4'b0011: if(SR[1]==0) NextState = 5'b00110; else NextState = 5'b00001;
						4'b0100: if(SR[3]==1) NextState = 5'b00110; else NextState = 5'b00001;
						4'b0101: if(SR[3]==0) NextState = 5'b00110; else NextState = 5'b00001;
						4'b0110: if(SR[0]==1) NextState = 5'b00110; else NextState = 5'b00001;
						4'b0111: if(SR[0]==0) NextState = 5'b00110; else NextState = 5'b00001;
						4'b1000: if(SR[1]==1&SR[2]==0) NextState = 5'b00110; else NextState = 5'b00001;
						4'b1001: if(SR[1]==0|SR[2]==1) NextState = 5'b00110; else NextState = 5'b00001;
						4'b1010: if(SR[3]==SR[0]) NextState = 5'b00110; else NextState = 5'b00001;
						4'b1011: if(SR[3]!=SR[0]) NextState = 5'b00110; else NextState = 5'b00001;
						4'b1100: if(SR[2]==0&SR[3]==SR[0]) NextState = 5'b00110; else NextState = 5'b00001;
						4'b1101: if(SR[2]==1|SR[3]!=SR[0]) NextState = 5'b00110; else NextState = 5'b00001;
						4'b1110: NextState = 5'b00110; 
					endcase
		5'b00110 : case(IR[27:25])
						3'b000,3'b001:NextState = 5'b00111;
						3'b010,3'b011:NextState = 5'b01000;//Load/Store operation 1 
						3'b101:NextState = 5'b01110;//Branch operation 1
						default:NextState = 5'b0001;
				   endcase
		5'b00111 : NextState = 5'b00001; // Data operation 1
		5'b01000 : if(IR[24] == 0 & IR[0] ==0 ) NextState = 5'b01001; else if(IR[20]) NextState = 5'b01010;else NextState = 5'b01011; //Load/Store operation 1 
		5'b01001 : if(IR[20]) NextState = 5'b01010;else NextState = 5'b01011; //Load/Store operation 2
		5'b01010 : if(MFC) NextState = 5'b01100; else NextState = 5'b01010; //Load operation 1 
		5'b01011 : NextState = 5'b01101; //Store operation 1 
		5'b01100 : NextState = 5'b00001; //Load operation 2
		5'b01101 : if(!MFC) NextState = 5'b00001 ; else NextState = 5'b01101; //Store operation 2
		5'b01110 : NextState = 5'b00001;//Branch operation 1
		5'b01111 : NextState = 5'b10000; // Empty state
		5'b10000 : NextState = 5'b00001; // Empty state
		5'b10001 : if(MFC) NextState = 5'b10001 ; else NextState = 5'b00010; // Stall State MFC Already Up
	endcase 
always @ (State, MFC)
	case (State)
		5'b00000 : begin  end
		5'b00001 : begin  ALUSTORE = 1 ;IR_CU= 0 ; RFLOAD= 0 ; PCLOAD= 0 ; SRLOAD= 0 ; SRENABLED= 0 ; MFA= 0 ; WORD_BYTE= 0 ;READ_WRITE= 0 ;IRLOAD= 0 ;MBRLOAD= 0 ;MBRSTORE= 0 ;MARLOAD = 1 ; CU=4'hf;opcode=5'b10010;end // send pc to mar: ircu = 1 cu = 1111,MARLOAD = 1
		5'b00010 : begin  ALUSTORE = 1 ;IR_CU= 0 ; RFLOAD= 0 ; PCLOAD= 1 ; SRLOAD= 0 ; SRENABLED= 0 ; MFA= 1 ; WORD_BYTE= 1 ;READ_WRITE= 1 ;IRLOAD= 0 ;MBRLOAD= 0 ;MBRSTORE= 0 ;MARLOAD = 0 ; CU=4'hf;opcode=5'b10001;end // increment pc : loadpc = 1 ircu = 1 cu = 1111 op = 17 
		5'b00011 : begin  ALUSTORE = 0 ;IR_CU= 0 ; RFLOAD= 0 ; PCLOAD= 0 ; SRLOAD= 0 ; SRENABLED= 0 ; MFA= 1 ; WORD_BYTE= 1 ;READ_WRITE= 1 ;IRLOAD= 0 ;MBRLOAD= 0 ;MBRSTORE= 0 ;MARLOAD = 0 ; CU=4'hf;opcode=5'b10010;end //  wait for MFC: MFA = 1 LOADIR = 1 read_write = 1 word_byte = 1
		5'b00100 : begin  ALUSTORE = 0 ;IR_CU= 0 ; RFLOAD= 0 ; PCLOAD= 0 ; SRLOAD= 0 ; SRENABLED= 0 ; MFA= 0 ; WORD_BYTE= 0 ;READ_WRITE= 0 ;IRLOAD= 1 ;MBRLOAD= 0 ;MBRSTORE= 1 ;MARLOAD = 0 ; CU=4'hf;opcode=5'b10010;end // transfer data to IR 
		5'b00101 : begin  ALUSTORE = 1 ;IR_CU=1 ; RFLOAD= 0 ; PCLOAD= 0 ; SRLOAD= 0 ; SRENABLED= 0 ; MFA= 0 ; WORD_BYTE= 0 ;READ_WRITE= 0 ;IRLOAD= 0 ;MBRLOAD= 0 ;MBRSTORE= 0 ;MARLOAD = 0 ; CU=4'h0;end // Check status codes 
		5'b00110 : begin  ALUSTORE = 0 ;IR_CU= 1 ; RFLOAD= 0 ; PCLOAD= 0 ; SRLOAD= 0 ; SRENABLED= 0 ; MFA= 0 ; WORD_BYTE= 0 ;READ_WRITE= 0 ;IRLOAD= 0 ;MBRLOAD= 0 ;MBRSTORE= 0 ;MARLOAD = 0 ;end // Decode instruction type and set out signals
		5'b00111 : begin  ALUSTORE = 1 ;IR_CU= 1 ; RFLOAD= 1 ; PCLOAD= 0 ; SRLOAD= 0 ; SRENABLED= 0 ; MFA= 0 ; WORD_BYTE= 0 ;READ_WRITE= 0 ;IRLOAD= 0 ;MBRLOAD= 0 ;MBRSTORE= 0 ;MARLOAD = 0 ;opcode = {1'b0,IR[24:21]};end //Data Operation 1
		5'b01000 : begin  ALUSTORE = 1 ;IR_CU= 1 ; RFLOAD= IR[21]==1&IR[24]==1 ? 1 : 0; PCLOAD= 0 ; SRLOAD= 0 ; SRENABLED= 0 ; MFA= 0 ; WORD_BYTE= 0 ;READ_WRITE= 0 ;IRLOAD= 0 ;MBRLOAD= 0 ;MBRSTORE= 0 ;MARLOAD = 1 ;opcode = IR[24] == 0 & IR[0] ==0 ? 5'b10010 : IR[23] ? 5'b00100/*add*/:5'b00010 ; end //Load/Store operation 1 
		5'b01001 : begin  ALUSTORE = 1 ;IR_CU= 1 ; RFLOAD=1; PCLOAD= 0 ; SRLOAD= 0 ; SRENABLED= 0 ; MFA= 0 ; WORD_BYTE= 0 ;READ_WRITE= 0 ;IRLOAD= 0 ;MBRLOAD= 0 ;MBRSTORE= 0 ;MARLOAD = 0 ;opcode =  IR[23] ? 5'b00100/*add*/:5'b00010 ; end //Load/Store operation 1 
		5'b01010 : begin  ALUSTORE = 0 ;IR_CU= 0 ; RFLOAD= 0 ; PCLOAD= 0 ; SRLOAD= 0 ; SRENABLED= 0 ; MFA= 1 ; WORD_BYTE= IR[22] ;READ_WRITE= 1 ;IRLOAD= 0 ;MBRLOAD= 0 ;MBRSTORE= 0 ;MARLOAD = 0 ;end //Load operation 1 
		5'b01011 : begin  ALUSTORE = 1 ;IR_CU= 1 ; RFLOAD= 0 ; PCLOAD= 0 ; SRLOAD= 0 ; SRENABLED= 0 ; MFA= 0 ; WORD_BYTE= IR[22] ;READ_WRITE= 0 ;IRLOAD= 0 ;MBRLOAD= 1 ;MBRSTORE= 0 ;MARLOAD = 0 ; opcode=5'b10010; end //Store operation 1 
		5'b01100 : begin  ALUSTORE = 0 ;IR_CU= 1 ; RFLOAD= 1 ; PCLOAD= 0 ; SRLOAD= 0 ; SRENABLED= 0 ; MFA= 0 ; WORD_BYTE= IR[22] ;READ_WRITE= 0 ;IRLOAD= 0 ;MBRLOAD= 0 ;MBRSTORE= 1 ;MARLOAD = 0 ;end //Load operation 2  
		5'b01101 : begin  ALUSTORE = 0 ;IR_CU= 0 ; RFLOAD= 0 ; PCLOAD= 0 ; SRLOAD= 0 ; SRENABLED= 0 ; MFA= 1 ; #1  MFA= 0 ; WORD_BYTE= IR[22] ;READ_WRITE= 0 ;IRLOAD= 0 ;MBRLOAD= 0 ;MBRSTORE= 0 ;MARLOAD = 0 ;end //Store Operation 2
		5'b01110 : begin  ALUSTORE = 1 ;IR_CU= 0 ; RFLOAD= 0 ; PCLOAD= 1 ; SRLOAD= 0 ; SRENABLED= 0 ; MFA= 0 ; WORD_BYTE= 0 ;READ_WRITE= 0 ;IRLOAD= 0 ;MBRLOAD= 0 ;MBRSTORE= 0 ;MARLOAD = 0 ; CU=4'hf;opcode=5'b00100;end //Branch operation 1
		5'b01111 : begin  end 
		5'b10000 : begin  end 
		5'b10001 : begin  ALUSTORE = 0 ;IR_CU= 0 ; RFLOAD= 0 ; PCLOAD= 0 ; SRLOAD= 0 ; SRENABLED= 0 ; MFA= 0 ; WORD_BYTE= 0 ;READ_WRITE= 0 ;IRLOAD= 0 ;MBRLOAD= 0 ;MBRSTORE= 0 ;MARLOAD = 0 ; CU=4'hf;opcode=5'b10001;end  // Stall State Purpusely Left Empty MFC Already Up
		/*branch and load_store instruction*/
		default : begin end
	endcase
endmodule