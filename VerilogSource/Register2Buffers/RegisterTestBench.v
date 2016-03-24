module RegisterTestBench;

parameter sim_time = 750*2; // Num of Cycles * 2 
wire [31:0] test_in,test_in2;
reg test_clk,test_reset,test_load,test_load2,test_store,test_store2;
reg [31:0] test_in_buff,test_in2_buff;
assign test_in=test_in_buff;
assign test_in2=test_in2_buff;
//Register2Buff(inout [31:0] IN,IN2,input Clk, Reset,Load,Load2,Store,Store2);
Register2Buff register(
			  .IN(test_in),
			  .IN2(test_in2),
			  .Clk(test_clk), 
			  .Reset(test_reset),
			  .Load(test_load),
			  .Load2(test_load2),
			  .Store(test_store),
			  .Store2(test_store2));

initial fork
	test_in_buff = 0 ; test_in2_buff = 0 ; test_clk=0 ; test_reset=1 ; test_load=0 ; test_load2=0 ; test_store=0 ;test_store2=0 ;
	#(1*2) test_in_buff = 1 ; #(1*2) test_in2_buff = 0 ; #(1*2) test_reset=0 ; #(1*2) test_load=1 ; #(1*2) test_load2=0 ; #(1*2) test_store=0 ; #(1*2) test_store2=0 ;
	#(2*2) test_in_buff = 1 ; #(2*2) test_in2_buff = 0 ; #(2*2) test_reset=0 ; #(2*2) test_load=1 ; #(2*2) test_load2=0 ; #(2*2) test_store=0 ; #(2*2) test_store2=0 ;
	#(3*2) test_in_buff = 1 ; #(3*2) test_in2_buff = 0 ; #(3*2) test_reset=0 ; #(3*2) test_load=0 ; #(3*2) test_load2=0 ; #(3*2) test_store=0 ; #(3*2) test_store2=0 ;
	#(4*2) test_in_buff = 0 ; #(4*2) test_in2_buff = 1 ; #(4*2) test_reset=0 ; #(4*2) test_load=0 ; #(4*2) test_load2=1 ; #(4*2) test_store=0 ; #(4*2) test_store2=0 ;
	#(5*2) test_in_buff = 0 ; #(5*2) test_in2_buff = 1 ; #(5*2) test_reset=0 ; #(5*2) test_load=0 ; #(5*2) test_load2=1 ; #(5*2) test_store=0 ; #(5*2) test_store2=0 ;
	#(6*2) test_in_buff = 0 ; #(6*2) test_in2_buff = 1 ; #(6*2) test_reset=0 ; #(6*2) test_load=0 ; #(6*2) test_load2=1 ; #(6*2) test_store=0 ; #(6*2) test_store2=0 ;
	#(7*2) test_in_buff = 1 ; #(7*2) test_in2_buff = 0 ; #(7*2) test_reset=0 ; #(7*2) test_load=0 ; #(7*2) test_load2=1 ; #(7*2) test_store=0 ; #(7*2) test_store2=0 ;
	#(8*2) test_in_buff = 1 ; #(8*2) test_in2_buff = 0 ; #(8*2) test_reset=0 ; #(8*2) test_load=0 ; #(8*2) test_load2=1 ; #(8*2) test_store=0 ; #(8*2) test_store2=0 ;
	#(9*2) test_in_buff = 1 ; #(9*2) test_in2_buff = 0 ; #(9*2) test_reset=0 ; #(9*2) test_load=0 ; #(9*2) test_load2=1 ; #(9*2) test_store=0 ; #(9*2) test_store2=0 ;
	#(10*2) test_in_buff = 0 ; #(10*2) test_in2_buff = 1 ; #(10*2) test_reset=0 ; #(10*2) test_load=1 ; #(10*2) test_load2=0 ; #(10*2) test_store=0 ; #(10*2) test_store2=0 ;
	#(11*2) test_in_buff = 0 ; #(11*2) test_in2_buff = 1 ; #(11*2) test_reset=0 ; #(11*2) test_load=1 ; #(11*2) test_load2=0 ; #(11*2) test_store=0 ; #(11*2) test_store2=0 ;
	#(12*2) test_in_buff = 0 ; #(12*2) test_in2_buff = 1 ; #(12*2) test_reset=0 ; #(12*2) test_load=0 ; #(12*2) test_load2=0 ; #(12*2) test_store=0 ; #(12*2) test_store2=0 ;
	#(13*2) test_in_buff <= 32'bZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ ; #(13*2) test_in2_buff <= 32'bZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ ; #(13*2) test_reset=0 ; #(13*2) test_load=0 ; #(13*2) test_load2=0 ; #(13*2) test_store=1 ; #(13*2) test_store2=0 ;
	#(14*2) test_in_buff <= 32'bZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ ; #(14*2) test_in2_buff <= 32'bZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ; #(14*2) test_reset=0 ; #(14*2) test_load=0 ; #(14*2) test_load2=0 ; #(14*2) test_store=0 ; #(14*2) test_store2=1 ;
join

always 
	#1 test_clk = ~test_clk;
	
initial #sim_time $finish;           //Especifica cuando termina la simulacion



initial begin
	$dumpfile("RegisterTestBench.vcd");
	$dumpvars(0,RegisterTestBench);
	$display(" Test Results" );                  // imprime header
	$monitor("T = %d,test_in = %d,test_in2 = %d,test_clk = %d,test_reset = %d,test_load = %d,test_load2 = %d,test_store = %d,test_store2 = %d",$time,test_in,test_in2,test_clk,test_reset,test_load,test_load2,test_store,test_store2 );  //imprime se~ales
end

endmodule
//iverilog Register2.v Buffer32_32.v Register2Buff.v RegisterTestBench.v
//gtkwave RegisterTestBench.vcd