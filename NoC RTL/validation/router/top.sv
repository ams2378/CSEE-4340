/**
 * @filename  		top.sv
 *
 * @brief     		Top Level - assigns clock, instantiates DUT and Testbench
 * @authors   		Ayushi Rajeev		<ar3110@columbia.edu>
 *			Ashwin Ramachandran	<ar2648@columbia.edu>
 */


`timescale 1ns/1ps

module top();
   bit clk = 0;
   always #5 clk = ~clk;
   
   initial $vcdpluson;

   ifc IFC(clk); // instantiate the interface file
   router dut(IFC.dut); 
   tb bench(IFC.bench);
endmodule
