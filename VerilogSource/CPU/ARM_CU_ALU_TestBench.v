module ARM_CU_ALU_TestBench;

parameter sim_time = 750*2; // Num of Cycles * 2 

reg MFC , Reset , Clk , MEMSTORE,MEMLOAD;
reg [31:0] MEMDAT;
wire MFA,READ_WRITE,WORD_BYTE;
wire [7:0] MEMADD;

//module ARM_CU_ALU( input MFC , Reset , Clk , MEMSTORE,MEMLOAD,MEMDAT, output MEMADD, MFA,READ_WRITE,WORD_BYTE);
ARM_CU_ALU CPU( MFC , Reset , Clk , MEMSTORE,MEMLOAD,MEMDAT,MEMADD, MFA,READ_WRITE,WORD_BYTE);

initial fork
	Reset =1; Clk = 0; MEMSTORE=0;MEMLOAD=0;MEMDAT=0;MFC=0;
	#1 Reset = 0;
join

always@(posedge MFA)begin
	case(MEMADD) 
		8'h00:begin
			#1 MEMDAT = 32'h0000CAFE ; MEMLOAD = 1; 
			#5 MFC = 1 ;
			#7 MFC = 0 ;
		end
		8'h01:begin
			#1 MEMDAT = 32'hCAFE0000 ; MEMLOAD = 1; 
			#5 MFC = 1 ;
			#7 MFC = 0 ;
		end
	endcase
end
	
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
//iverilog ARM_ALU.v ARM_CU_ALU.v BarrelShifter.v Buffer32_32.v controlunit2.v  Decoder4x16.v Multiplexer2x1_32b.v Register.v Register2.v RegisterFile.v Register2Buff.v ARM_CU_ALU_TestBench.v