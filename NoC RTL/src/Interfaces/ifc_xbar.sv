/**
 * @filename  		ifc_xbar.sv 
 *
 * @brief     		This file defines the interfaces for the testbench and DUT for the queues
 * @authors   		Ayushi Rajeev		<ar3110@columbia.edu>
 *			Ashwin Ramachandran	<ar2648@columbia.edu>
 *	 
 */

interface ifc_xbar ();
   logic pop_req_n;
   logic pop_req_s;
   logic pop_req_e;
   logic pop_req_w;
   logic pop_req_l;

   logic [2:0] address_route_n_i;
   logic [2:0] address_route_s_i;
   logic [2:0] address_route_e_i;
   logic [2:0] address_route_w_i;
   logic [2:0] address_route_l_i;

   logic [15:0] north_q_i;
   logic [15:0] south_q_i;
   logic [15:0] east_q_i;
   logic [15:0] west_q_i;
   logic [15:0] local_q_i;

   logic [15:0] north_o;
   logic [15:0] south_o;
   logic [15:0] east_o;
   logic [15:0] west_o;
   logic [15:0] local_o;

   logic valid_n_o;
   logic valid_s_o;
   logic valid_e_o;
   logic valid_w_o;
   logic valid_l_o;


   modport dut (
		input  pop_req_n,
		input  pop_req_s,
		input  pop_req_e,
		input  pop_req_w,
		input  pop_req_l,

   		input  address_route_n_i,
   		input  address_route_s_i,
   		input  address_route_e_i,
   		input  address_route_w_i,
   		input  address_route_l_i,

		input  north_q_i,
		input  south_q_i,
		input  east_q_i,
		input  west_q_i,
		input  local_q_i,

		output north_o,
		output south_o,
		output east_o,
		output west_o,
		output local_o,

		output valid_n_o,
		output valid_s_o,
		output valid_e_o,
		output valid_w_o,
		output valid_l_o
		);

endinterface
