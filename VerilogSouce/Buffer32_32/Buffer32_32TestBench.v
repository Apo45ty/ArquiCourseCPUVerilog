module Buffer32_32TestBench;

parameter sim_time = 750*2; // Num of Cycles * 2 

reg [31:0] IN;
reg Sel;
wire [31:0] OUT;

Buffer32_32 buffer(IN,Sel,OUT);

initial fork
		Sel = 0; IN =0;
		#1 Sel = 1; #1 IN =0;
		#2 Sel = 1; #2 IN =1;
join

	
initial #sim_time $finish;           //Especifica cuando termina la simulacion


initial begin
	$dumpfile("Buffer32_32TestBench.vcd");
	$dumpvars(0,Buffer32_32TestBench);
	$display(" Test Results" );                  // imprime header
	$monitor("T = %3d,Sel = %1b, Out = %5b",$time,Sel,OUT);  //imprime se~ales
end

endmodule
//iverilog Buffer32_32.v Buffer32_32TestBench.v
//vvp a.out
//gtkwave Buffer32_32TestBench.vcd