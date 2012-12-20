`timescale 1ns/1ps

module top();
   bit clk = 0;
   always #5 clk = ~clk;
 
   initial $vcdpluson;

   ifc IFC(clk); // instantiate the interface file
   ff dut(IFC.dut); 
   tb bench(IFC.bench);
endmodule
