/**
 * @filename  		interface.sv 
 *
 * @brief     		This file defines the interfaces for the testbench and DUT for the queues
 * @authors   		Ayushi Rajeev		<ar3110@columbia.edu>
 *			Ashwin Ramachandran	<ar2648@columbia.edu>
 *	 
 */

interface ifc_queue (input bit clk);
   logic rst;
   logic pop_req_i;
   logic [15:0] data_i;	

   logic [15:0] data_o;

   clocking cb @(posedge clk);
      default output #1;

      output 	rst;
      output 	pop_req_i;
      output 	data_i;	

      input	data_o;
   endclocking

   modport dut (
		input  clk,
		input  rst,
		input  pop_req_i,
		input  data_i, 

		output data_o
		);

   modport bench (clocking cb);
endinterface
