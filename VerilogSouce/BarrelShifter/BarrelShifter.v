module BarrelShifter(shift,shift_val,Rm,ext,out,cin,cout,S);
parameter HIGHZ = 32'hzzzzzzzz;
input [1:0] shift;
input [5:0] shift_val;
input [31:0] Rm;
input ext,S,cin;
output cout;
output wire [31:0] out;
reg cout_1=1'b0;
reg [32:0] LSL_1,LSR_1,ASR_1,ROR_1,LSL,LSR,ASR,ROR;
reg [31:0] buffer;

assign cout = S ? cout_1 : 1'bz; // send value back

always@(*)
begin
  casez(shift_val[4:0])
    5'b00000:
      begin
        if(!ext) begin
          LSL_1 <= {cin,Rm[31:0]};
          LSR_1 <= {cin,Rm[31:0]};
          ASR_1 <= {cin,Rm[31:0]};
          ROR_1 <= {cin,Rm[31:0]};
        end else begin
          LSL_1 <= {1'b0,Rm[31:0]};
          LSR_1 <= {1'b0,Rm[31:0]};
          ASR_1 <= {1'b0,Rm[31:0]};
          ROR_1 <= {Rm[0],cin,Rm[31:1]};
        end
      end
    5'b00001:
      begin
        if(!ext) begin
          LSL_1 <= {cin,Rm[30:0],1'b0};
          LSR_1 <= {cin,1'b0,Rm[31:1]};
          ASR_1 <= {cin,Rm[31],Rm[31:1]};
          ROR_1 <= {cin,Rm[0],Rm[31:1]};
        end else begin
          LSL_1 <= {Rm[31:0],1'b0};
          LSR_1 <= {Rm[0],1'b0,Rm[31:1]};
          ASR_1 <= {Rm[0],Rm[31],Rm[31:1]};
          ROR_1 <= {Rm[1:0],cin,Rm[31:2]};
        end
      end
    5'b00010:
      begin
        if(!ext) begin
          LSL_1 <= {cin,Rm[29:0],2'b00};
          LSR_1 <= {cin,2'b00,Rm[31:2]};
          ASR_1 <= {cin,Rm[31],Rm[31],Rm[31:2]};
          ROR_1 <= {cin,Rm[1:0],Rm[31:2]};
        end else begin
          LSL_1 <= {Rm[30:0],2'b00};
          LSR_1 <= {Rm[1],2'b00,Rm[31:2]};
          ASR_1 <= {Rm[1],Rm[31],Rm[31],Rm[31:2]};
          ROR_1 <= {Rm[2:0],cin,Rm[31:3]};
        end
      end
    5'b00011:
      begin
        if(!ext) begin
            LSL_1 <= {cin,Rm[29:0],2'b0};
            LSR_1 <= {cin,3'b0,Rm[31:3]};
            ASR_1 <= {cin,Rm[31],Rm[31],Rm[31],Rm[31:2]};
            ROR_1 <= {cin,Rm[2:0],Rm[31:3]};
        end else begin
            LSL_1 <= {Rm[29:0],3'b0};
            LSR_1 <= {Rm[2],3'b0,Rm[31:3]};
            ASR_1 <= {Rm[1],Rm[31],Rm[31],Rm[31],Rm[31:2]};
            ROR_1 <= {Rm[3:0],cin,Rm[31:4]};
        end
      end
    5'b00100:
      begin
        if(!ext) begin
          LSL_1 <= {cin,Rm[28:0],3'b0};
          LSR_1 <= {cin,4'b0,Rm[31:4]};
          ASR_1 <= {cin,Rm[31],Rm[31],Rm[31],Rm[31],Rm[31:3]};
          ROR_1 <= {cin,Rm[3:0],Rm[31:4]};
        end else begin
          LSL_1 <= {Rm[28:0],4'b0};
          LSR_1 <= {Rm[3],4'b0,Rm[31:4]};
          ASR_1 <= {Rm[2],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31:3]};
          ROR_1 <= {Rm[4:0],cin,Rm[31:5]};
        end
      end
    5'b00101:
      begin
        if(!ext) begin
          LSL_1 <= {cin,Rm[27:0],4'b0};
          LSR_1 <= {cin,5'b0,Rm[31:5]};
          ASR_1 <= {cin,Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31:4]};
          ROR_1 <= {cin,Rm[4:0],Rm[31:5]};
        end else begin
          LSL_1 <= {Rm[27:0],5'b0};
          LSR_1 <= {Rm[4],5'b0,Rm[31:5]};
          ASR_1 <= {Rm[3],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31:4]};
          ROR_1 <= {Rm[5:0],cin,Rm[31:6]};
        end
      end
    5'b00110:
      begin
        if(!ext) begin
          LSL_1 <= {cin,Rm[26:0],5'b0};
          LSR_1 <= {cin,6'b0,Rm[31:6]};
          ASR_1 <= {cin,Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31:5]};
          ROR_1 <= {cin,Rm[5:0],Rm[31:6]};
        end else begin
          LSL_1 <= {Rm[26:0],6'b0};
          LSR_1 <= {Rm[5],6'b0,Rm[31:6]};
          ASR_1 <= {Rm[4],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31:5]};
          ROR_1 <= {Rm[6:0],cin,Rm[31:7]};
        end
      end
    5'b00111:
      begin
        if(!ext) begin
          LSL_1 <= {cin,Rm[25:0],6'b0};
          LSR_1 <= {cin,7'b0,Rm[31:7]};
          ASR_1 <= {cin,Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31:6]};
          ROR_1 <= {cin,Rm[6:0],Rm[31:7]};
        end else begin
          LSL_1 <= {Rm[25:0],7'b0};
          LSR_1 <= {Rm[6],7'b0,Rm[31:7]};
          ASR_1 <= {Rm[5],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31:6]};
          ROR_1 <= {Rm[7:0],cin,Rm[31:8]};
        end
      end
    5'b01000:
      begin
        if(!ext) begin
          LSL_1 <= {cin,Rm[24:0],7'b0};
          LSR_1 <= {cin,8'b0,Rm[31:8]};
          ASR_1 <= {cin,Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31:7]};
          ROR_1 <= {cin,Rm[7:0],Rm[31:8]};
        end else begin
          LSL_1 <= {Rm[24:0],8'b0};
          LSR_1 <= {Rm[7],8'b0,Rm[31:8]};
          ASR_1 <= {Rm[6],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31:7]};
          ROR_1 <= {Rm[8:0],cin,Rm[31:9]};
        end
      end
    5'b01001:
      begin
        if(!ext) begin
          LSL_1 <= {cin,Rm[23:0],8'b0};
          LSR_1 <= {cin,9'b0,Rm[31:9]};
          ASR_1 <= {cin,Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31:8]};
          ROR_1 <= {cin,Rm[8:0],Rm[31:9]};
        end else begin
          LSL_1 <= {Rm[23:0],9'b0};
          LSR_1 <= {Rm[8],9'b0,Rm[31:9]};
          ASR_1 <= {Rm[7],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31:8]};
          ROR_1 <= {Rm[9:0],cin,Rm[31:10]};
        end
      end
    5'b01010:
      begin
        if(!ext) begin
          LSL_1 <= {cin,Rm[22:0],9'b0};
          LSR_1 <= {cin,10'b0,Rm[31:10]};
          ASR_1 <= {cin,Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31:9]};
          ROR_1 <= {cin,Rm[9:0],Rm[31:10]};
        end else begin
          LSL_1 <= {Rm[22:0],10'b0};
          LSR_1 <= {Rm[9],10'b0,Rm[31:10]};
          ASR_1 <= {Rm[8],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31:9]};
          ROR_1 <= {Rm[10:0],cin,Rm[31:11]};
        end
      end
    5'b01011:
      begin
        if(!ext) begin
          LSL_1 <= {cin,Rm[21:0],10'b0};
          LSR_1 <= {cin,11'b0,Rm[31:11]};
          ASR_1 <= {cin,Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31:10]};
          ROR_1 <= {cin,Rm[10:0],Rm[31:11]};
        end else begin
          LSL_1 <= {Rm[21:0],11'b0};
          LSR_1 <= {Rm[10],11'b0,Rm[31:11]};
          ASR_1 <= {Rm[9],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31:10]};
          ROR_1 <= {Rm[11:0],cin,Rm[31:12]};
        end
      end
    5'b01100:
      begin
        if(!ext) begin
          LSL_1 <= {cin,Rm[20:0],11'b0};
          LSR_1 <= {cin,12'b0,Rm[31:12]};
          ASR_1 <= {cin,Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31:11]};
          ROR_1 <= {cin,Rm[11:0],Rm[31:12]};
        end else begin
          LSL_1 <= {Rm[20:0],12'b0};
          LSR_1 <= {Rm[11],12'b0,Rm[31:12]};
          ASR_1 <= {Rm[10],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31:11]};
          ROR_1 <= {Rm[12:0],cin,Rm[31:13]};
        end
      end
    5'b01101:
      begin
        if(!ext) begin
          LSL_1 <= {cin,Rm[19:0],12'b0};
          LSR_1 <= {cin,13'b0,Rm[31:13]};
          ASR_1 <= {cin,Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31:12]};
          ROR_1 <= {cin,Rm[12:0],Rm[31:13]};
        end else begin
          LSL_1 <= {Rm[19:0],13'b0};
          LSR_1 <= {Rm[12],13'b0,Rm[31:13]};
          ASR_1 <= {Rm[11],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31:12]};
          ROR_1 <= {Rm[13:0],cin,Rm[31:14]};
        end
      end
    5'b01110:
      begin
        if(!ext) begin
          LSL_1 <= {cin,Rm[18:0],13'b0};
          LSR_1 <= {cin,14'b0,Rm[31:14]};
          ASR_1 <= {cin,Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],
                    Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31:13]};
          ROR_1 <= {cin,Rm[13:0],Rm[31:14]};
        end else begin
          LSL_1 <= {Rm[18:0],14'b0};
          LSR_1 <= {Rm[13],14'b0,Rm[31:14]};
          ASR_1 <= {Rm[12],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],
                    Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31:13]};
          ROR_1 <= {Rm[14:0],cin,Rm[31:15]};
        end
      end
    5'b01111:
      begin
        if(!ext) begin
          LSL_1 <= {cin,Rm[17:0],14'b0};
          LSR_1 <= {cin,15'b0,Rm[31:15]};
          ASR_1 <= {cin,Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],
                    Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31:14]};
          ROR_1 <= {cin,Rm[14:0],Rm[31:15]};
        end else begin
          LSL_1 <= {Rm[17:0],15'b0};
          LSR_1 <= {Rm[14],15'b0,Rm[31:15]};
          ASR_1 <= {Rm[13],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],
                    Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31:14]};
          ROR_1 <= {Rm[15:0],cin,Rm[31:16]};
        end
      end
    5'b10001:
      begin
        if(!ext) begin
        LSL_1 <= {cin,Rm[16:0],15'b0};
        LSR_1 <= {cin,16'b0,Rm[31:16]};
        ASR_1 <= {cin,Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],
                  Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31:15]};
          ROR_1 <= {cin,Rm[15:0],Rm[31:16]};
        end else begin
          LSL_1 <= {Rm[16:0],16'b0};
          LSR_1 <= {Rm[15],16'b0,Rm[31:16]};
          ASR_1 <= {Rm[14],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],
                    Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31:15]};
          ROR_1 <= {Rm[16:0],cin,Rm[31:17]};
        end
      end
    5'b10010:
      begin
        if(!ext) begin
          LSL_1 <= {cin,Rm[15:0],16'b0};
          LSR_1 <= {cin,17'b0,Rm[31:17]};
          ASR_1 <= {cin,Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],
                    Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31:16]};
          ROR_1 <= {cin,Rm[16:0],Rm[31:17]};
        end else begin
          LSL_1 <= {Rm[15:0],17'b0};
          LSR_1 <= {Rm[16],17'b0,Rm[31:17]};
          ASR_1 <= {Rm[15],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],
                    Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31:16]};
          ROR_1 <= {Rm[17:0],cin,Rm[31:18]};
        end
      end
    5'b10011:
      begin
        if(!ext) begin
          LSL_1 <= {cin,Rm[14:0],17'b0};
          LSR_1 <= {cin,18'b0,Rm[31:18]};
          ASR_1 <= {cin,Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],
                    Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31:17]};
          ROR_1 <= {cin,Rm[17:0],Rm[31:18]};
        end else begin
          LSL_1 <= {Rm[14:0],18'b0};
          LSR_1 <= {Rm[17],18'b0,Rm[31:18]};
          ASR_1 <= {Rm[16],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],
                    Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31:17]};
          ROR_1 <= {Rm[18:0],cin,Rm[31:19]};
        end
      end
    5'b10100:
      begin
        if(!ext) begin
          LSL_1 <= {cin,Rm[13:0],18'b0};
          LSR_1 <= {cin,19'b0,Rm[31:19]};
          ASR_1 <= {cin,Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],
                    Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],
                    Rm[31:18]};
          ROR_1 <= {cin,Rm[18:0],Rm[31:19]};
        end else begin
          LSL_1 <= {Rm[13:0],19'b0};
          LSR_1 <= {Rm[18],19'b0,Rm[31:19]};
          ASR_1 <= {Rm[17],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],
                    Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],
                    Rm[31:18]};
          ROR_1 <= {Rm[19:0],cin,Rm[31:20]};
        end
      end
    5'b10101:
      begin
        if(!ext) begin
          LSL_1 <= {cin,Rm[12:0],19'b0};
          LSR_1 <= {cin,20'b0,Rm[31:20]};
          ASR_1 <= {cin,Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],
                    Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],
                    Rm[31],Rm[31:19]};
          ROR_1 <= {cin,Rm[19:0],Rm[31:20]};
        end else begin
          LSL_1 <= {Rm[12:0],20'b0};
          LSR_1 <= {Rm[19],20'b0,Rm[31:20]};
          ASR_1 <= {Rm[18],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],
                    Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],
                    Rm[31],Rm[31:19]};
          ROR_1 <= {Rm[20:0],cin,Rm[31:21]};
        end
      end
    5'b10110:
      begin
        if(!ext) begin
          LSL_1 <= {cin,Rm[11:0],20'b0};
          LSR_1 <= {cin,21'b0,Rm[31:21]};
          ASR_1 <= {cin,Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],
                    Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],
                    Rm[31],Rm[31],Rm[31:20]};
          ROR_1 <= {cin,Rm[20:0],Rm[31:21]};
        end else begin
          LSL_1 <= {Rm[11:0],21'b0};
          LSR_1 <= {Rm[20],21'b0,Rm[31:21]};
          ASR_1 <= {Rm[19],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],
                    Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],
                    Rm[31],Rm[31],Rm[31:20]};
          ROR_1 <= {Rm[21:0],cin,Rm[31:22]};
        end
      end
    5'b10111:
      begin
        if(!ext) begin
          LSL_1 <= {cin,Rm[10:0],21'b0};
          LSR_1 <= {cin,22'b0,Rm[31:22]};
          ASR_1 <= {cin,Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],
                    Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],
                    Rm[31],Rm[31],Rm[31],Rm[31:21]};
          ROR_1 <= {cin,Rm[21:0],Rm[31:22]};
        end else begin
          LSL_1 <= {Rm[10:0],22'b0};
          LSR_1 <= {Rm[21],22'b0,Rm[31:22]};
          ASR_1 <= {Rm[20],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],
                    Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],
                    Rm[31],Rm[31],Rm[31],Rm[31:21]};
          ROR_1 <= {Rm[22:0],cin,Rm[31:23]};
        end
      end
    5'b11000:
      begin
        if(!ext) begin
          LSL_1 <= {cin,Rm[9:0],22'b0};
          LSR_1 <= {cin,23'b0,Rm[31:23]};
          ASR_1 <= {cin,Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],
                    Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],
                    Rm[31],Rm[31],Rm[31],Rm[31],Rm[31:22]};
          ROR_1 <= {cin,Rm[22:0],Rm[31:23]};
        end else begin
          LSL_1 <= {Rm[9:0],23'b0};
          LSR_1 <= {Rm[22],23'b0,Rm[31:23]};
          ASR_1 <= {Rm[21],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],
                    Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],
                    Rm[31],Rm[31],Rm[31],Rm[31],Rm[31:22]};
          ROR_1 <= {Rm[23:0],cin,Rm[31:24]};
        end
      end
    5'b11001:
      begin
        if(!ext) begin
          LSL_1 <= {cin,Rm[8:0],23'b0};
          LSR_1 <= {cin,24'b0,Rm[31:24]};
          ASR_1 <= {cin,Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],
                    Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],
                    Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31:23]};
          ROR_1 <= {cin,Rm[23:0],Rm[31:24]};
        end else begin
          LSL_1 <= {Rm[8:0],24'b0};
          LSR_1 <= {Rm[23],24'b0,Rm[31:24]};
          ASR_1 <= {Rm[22],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],
                    Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],
                    Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31:23]};
          ROR_1 <= {Rm[24:0],cin,Rm[31:25]};
        end
      end
    5'b11010:
      begin
        if(!ext) begin
          LSL_1 <= {cin,Rm[7:0],24'b0};
          LSR_1 <= {cin,25'b0,Rm[31:25]};
          ASR_1 <= {cin,Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],
                    Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],
                    Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31:24]};
          ROR_1 <= {cin,Rm[24:0],Rm[31:25]};
        end else begin
          LSL_1 <= {Rm[7:0],25'b0};
          LSR_1 <= {Rm[24],25'b0,Rm[31:25]};
          ASR_1 <= {Rm[23],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],
                    Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],
                    Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31:24]};
          ROR_1 <= {Rm[25:0],cin,Rm[31:26]};
        end
      end
    5'b11011:
      begin
        if(!ext) begin
          LSL_1 <= {cin,Rm[6:0],25'b0};
          LSR_1 <= {cin,26'b0,Rm[31:26]};
          ASR_1 <= {cin,Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],
                    Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],
                    Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31:25]};
          ROR_1 <= {cin,Rm[25:0],Rm[31:26]};
        end else begin
          LSL_1 <= {Rm[6:0],26'b0};
          LSR_1 <= {Rm[25],26'b0,Rm[31:26]};
          ASR_1 <= {Rm[24],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],
                    Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],
                    Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31:25]};
          ROR_1 <= {Rm[26:0],cin,Rm[31:27]};
        end
      end
    5'b11100:
      begin
        if(!ext) begin
          LSL_1 <= {cin,Rm[5:0],26'b0};
          LSR_1 <= {cin,27'b0,Rm[31:27]};
          ASR_1 <= {cin,Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],
                    Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],
                    Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31:26]};
          ROR_1 <= {cin,Rm[26:0],Rm[31:27]};
        end else begin
          LSL_1 <= {Rm[5:0],27'b0};
          LSR_1 <= {Rm[26],27'b0,Rm[31:27]};
          ASR_1 <= {Rm[25],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],
                    Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],
                    Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31:26]};
          ROR_1 <= {Rm[27:0],cin,Rm[31:28]};
        end
      end
    5'b11101:
      begin
        if(!ext) begin
          LSL_1 <= {cin,Rm[4:0],27'b0};
          LSR_1 <= {cin,28'b0,Rm[31:28]};
          ASR_1 <= {cin,Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],
                    Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],
                    Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31:27]};
          ROR_1 <= {cin,Rm[27:0],Rm[31:28]};
        end else begin
          LSL_1 <= {Rm[4:0],28'b0};
          LSR_1 <= {Rm[27],28'b0,Rm[31:28]};
          ASR_1 <= {Rm[26],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],
                    Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],
                    Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31:27]};
          ROR_1 <= {Rm[28:0],cin,Rm[31:29]};
        end
      end
    5'b11110:
      begin
        if(!ext) begin
          LSL_1 <= {cin,Rm[3:0],28'b0};
          LSR_1 <= {cin,29'b0,Rm[31:29]};
          ASR_1 <= {cin,Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],
                    Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],
                    Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31:28]};
          ROR_1 <= {cin,Rm[28:0],Rm[31:29]};
        end else begin
          LSL_1 <= {Rm[3:0],29'b0};
          LSR_1 <= {Rm[28],29'b0,Rm[31:29]};
          ASR_1 <= {Rm[27],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],
                    Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],
                    Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31:28]};
          ROR_1 <= {Rm[29:0],cin,Rm[31:30]};
        end
      end
    5'b11111:
      begin
        if(!ext) begin
          LSL_1 <= {cin,Rm[2:0],29'b0};
          LSR_1 <= {cin,30'b0,Rm[31:30]};
          ASR_1 <= {cin,Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],
                    Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],
                    Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],
                    Rm[31:29]};
          ROR_1 <= {cin,Rm[29:0],Rm[31:30]};
        end else begin
          LSL_1 <= {Rm[2:0],30'b0};
          LSR_1 <= {Rm[29],30'b0,Rm[31:30]};
          ASR_1 <= {Rm[28],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],
                    Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],
                    Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],
                    Rm[31:29]};
          ROR_1 <= {Rm[30:0],cin,Rm[31]};
        end
      end
  endcase
end

always@(*)
begin
  casez({shift_val[5],shift_val[4:0]==5'b00000})
    2'b00:
    begin
      LSL <= LSL_1;
      LSR <= LSR_1;
      ASR <= ASR_1;
      ROR <= ROR_1;
    end
    2'b01:
    begin
      LSL <= LSL_1;
      LSR <= LSR_1;
      ASR <= ASR_1;
      ROR <= ROR_1;
    end
    2'b10:
    begin
      LSL <= {Rm[0],32'h00000000};
      LSR <= {Rm[31],32'h00000000};
      ASR <= {Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],
      Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],
      Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31]};
      if(!ext)
        ROR <= {cin,Rm[31:0]};
      else
        ROR <= {cin,Rm[31:0]};
    end
    2'b11:
    begin
      LSL <= 33'h000000000;
      LSR <= 33'h000000000;
      ASR <= {Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],
      Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],
      Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31],Rm[31]};
      ROR <= ROR_1;
    end
  endcase
end
always@(*)
begin
  casez(shift)
  2'b00:
    begin
      {cout_1,buffer} = LSL;
    end
  2'b01:
    begin
     {cout_1,buffer} = LSR;
    end
  2'b10:
    begin
     {cout_1,buffer} = ASR;
    end
  2'b11:
    begin
     {cout_1,buffer} = ROR;
    end
  endcase
end

assign out = buffer;

endmodule
