module RegisterTestBench;

parameter sim_time = 750*2; // Num of Cycles * 2 
reg [31:0] test_in;
reg test_clk,test_reset,test_load;
wire  [31:0] test_out;
Register test_reg(.IN(test_in),
				  .Clk(test_clk),
				  .Reset(test_reset),
				  .Load(test_load),
				  .OUT(test_out));

reg Clk,Reset;
/*
generate
  genvar i;
  for (i=0; i<15; i=i+1) begin : dff
    custom i_custom(
       .clk(clk)
      ,.input(DFF_i[i])
      ,.output(DFF_o[i])
      );
  end
endgenerate
*/
initial fork
	test_in=0 ; test_clk=0 ; test_reset=1 ; test_load=0 ;
	#1 test_in=1;  #1 test_clk=1 ; #1 test_reset=0 ; #1 test_load=1 ;
	#2 test_in=1;  #2 test_clk=0 ; #2 test_reset=0 ; #2 test_load=1 ;
	#3 test_in=0;  #3 test_clk=1 ; #3 test_reset=0 ; #3 test_load=0 ;
join

always 
	#1 Clk = ~Clk;
	
initial #sim_time $finish;           //Especifica cuando termina la simulacion



initial begin
	$dumpfile("RegisterTestBench.vcd");
	$dumpvars(0,RegisterTestBench);
	$display(" Test Results" );                  // imprime header
	$monitor("T = %d,test_out = %d,test_in = %d,test_clk = %d,test_reset = %d,test_load = %d",$time,test_out,test_in,test_clk,test_reset,test_load );  //imprime se~ales
end

endmodule
//iverilog Register.v RegisterTestBench.v
//gtkwave RegisterTestBench.vcd