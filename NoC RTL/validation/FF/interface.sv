/**
 * @filename  		interface.sv 
 *
 * @brief     		This file defines the interfaces for the testbench and DUT for the queues
 * @authors   		Ayushi Rajeev		<ar3110@columbia.edu>
 *			Ashwin Ramachandran	<ar2648@columbia.edu>
 *	 
 */

interface ifc_FF #(parameter WIDTH = 1) (input bit clk);
   logic rst;

   logic write_en_i;
   logic [WIDTH-1:0] write_data_i;	

   logic [WIDTH-1:0] read_data_o;

   clocking cb @(posedge clk);
      default output #1;

   	output rst;
   	
	output write_en_i;
   	output write_data_i;	

   	input  read_data_o;
   endclocking

   modport dut (
		input clk,
		input rst,

		input write_en_i,
		input write_data_i,
	
		output read_data_o
		);

   modport bench (clocking cb);
endinterface
