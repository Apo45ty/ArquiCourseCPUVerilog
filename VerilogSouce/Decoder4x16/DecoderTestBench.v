module DecoderTestBench;

parameter sim_time = 750*2; // Num of Cycles * 2 

reg [3:0] in_test;
wire[15:0] out_test;

Decoder4x16 dec(.IN(in_test),.OUT(out_test));


initial fork
	 in_test = 0;
	 #1 in_test = 1;
	 #2 in_test = 2;
	 #3 in_test = 3;
	 #4 in_test = 4;
	 #5 in_test = 5;
	 #6 in_test = 6;
	 #7 in_test = 7;
	 #8 in_test = 8;
	 #9 in_test = 9;
	 #10 in_test = 10;
	 #11 in_test = 11;
	 #12 in_test = 12;
	 #13 in_test = 13;
	 #14 in_test = 14;
	 #15 in_test = 15;
join


initial #sim_time $finish;           //Especifica cuando termina la simulacion



initial begin
	$dumpfile("DecoderTestBench.vcd");
	$dumpvars(0,DecoderTestBench);
	$display(" Test Results" );                  // imprime header
	$monitor("Time = %3d,IN = %3d,OUT=%4b",$time,in_test,out_test);
end

endmodule
//iverilog Decoder4x16.v DecoderTestBench.v
//vvp a.out
//gtkwave DecoderTestBench.vcd