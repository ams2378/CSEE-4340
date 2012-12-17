/**
 * @filename  		ifc_FF.sv 
 *
 * @brief     		This file defines the interfaces for the testbench and DUT for the queues
 * @authors   		Ayushi Rajeev		<ar3110@columbia.edu>
 *			Ashwin Ramachandran	<ar2648@columbia.edu>
 *	 
 */

interface ifc_FF ();
   logic rst;
   logic clk;

   logic [7:0] read_data_o;

   modport dut (
		input clk,
		input rst,
	
		output read_data_o
		);

endinterface
