/**
 * @filename  		ifc_queue.sv 
 *
 * @brief     		This file defines the interfaces for the testbench and DUT for the queues
 * @authors   		Ayushi Rajeev		<ar3110@columbia.edu>
 *			Ashwin Ramachandran	<ar2648@columbia.edu>
 *	 
 */

interface ifc_queue ();
   logic rst;
   logic clk;	

   logic pop_req_i;
   logic [15:0] data_i;
   logic valid_i;	

   logic req_port_addr1_i;
   logic req_port_addr2_i;
   logic req_port_addr3_i;
   logic req_port_addr4_i;
   logic req_port_addr5_i;

   logic [15:0] data_o;
   logic en_o;


   modport dut (
		input  clk,
		input  rst,
		
		input  pop_req_i,
		input  data_i,
		input  valid_i, 

		input req_port_addr1_i,
		input req_port_addr2_i,
		input req_port_addr3_i,
		input req_port_addr4_i,
		input req_port_addr5_i,


		output data_o,
		output en_o
		);

endinterface
