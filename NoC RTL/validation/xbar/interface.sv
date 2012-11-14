/**
 * @filename  		interface.sv 
 *
 * @brief     		This file defines the interfaces for the testbench and DUT for the queues
 * @authors   		Ayushi Rajeev		<ar3110@columbia.edu>
 *			Ashwin Ramachandran	<ar2648@columbia.edu>
 *	 
 */

interface ifc_xbar ();
   logic grant_access_north_i;
   logic grant_access_south_i;
   logic grant_access_east_i;
   logic grant_access_west_i;
   logic grant_access_local_i;

   logic [2:0] address_route_n_i;
   logic [2:0] address_route_s_i;
   logic [2:0] address_route_e_i;
   logic [2:0] address_route_w_i;
   logic [2:0] address_route_l_i;

   logic [15:0] pop_northq_i;
   logic [15:0] pop_southq_i;
   logic [15:0] pop_eastq_i;
   logic [15:0] pop_westq_i;
   logic [15:0] pop_localq_i;

   logic [15:0] north_o;
   logic [15:0] south_o;
   logic [15:0] east_o;
   logic [15:0] west_o;
   logic [15:0] local_o;

   modport dut (
		input  grant_access_north_i,
		input  grant_access_south_i,
		input  grant_access_east_i,
		input  grant_access_west_i,
		input  grant_access_local_i,

   		input  address_route_n_i,
   		input  address_route_s_i,
   		input  address_route_e_i,
   		input  address_route_w_i,
   		input  address_route_l_i,

		input  pop_northq_i,
		input  pop_southq_i,
		input  pop_eastq_i,
		input  pop_westq_i,
		input  pop_localq_i,

		output north_o,
		output south_o,
		output east_o,
		output west_o,
		output local_o
		);

   modport bench (
		  output grant_access_north_i,
		  output grant_access_south_i,
		  output grant_access_east_i,
		  output grant_access_west_i,
		  output grant_access_local_i,

   		  output  address_route_n_i,
   		  output  address_route_s_i,
   		  output  address_route_e_i,
   		  output  address_route_w_i,
   		  output  address_route_l_i,

		  output pop_northq_i,
		  output pop_southq_i,
		  output pop_eastq_i,
		  output pop_westq_i,
		  output pop_localq_i,

		  input  north_o, 
		  input  south_o,
		  input  east_o,
		  input  west_o,
		  input  local_o		
		  );
endinterface
