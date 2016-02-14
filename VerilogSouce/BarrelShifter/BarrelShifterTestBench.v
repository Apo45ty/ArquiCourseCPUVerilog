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
	#2 Rs=1;#2 Rm=2;#2 IR[6:5]=1;#2 SR29_IN=0;
	#3 Rs=1;#3 Rm=2;#3 IR[6:5]=2;#3 SR29_IN=0;
	#4 Rs=1;#4 Rm=2;#4 IR[6:5]=3;#4 SR29_IN=0;
	#5 Rs=0;#5 Rm=0;#5 IR[27:25]=1;#5 IR[4]=0;#5 SR29_IN=0;
	#6 Rs=0;#6 Rm=0;#6 IR[27:25]=3'b101;#6 SR29_IN=0;
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