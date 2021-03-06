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

   ifc_agu IFC(); // instantiate the interface file
   address_gen dut(IFC.dut); 
   tb addr_bench(IFC.bench);
endmodule
