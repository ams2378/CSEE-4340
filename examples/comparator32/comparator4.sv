module comparator4(a_i,b_i,gt_o,lt_o);
input [3:0] a_i;
input [3:0] b_i;
output logic gt_o;//greater than
output logic lt_o;//less than

always_comb begin

  casex({a_i,b_i})
    // check for first bit
    8'b1xxx_0xxx: begin
                     gt_o=1;
                     lt_o=0;
                   end
    8'b0xxx_1xxx: begin
                     gt_o=0;
                     lt_o=1;
                   end
    // check for second bit
    8'bx1xx_x0xx: begin
                     gt_o=1;
                     lt_o=0;
                   end
    8'bx0xx_x1xx: begin
                     gt_o=0;
                     lt_o=1;
                   end
    // check for third bit
    8'bxx1x_xx0x: begin
                     gt_o=1;
                     lt_o=0;
                   end
    8'bxx0x_xx1x: begin
                     gt_o=0;
                     lt_o=1;
                   end
    // check for fourth bit
    8'bxxx1_xxx0: begin;
                     gt_o=1;
                     lt_o=0;
                   end
    8'bxxx0_xxx1: begin;
                     gt_o=0;
                     lt_o=1;
                   end
    // all other cases are those when a equal to b
    default: begin
               gt_o=0;
               lt_o=0;
             end
  endcase

end
endmodule
