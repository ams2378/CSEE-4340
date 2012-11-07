/**
* @filename  		top.sv
*
* @brief     		top level- assign clock, instantiate dut and testbench
* @authors   		Dechhin Lama <ddl2126@columbia.edu>
*				 
*/


`timescale 1ns/1ps

module top();
   bit clk = 0;
   always #5 clk = ~clk;
 
   initial $vcdpluson;

   ifc IFC(clk); // instantiate the interface file
   cam dut(IFC.dut); 
   tb bench(IFC.bench);
endmodule
