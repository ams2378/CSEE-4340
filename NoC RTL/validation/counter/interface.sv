/**
 * @filename  		interface.sv 
 *
 * @brief     		This file defines the interfaces for the testbench and DUT for the counter
 * @authors   		Ayushi Rajeev		<ar3110@columbia.edu>
 *			Ashwin Ramachandran	<ar2648@columbia.edu>
 *	 
 */

interface ifc_counter (input bit clk);
   logic rst;

   logic incr_i;
   logic decr_i; 

   logic credit_en_o;

   clocking cb @(posedge clk);
	default output #1;

	output rst;

	output incr_i;
	output decr_i;

	input credit_en_o;
   endclocking

   modport dut (
		input clk,
		input rst,

		input  incr_i,
		input  decr_i, 

		output credit_en_o	
		);

   modport bench (clocking cb );
endinterface
