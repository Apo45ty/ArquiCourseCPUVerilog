module memory (inout [31:0] Data, output reg MFC, input MFA, ReadWrite, input [7:0] Address, input wordByte,Reset);

//dataOut: bus to return value for Load instruction
//dataIn: bus to input value to store fot Store instruction
//MFA: memory function active (memory on)
//MFC: memory function complete (memory finished)
//readWrite: load or store, 1 for load/read, 0 for store/write
//byteWord: 1 for byte, 0 for word
//halfDoubleWord: 1 for halfword, 0 for doubleword
reg [31:0] Data_Buff;
reg [7:0] Mem[0:255];///////////////////////////////////////////////////////////////////
//Mem represents the 256 spaces available in memory, 1 byte each
wire [7:0] dataByte[0:3];
//4 bytes to store a 32 bit value
reg [7:0] tempAddress;

assign dataByte[0] = Data[31:24];
assign dataByte[1] = Data[23:16];
assign dataByte[2] = Data[15:8];
assign dataByte[3] = Data[7:0];
assign Data = Data_Buff;
integer i; 

//****************for testing purposes ***********************

integer   fd, code, index;
reg [7:0] data[3:0];

always@(posedge Reset) begin 
	$display("Dumping ROM...");
	index = 0;
	while (index < 255) begin
		$display("%d Memory Content Binary=%b Decimal=%d,Hex=%h",index,Mem[index],Mem[index],Mem[index]);
		index = index + 1;
	end
	$display("Loading test program to ROM...");
	fd = $fopen("memory.dat","r"); 
	index = 0;
	while (!($feof(fd))) begin
		code = $fscanf(fd, "%b %b %b %b\n", data[0],data[1],data[2],data[3]);
		Mem[index]=data[0];
		Mem[index+1]=data[1];
		Mem[index+2]=data[2];
		Mem[index+3]=data[3];
		$display("%d Reading from file=%b %b %b %b, Memory Content=%b",index,data[0],data[1],data[2],data[3],Mem[index]);
		index = index + 4;
	end
	while (index < 255) begin
		Mem[index]=0;
		index = index + 1;
	end
  	$fclose(fd);
  	$display("Test Program loaded in ROM...");
	$display("Memory");
	index = 0;
	while (index < 255) begin
		$display("%d Memory Content Binary=%b Decimal=%d,Hex=%h",index,Mem[index],Mem[index],Mem[index]);
		index = index + 1;
	end
  	$display("Finished");
	Data_Buff = 32'hzzzz_zzzz;
end

//*************************************************************
always @ (posedge MFA)//********************************

if(MFA) begin
	$display("Memory Function Active");
	MFC = 0;Data_Buff = 32'hzzzz_zzzz;
	$display("Memory Function Complete: %b", MFC);
//---0--Store/Write to memory------
    if(ReadWrite==0)begin
//------Byte------	
	  if(!wordByte) begin
		$display("Store a byte");
		Mem[Address] <= dataByte[3];
		Mem[Address+1] <= 8'b0;
		Mem[Address+2] <= 8'b0;
		Mem[Address+3] <= 8'b0;
		$display("Storing Least significant byte %h in address %d", dataByte[3], Address);
		$display("Mem[Address]: %h", Mem[Address]);
		end
//------Word------
	  else begin
		$display("Store a word");
		Mem[Address] <= dataByte[3];
		Mem[Address+1] <= dataByte[2];
		Mem[Address+2] <= dataByte[1];
		Mem[Address+3] <= dataByte[0];
		$display("Mem[Address]: %h", Mem[Address]);	
		$display("Mem[Address+1]: %h", Mem[Address+1]);	
		$display("Mem[Address+2]: %h", Mem[Address+2]);	
		$display("Mem[Address+3]: %h", Mem[Address+3]);	
	end

//--1---Load/Read from memory------
end else begin
	 if(wordByte) begin
			  Data_Buff[31:24] <= Mem[Address];
			  Data_Buff[23:16] <= Mem[Address+1];
			  Data_Buff[15:8] <= Mem[Address+2];
			  Data_Buff[7:0] <= Mem[Address+3];
	 end else begin
			  Data_Buff[7:0] <= Mem[Address];
			  Data_Buff[15:8] <= 8'b0;
			  Data_Buff[23:16] <= 8'b0;
			  Data_Buff[31:24] <= 8'b0;
			end
	end 
//Finished writing to memory
$display("Memory Function Complete: %b", MFC);
while(MFA==1)begin 
	#1 MFC = 1; 
end // busy waiting
MFC = 0; 
Data_Buff = 32'hzzzz_zzzz; // errase value from memory
end


endmodule

//iverilog -o memory MYMEM256B.v