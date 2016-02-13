module RegisterTestBench2;

parameter sim_time = 750*2; // Num of Cycles * 2 

reg [31:0] In;
reg Clk,Reset;
reg[15:0] Load;
wire[31:0] Out[15:0];

generate
  genvar i;
  for (i=0; i<=15; i=i+1) begin : registers
    Register test_reg(.IN(In),
				  .Clk(Clk),
				  .Reset(Reset),
				  .Load(Load[i]),
				  .OUT(Out[i]));
  end
endgenerate

integer j=0;

initial fork
	//Cycle 1 == Set
	//Clk = 0
	In=0;Reset=1;Clk = 0;
	for(j=0;j<=15;j=j+1)
	begin
		Load[j]=0;
	end
	#1 //Clk = 1 
	In=1;
	#1 Reset=0;
	#1 Load[0]=1; // always load on tick after for loop
	//#2 Clk = 0 Cycle 2
	#3 for(j=0;j<=15;j=j+1)
	begin
		Load[j]=0;
	end
	#4 Load[1]=1;
	#5 In=2;
	#5 //Clk =0 Cycle 3
	for(j=0;j<=15;j=j+1)
	begin
		Load[j]=0;
	end
	#6 Load[2]=1;
	#6 In=3;
	#7 //Clk =0 Cycle 4
	for(j=0;j<=15;j=j+1)
	begin
		Load[j]=0;
	end
	#8 Load[3]=1;
	#8 In=4;
	#9 //Clk =0 Cycle 5
	for(j=0;j<=15;j=j+1)
	begin
		Load[j]=0;
	end
	#10 Load[4]=1;
	#10 In=5;
	#11 //Clk = 0 Cycle 6
	for(j=0;j<=15;j=j+1)
	begin
		Load[j]=0;
	end
	#12 Load[5]=1;
	#12 In=6;
	#13 //Clk = 0 Cycle 7
	for(j=0;j<=15;j=j+1)
	begin
		Load[j]=0;
	end
	#14 Load[6]=1;
	#14 In=7;
	#15 //Clk = 0 Cycle 8
	for(j=0;j<=15;j=j+1)
	begin
		Load[j]=0;
	end
	#16 Load[7]=1;
	#16 In=8;
	#17 //Clk = 0 Cycle 9
	for(j=0;j<=15;j=j+1)
	begin
		Load[j]=0;
	end
	#18 Load[8]=1;
	#18 In=9;
	#19 //Clk = 0 Cycle 10
	for(j=0;j<=15;j=j+1)
	begin
		Load[j]=0;
	end
	#20 Load[9]=1;
	#20 In=10;
	#21 //Clk = 0 Cycle 11
	for(j=0;j<=15;j=j+1)
	begin
		Load[j]=0;
	end
	#22 Load[10]=1;
	#22 In=11;
	#23 //Clk = 0 Cycle 12
	for(j=0;j<=15;j=j+1)
	begin
		Load[j]=0;
	end
	#24 Load[11]=1;
	#24 In=12;
	#25 //Clk = 0 Cycle 13
	for(j=0;j<=15;j=j+1)
	begin
		Load[j]=0;
	end
	#26 Load[12]=1;
	#26 In=13;
	#27 //Clk = 0 Cycle 13
	for(j=0;j<=15;j=j+1)
	begin
		Load[j]=0;
	end
	#28 Load[13]=1;
	#28 In=14;
	#29 //Clk = 0 Cycle 14
	for(j=0;j<=15;j=j+1)
	begin
		Load[j]=0;
	end
	#30 Load[14]=1;
	#30 In=15;
	#31 //Clk = 0 Cycle 15
	for(j=0;j<=15;j=j+1)
	begin
		Load[j]=0;
	end
	#32 Load[15]=1;
	#32 In=16;
join

always 
	#1 Clk = ~Clk;
	
initial #sim_time $finish;           //Especifica cuando termina la simulacion



initial begin
	$dumpfile("RegisterTestBench2.vcd");
	$dumpvars(0,RegisterTestBench2);
	$display(" Test Results" );                  // imprime header
	$monitor("T = %3d,Clk = %3d,In = %3d,Reset = %3d,Load[0] = %3d,Load[1] = %3d,Load[2] = %3d,Load[3] = %3d,Load[4] = %3d,Load[5] = %3d,Load[6] = %3d,Load[7] = %3d,Load[8] = %3d,Load[9] = %3d,Load[10] = %3d,Load[11] = %3d,Load[12] = %3d,Load[13] = %3d,Load[14] = %3d,Load[15] = %3d,Out[0] = %3d,Out[1] = %3d,Out[2] = %3d,Out[3] = %3d,Out[4] = %3d,Out[5] = %3d,Out[6] = %3d,Out[7] = %3d,Out[8] = %3d,Out[9] = %3d,Out[10] = %3d,Out[11] = %3d,Out[12] = %3d,Out[13] = %3d,Out[14] = %3d,Out[15] = %3d",$time,Clk,In,Reset,Load[0],Load[1],Load[2],Load[3],Load[4],Load[5],Load[6],Load[7],Load[8],Load[9],Load[10],Load[11],Load[12],Load[13],Load[14],Load[15],Out[0],Out[1],Out[2],Out[3],Out[4],Out[5],Out[6],Out[7],Out[8],Out[9],Out[10],Out[11],Out[12],Out[13],Out[14],Out[15]);  //imprime se~ales
end

endmodule
//iverilog Register.v RegisterTestBench2.v
//gtkwave RegisterTestBench2.vcd