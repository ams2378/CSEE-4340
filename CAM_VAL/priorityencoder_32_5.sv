/**
* @filename  		priorityencoder_32_5.sv
*
* @brief     		priority encoder for search operation. outputs the matching search index
* @authors   		Dechhin Lama <ddl2126@columbia.edu>
*  	 
*/

module priorityencoder_32_5(inp_i,out_o,valid_o);

input [31:0] inp_i;
output logic [4:0] out_o;
output logic valid_o;

always_comb begin
  casex (inp_i)
    32'b0000_0000_0000_0000_0000_0000_0000_0001: out_o=0;
    32'b0000_0000_0000_0000_0000_0000_0000_001x: out_o=1; // x stands for dont care
    32'b0000_0000_0000_0000_0000_0000_0000_01xx: out_o=2; // bit positions at "x" will be ignored
    32'b0000_0000_0000_0000_0000_0000_0000_1xxx: out_o=3;
    32'b0000_0000_0000_0000_0000_0000_0001_xxxx: out_o=4;
    32'b0000_0000_0000_0000_0000_0000_001x_xxxx: out_o=5;
    32'b0000_0000_0000_0000_0000_0000_01xx_xxxx: out_o=6;
    32'b0000_0000_0000_0000_0000_0000_1xxx_xxxx: out_o=7;
    32'b0000_0000_0000_0000_0000_0001_xxxx_xxxx: out_o=8;
    32'b0000_0000_0000_0000_0000_001x_xxxx_xxxx: out_o=9;
    32'b0000_0000_0000_0000_0000_01xx_xxxx_xxxx: out_o=10;
    32'b0000_0000_0000_0000_0000_1xxx_xxxx_xxxx: out_o=11;
    32'b0000_0000_0000_0000_0001_xxxx_xxxx_xxxx: out_o=12;
    32'b0000_0000_0000_0000_001x_xxxx_xxxx_xxxx: out_o=13;
    32'b0000_0000_0000_0000_01xx_xxxx_xxxx_xxxx: out_o=14;
    32'b0000_0000_0000_0000_1xxx_xxxx_xxxx_xxxx: out_o=15;
    32'b0000_0000_0000_0001_xxxx_xxxx_xxxx_xxxx: out_o=16;
    32'b0000_0000_0000_001x_xxxx_xxxx_xxxx_xxxx: out_o=17;
    32'b0000_0000_0000_01xx_xxxx_xxxx_xxxx_xxxx: out_o=18;
    32'b0000_0000_0000_1xxx_xxxx_xxxx_xxxx_xxxx: out_o=19;
    32'b0000_0000_0001_xxxx_xxxx_xxxx_xxxx_xxxx: out_o=20;
    32'b0000_0000_001x_xxxx_xxxx_xxxx_xxxx_xxxx: out_o=21;
    32'b0000_0000_01xx_xxxx_xxxx_xxxx_xxxx_xxxx: out_o=22;
    32'b0000_0000_1xxx_xxxx_xxxx_xxxx_xxxx_xxxx: out_o=23;
    32'b0000_0001_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx: out_o=24;
    32'b0000_001x_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx: out_o=25;
    32'b0000_01xx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx: out_o=26;
    32'b0000_1xxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx: out_o=27;
    32'b0001_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx: out_o=28;
    32'b001x_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx: out_o=29;
    32'b01xx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx: out_o=30;
    32'b1xxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx: out_o=31;
    default: out_o=31;
  endcase

    valid_o = inp_i ? 1 : 0;

end

endmodule
