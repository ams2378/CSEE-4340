/**
 * @filename  		top.sv
 *
 * @brief     		Top Level - assign clock, instantiate DUT and Testbench
 * @authors   		Ashwin Ramachandran <ar2648@columbia.edu>
 Ayushi Rajeev <ar3110@columbia.edu>
 *				 
 */


`timescale 1ns/1ps

module top();
   bit clk = 0;
   always #5 clk = ~clk;
   
   initial $vcdpluson;

   ifc_arb IFC(); // instantiate the interface file
   arbiter dut(IFC.dut); 
   tb arb_bench(IFC.bench);
endmodule
