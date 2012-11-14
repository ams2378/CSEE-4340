/**
 * @filename  		top.sv
 *
 * @brief     		Top Level - assigns clock, instantiates DUT and Testbench
 * @authors   		Ashwin Ramachandran <ar2648@columbia.edu>
 Ayushi Rajeev <ar3110@columbia.edu>
 *				 
 */


`timescale 1ns/1ps

module top();
   bit clk = 0;
   always #5 clk = ~clk;
   
   initial $vcdpluson;

   ifc_fcc IFC(); // instantiate the interface file
   fcc dut(IFC.dut); 
   tb fcc_bench(IFC.bench);
endmodule
