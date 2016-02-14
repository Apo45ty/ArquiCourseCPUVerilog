module BarrelShifterTestBench;

parameter sim_time = 750*2; // Num of Cycles * 2 
reg [31:0] Rs,Rm,IR;
reg SR29_IN;
wire SR29_OUT;
wire [31:0] Out;
//BarrelShifter(input [31] Rs,Rm,IR,input SR29_IN,output SR29_OUT,output [31:0] Out);
BarrelShifter bs(Rs,Rm,IR,SR29_IN,SR29_OUT,Out);


initial fork
	Rs=0;Rm=0;IR=0;SR29_IN=0;
	#1 Rs=1;#1 Rm=2;#1 IR[4]=1;#1 SR29_IN=0;
	#2 Rs=1;#2 Rm=4; #2 SR29_IN=0;
	#3 Rs=1;#3 Rm=8; #3 SR29_IN=0;
	#4 Rs=8;#4 Rm=1; #4 SR29_IN=0;
	#10 Rs=1;#10 Rm=2;#10 IR[6:5]=1;#10 SR29_IN=0;
	#11 Rs=1;#11 Rm=4; #11 SR29_IN=0;
	#12 Rs=1;#12 Rm=8; #12 SR29_IN=0;
	#13 Rs=8;#13 Rm=1; #13 SR29_IN=0;
	#20 Rs=1;#20 Rm=2;#20 IR[6:5]=2;#20 SR29_IN=0;
	#21 Rs=1;#21 Rm=4; #21 SR29_IN=0;
	#22 Rs=1;#22 Rm=8; #22 SR29_IN=0;
	#23 Rs=8;#23 Rm=1; #23 SR29_IN=0;
	#24 Rs=8;#24 Rm=32'hF0000001; #24 SR29_IN=0;
	#30 Rs=1;#30 Rm=2;#30 IR[6:5]=3;#30 SR29_IN=0;
	#31 Rs=1;#31 Rm=4; #31 SR29_IN=0;
	#32 Rs=1;#32 Rm=8; #32 SR29_IN=0;
	#33 Rs=8;#33 Rm=1; #33 SR29_IN=0;
	#34 Rs=8;#34 Rm=32'hF0000001; #34 SR29_IN=0;
	#40 IR[11:8]=0;#40 IR[7:0]=0;#40 IR[27:25]=1;#40 IR[4]=0;#40 SR29_IN=0;
	#41 IR[11:8]=8;#41 IR[7:0] =1 ; #41 SR29_IN=0;
	#50 Rs=0;#50 Rm=0;#50 IR[27:25]=3'b101;#50 SR29_IN=0;
join
	
initial #sim_time $finish; 

initial begin
	$dumpfile("BarrelShifterTestBench.vcd");
	$dumpvars(0,BarrelShifterTestBench);
	$display(" Test Results" );
	$monitor("Rs=%8h,Rm=%8h,IR=%8h,Out=%8h,SR29_IN=%1b,SR29_OUT=%1b",Rs,Rm,IR,Out,SR29_IN,SR29_OUT);
end

endmodule
//iverilog BarrelShifter.v BarrelShifterTestBench.v
//reference 1 http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.dui0497a/CIHDDCIF.html