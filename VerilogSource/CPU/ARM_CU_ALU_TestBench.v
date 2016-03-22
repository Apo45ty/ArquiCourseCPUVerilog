module ARM_CU_ALU_TestBench;

parameter sim_time = 750*2; // Num of Cycles * 2 

reg MFC , Reset , Clk , MEMSTORE,MEMLOAD,MEMDAT;
wire  MEMADD, MFA,READ_WRITE,WORD_BYTE;

//module ARM_CU_ALU( input MFC , Reset , Clk , MEMSTORE,MEMLOAD,MEMDAT, output MEMADD, MFA,READ_WRITE,WORD_BYTE);
ARM_CU_ALU CPU( MFC , Reset , Clk , MEMSTORE,MEMLOAD,MEMDAT,MEMADD, MFA,READ_WRITE,WORD_BYTE);

initial fork
	Reset =1; Clk = 0; MEMSTORE=0;MEMLOAD=0;MEMDAT=0;
	#1 Reset = 0;
join
	
	
always 
	#1 Clk = ~Clk;
	
initial #sim_time $finish; 

initial begin
	$dumpfile("ARM_CU_ALU_TestBench.vcd");
	$dumpvars(0,ARM_CU_ALU_TestBench);
	$display(" Test Results" );
	$monitor("input MFC =%d, Reset =%d, Clk =%d, MEMSTORE=%d,MEMLOAD=%d,MEMDAT=%d, output MEMADD=%d, MFA=%d,READ_WRITE=%d,WORD_BYTE=%d,",MFC , Reset , Clk , MEMSTORE,MEMLOAD,MEMDAT, MEMADD, MFA,READ_WRITE,WORD_BYTE);
end

endmodule
//iverilog ARM_ALU.v ARM_CU_ALU.v BarrelShifter.v Buffer32_32.v controlunit.v  Decoder4x16.v Multiplexer2x1_32b.v Register.v Register2.v RegisterFile.v Register2Buff.v ARM_CU_ALU_TestBench.v