module ARM_CU_TestBench;

parameter sim_time = 750*2; // Num of Cycles * 2 
wire [17:0] signals;
wire IR_CU,  RFLOAD,  PCLOAD,  SRLOAD,  SRENABLED,  ALUSTORE,  MFA,  WORD_BYTE, READ_WRITE, IRLOAD, MBRLOAD, MBRSTORE, MARLOAD;
wire [4:0] opcode; 
wire [3:0] CU; 
reg [31:0] IR;
reg [3:0] SR;
reg MFC , Reset , Clk ;

//ControlUnit (output reg IR_CU, RFLOAD, PCLOAD, SRLOAD, SRENABLED, ALUSTORE, MFA, WORD_BYTE,READ_WRITE,IRLOAD,MBRLOAD,MBRSTORE,MARLOAD,output reg[4:0] opcode, output[3:0] CU,  input MFC, Reset,Clk);
ControlUnit cu(IR_CU,  RFLOAD,  PCLOAD,  SRLOAD,  SRENABLED,  ALUSTORE,  MFA,  WORD_BYTE, READ_WRITE, IRLOAD, MBRLOAD, MBRSTORE, MARLOAD,opcode,CU,MFC,Reset,Clk,IR,SR);

initial fork
	MFC = 0; Reset=1 ; Clk=0 ;
	#1 MFC = 1;#1 Reset=0 ;
join
	
	
always 
	#1 Clk = ~Clk;
	
initial #sim_time $finish; 

initial begin
	$dumpfile("ARM_CU_TestBench.vcd");
	$dumpvars(0,ARM_CU_TestBench);
	$display(" Test Results" );
	$monitor("IR_CU=%d  RFLOAD=%d  PCLOAD=%d  SRLOAD=%d  SRENABLED=%d  ALUSTORE=%d  MFA=%d  WORD_BYTE=%d READ_WRITE=%d IRLOAD=%d MBRLOAD=%d MBRSTORE=%d MARLOAD=%d opcode=%d CU=%d  MFC=%d Reset=%d Clk=%d",IR_CU, RFLOAD, PCLOAD, SRLOAD, SRENABLED, ALUSTORE, MFA, WORD_BYTE,READ_WRITE,IRLOAD,MBRLOAD,MBRSTORE,MARLOAD, opcode, CU,  MFC, Reset,Clk);
end

endmodule
//iverilog controlunit.v ARM_CU_TestBench.v