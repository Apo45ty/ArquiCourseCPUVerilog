module memorytestbench;

parameter sim_time = 750*2; // Num of Cycles * 2 

wire  MFC;
wire [31:0] MEMDAT;
reg [31:0] MEMDAT_BUFF;
reg MFA,READ_WRITE,WORD_BYTE, Reset ,Clk;
reg [7:0] MEMADD;

assign MEMDAT = MEMDAT_BUFF;

//module memory (inout reg[31:0] Data, output reg MFC, input MFA, ReadWrite, input [7:0] Address, input wordByte, Reset);
memory mem( MEMDAT, MFC,  MFA, READ_WRITE,  MEMADD,  WORD_BYTE, Reset);
initial fork
	Reset =1; Clk = 0; MEMADD=0;MFA=0;MEMADD=0; MEMDAT_BUFF = 32'hzzzz_zzzz;
	#1 Reset = 0;
	#50 MEMADD = 0 ; #50 READ_WRITE  =1 ; #50 WORD_BYTE = 0 ;  #50 MFA = 1;
	#70 MFA = 0;
	#100 MEMADD = 0 ; #100 READ_WRITE  =0 ; #100 WORD_BYTE = 0 ;  #100 MFA = 1; #100  MEMDAT_BUFF = 32'hAAAA_AAAA;
join
	
always 
	#1 Clk = ~Clk;
	
initial #sim_time $finish; 

initial begin
	$dumpfile("memorytestbench.vcd");
	$dumpvars(0,memorytestbench);
	$display(" Test Results" );
	//$monitor("input MFC =%d, Reset =%d, Clk =%d, MEMSTORE=%d,MEMLOAD=%d,MEMDAT=%d, output MEMADD=%d, MFA=%d,READ_WRITE=%d,WORD_BYTE=%d,",MFC , Reset , Clk , MEMSTORE,MEMLOAD,MEMDAT, MEMADD, MFA,READ_WRITE,WORD_BYTE);
end

endmodule
//iverilog MEM_256B.v  MEM_256B_TEST.v 