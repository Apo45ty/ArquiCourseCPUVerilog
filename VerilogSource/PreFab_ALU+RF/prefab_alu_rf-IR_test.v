module prefab_alu_rf;

parameter sim_time = 750*2; // Num of Cycles * 2 

reg [31:0] Pcin;
reg [19:0] RSLCT;
reg Clk, RESET, LOADPC, LOAD,IR_CU;
wire [31:0] Rn,Rm,Rs,PCout,in;
//RegisterFile(input [31:0] in,Pcin,input [19:0] RSLCT,input Clk, RESET, LOADPC, LOAD,IR_CU, output [31:0] Rn,Rm,Rs,PCout);
RegisterFile RF(in,Pcin,RSLCT,Clk, RESET, LOADPC, LOAD,IR_CU, Rn,Rm,Rs,PCout);

//reg  [31:0] A,B; //Rn Rm
reg [4:0] OP;
reg [3:0] FLAGS;
reg S,ALU_OUT;
wire [31:0] Out;
wire [3:0] FLAGS_OUT;

//ARM_ALU(input wire [31:0] A,B,input wire[4:0] OP,input wire [3:0] FLAGS,output wire [31:0] Out,output wire [3:0] FLAGS_OUT, input wire S,ALU_OUT,);
ARM_ALU alu(Rn,Rm, OP, FLAGS, in,FLAGS_OUT,S,ALU_OUT);

initial fork
	//Clk 0 
	Clk = 0 ; RESET = 1 ; Pcin = 32'bz ;  LOADPC = 0 ; LOAD = 0 ;IR_CU = 1 ; RSLCT[3:0] = 0 ; RSLCT[7:4] = 0 ; RSLCT[11:8] = 0 ; RSLCT[15:12] = 0 ; RSLCT[19:16] = 0 ; OP=17; FLAGS=0; S=0;ALU_OUT=0;
	//Clk 1 (Rising Edge) 
	#1 RESET = 0 ; #1 Pcin = 32'bz ; #1 LOADPC = 0 ; #1 LOAD = 0 ; #1 IR_CU = 1 ; #1 RSLCT[3:0] = 0 /* Rn */ ; #1 RSLCT[7:4] = 0 /* Rm */; #1 RSLCT[11:8] = 0 /* Rs */; #1 RSLCT[15:12] = 0 /* Rd */; #1 RSLCT[19:16] = 0 /* Rn */ ; #1 OP=16;#1 FLAGS=0;#1 S=0;#1 ALU_OUT=0;
join

always 
	#1 Clk = ~Clk;
	
initial #sim_time $finish; 

initial begin
	$dumpfile("prefab_alu_rf.vcd");
	$dumpvars(0,prefab_alu_rf);
	$display(" Test Results" );
	$monitor("time = %3d ,Pcin = %3d , in = %3d , LOADPC = %3d , LOAD = %3d , IR_CU = %3d , RSLCT = %3h, Rn = %3d ,Rm = %3d ,Rs = %3d ,PCout = %3d,OP=%3d;FLAGS=0; S=%1b;ALU_OUT=%1b;",$time,Pcin, in, LOADPC, LOAD, IR_CU, RSLCT,Rn,Rm,Rs,PCout,OP,FLAGS,S,ALU_OUT);
end

endmodule
//iverilog Buffer32_32.v Decoder4x16.v Multiplexer2x1_32b.v Register.v RegisterFile.v ARM_ALU.v prefab_alu_rf.v