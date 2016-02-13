module ClockCycleGraph_ALU_REG_OP;

parameter sim_time = 50*2; // Num of Cycles * 2 
parameter cudelay = (sim_time/10);
parameter rfdelay = (sim_time/20);
parameter bsdelay = (sim_time/20);
parameter aludelay = (sim_time/20);
reg load,alu_out,ir_cu,Clk;
reg [4:0] opcode;
reg [31:0] A,B,C,Out;
initial fork 
	Clk = 1;
	#cudelay load =1 ;#cudelay alu_out = 1 ;#cudelay ir_cu =1 ; #cudelay opcode =4 ; 
	#(rfdelay+cudelay) A = 5;#(rfdelay+cudelay) B = 5;#(rfdelay+cudelay) C = 5;
	#(rfdelay+cudelay+aludelay) Out = A + B;
	#(sim_time/2) Clk = 0;
join

initial #sim_time $finish; 

initial begin
	$dumpfile("ClockCycleGraph_ALU_REG_OP.vcd");
	$dumpvars(0,ClockCycleGraph_ALU_REG_OP);
end

endmodule