module comparator4_test;

  reg [3:0] a;
  reg [3:0] b;
  wire gt,lt;

  comparator4 mycomp(
    .a_i(a),
    .b_i(b), 
    .lt_o(lt),
    .gt_o(gt));

  initial begin
    $vcdpluson;

    #0
    a = 4'b1100;
    b = 4'b1010;
    #5
    $display("\n\nCycle: 1\n");
    $display("value of lt is %d\n",lt);
    $display("value of gt is %d\n",gt);
    
    #5
    a = 4'b1110;
    b = 4'b1111;
    #5
    $display("\n\nCycle: 2\n");
    $display("value of lt is %d\n",lt);
    $display("value of gt is %d\n",gt);
    
    #5
    a = 4'b1111;
    b = 4'b1111;
    #5
    $display("\n\nCycle: 3\n");
    $display("value of lt is %d\n",lt);
    $display("value of gt is %d\n",gt);
  end
endmodule
