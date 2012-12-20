/**
 * @filename  		ifc_fcu.sv 
 *
 * @brief     		This file defines the interfaces for the testbench and DUT for the FCC
 * @authors   		Ayushi Rajeev		<ar3110@columbia.edu>
 *			Ashwin Ramachandran	<ar2648@columbia.edu>	 
 */

interface ifc_fcu ();
   logic rst; 
   logic clk;

   logic [2:0] req_port_addr1_i;
   logic [2:0] req_port_addr2_i;
   logic [2:0] req_port_addr3_i;
   logic [2:0] req_port_addr4_i;
   logic [2:0] req_port_addr5_i;

   logic  granted_n;
   logic  granted_s;
   logic  granted_e;
   logic  granted_w;
   logic  granted_l;

   logic       credit_en_north_i;
   logic       credit_en_south_i;
   logic       credit_en_east_i;
   logic       credit_en_west_i;
   logic       credit_en_local_i;

   logic       grant_access_north_o;
   logic       grant_access_south_o;
   logic       grant_access_east_o;
   logic       grant_access_west_o;
   logic       grant_access_local_o;

		logic valid_north_o;
		logic valid_south_o;
		logic valid_east_o;
		logic valid_west_o;
		logic valid_local_o;

   modport dut (
		input rst,
		input clk,		

		input  granted_n,
		input  granted_s,
		input  granted_e,
		input  granted_w,
		input  granted_l,	
		input  req_port_addr1_i,
		input  req_port_addr2_i, 
		input  req_port_addr3_i,
		input  req_port_addr4_i, 
		input  req_port_addr5_i,

		input  credit_en_north_i,
		input  credit_en_south_i,
		input  credit_en_east_i,
		input  credit_en_west_i,
		input  credit_en_local_i,

		output grant_access_north_o, 
		output grant_access_south_o,
		output grant_access_east_o,
		output grant_access_west_o,
		output grant_access_local_o,

		output valid_north_o, 
		output valid_south_o,
		output valid_east_o,
		output valid_west_o,
		output valid_local_o

		);

endinterface