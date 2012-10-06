class transaction;
  rand int a;
  rand int b;
  int sum;
  
  function void golden_result;
    sum = a + b;
    $display("%t : %s \n", $realtime, "Computing Golden Result");     
  endfunction

  function bit check_result (int x); 
    return (x == sum);
  endfunction  
endclass

program tb (ifc.bench ds);
  transaction t;
  initial begin
   repeat (10000) begin
     t = new();
     t.randomize();

     // drive inputs for next cycle
     $display("%t : %s \n", $realtime, "Driving New Values");     
     ds.cb.a <= t.a;
     ds.cb.b <= t.b;
     @(ds.cb);
     t.golden_result();
     $display("%t : %s \n", $realtime,  t.check_result(ds.cb.sum)?"Pass":"Fail");     
    end
   end 
     
endprogram
