module MultiplexerTestBench;

parameter sim_time = 750*2; // Num of Cycles * 2 

initial #sim_time $finish;           //Especifica cuando termina la simulacion

reg [31:0] In1,In2;
reg IR_CU;
wire [31:0] out;
Multiplexer mult(.IN1(In1),.IN2(In2),.IR_CU(IR_CU),.OUT(out));

initial fork
	 In1 = 1; In2 = 2; IR_CU = 0;
	 #1 In1 = 1; #1 In2 = 2; #1 IR_CU = 0;
	 #2 In1 = 1; #2 In2 = 2; #2 IR_CU = 1;
join

initial begin
	$dumpfile("MultiplexerTestBench.vcd");
	$dumpvars(0,MultiplexerTestBench);
	$display(" Test Results" );                  // imprime header
	$monitor("Time = %3d,IN1 = %32b,IN2 = %32b, IR_CU = %1b, Out = %32b",$time,In1,In2,IR_CU,out);
end

endmodule
//iverilog Multiplexer2x1_32b.v MultiplexerTestBench.v
//vvp a.out
//gtkwave MultiplexerTestBench.vcd