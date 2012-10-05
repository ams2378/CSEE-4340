module priorityencoder(inp_i,out_o,valid_o);

input [15:0] inp_i;
output logic [3:0] out_o;
output logic valid_o;

always_comb begin
  casex (inp_i)
    16'b0000_0000_0000_0001: out_o=0;
    16'b0000_0000_0000_001x: out_o=1;// x stands for dont care
    16'b0000_0000_0000_01xx: out_o=2;// bit positions at "x" will be ignored
    16'b0000_0000_0000_1xxx: out_o=3;
    16'b0000_0000_0001_xxxx: out_o=4;
    16'b0000_0000_001x_xxxx: out_o=5;
    16'b0000_0000_01xx_xxxx: out_o=6;
    16'b0000_0000_1xxx_xxxx: out_o=7;
    16'b0000_0001_xxxx_xxxx: out_o=8;
    16'b0000_001x_xxxx_xxxx: out_o=9;
    16'b0000_01xx_xxxx_xxxx: out_o=10;
    16'b0000_1xxx_xxxx_xxxx: out_o=11;
    16'b0001_xxxx_xxxx_xxxx: out_o=12;
    16'b001x_xxxx_xxxx_xxxx: out_o=13;
    16'b01xx_xxxx_xxxx_xxxx: out_o=14;
    16'b1xxx_xxxx_xxxx_xxxx: out_o=15;
    default: out_o=0;
  endcase

  if (inp_i == 0) begin
    valid_o = 0;
  end
  else begin
    valid_o = 1;
  end
end

endmodule
