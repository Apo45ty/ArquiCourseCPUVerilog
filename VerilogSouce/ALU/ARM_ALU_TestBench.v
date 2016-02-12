module ARM_ALU_TestBench;

parameter sim_time = 750*2; // Num of Cycles * 2 
reg  [31:0] A,B;
reg [4:0] OP;
reg [3:0] FLAGS;
wire [31:0] Out;
wire [3:0] FLAGS_OUT;
wire S,ALU_OUT;
//ARM_ALU(input wire [31:0] A,B,input wire[4:0] OP,input wire [3:0] FLAGS,output wire [31:0] Out,output wire [3:0] FLAGS_OUT, input wire S,ALU_OUT,);
ARM_ALU alu(A,B, OP, FLAGS, Out,FLAGS_OUT,S,ALU_OUT);


initial fork
join

always 
	#1 Clk = ~Clk;
	
initial #sim_time $finish; 

initial begin
	$dumpfile("ARM_ALU_TestBench.vcd");
	$dumpvars(0,ARM_ALU_TestBench);
	$display(" Test Results" );
	$monitor("");
end

endmodule
//iverilog ARM_ALU.v ARM_ALU_TestBench.v