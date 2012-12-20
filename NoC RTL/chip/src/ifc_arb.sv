/**
 * @filename  		ifc_arb.sv 
 *
 * @brief     		The file defines the interfaces for test bench and DUT for the arbiter
 * @authors   		Ashwin Ramachandran <ar2648@columbia.edu>
 			Ayushi Rajeev <ar3110@columbia.edu>
			Dechhin Lama <ddl2126@columbia.edu>
 *	 
 */

interface ifc_arb ();
   logic clk;
   logic rst;	

   logic [4:0] req_port_addr1_i;
   logic [4:0] req_port_addr2_i;	
   logic [4:0] req_port_addr3_i;
   logic [4:0] req_port_addr4_i;
   logic [4:0] req_port_addr5_i;

   logic mask_1;
   logic mask_2;
   logic mask_3;
   logic mask_4;
   logic mask_5;

   logic valid_n_i;
   logic valid_s_i;
   logic valid_e_i;
   logic valid_w_i;
   logic valid_l_i;

   logic grant_n_o;
   logic grant_s_o;
   logic grant_e_o;
   logic grant_w_o;
   logic grant_l_o;

   logic [2:0] req_port_addr1_o;
   logic [2:0] req_port_addr2_o;	
   logic [2:0] req_port_addr3_o;
   logic [2:0] req_port_addr4_o;
   logic [2:0] req_port_addr5_o;

   modport dut (
		input clk,
		input rst,

		input  req_port_addr1_i,
		input  req_port_addr2_i, 
		input  req_port_addr3_i,
		input  req_port_addr4_i,
		input  req_port_addr5_i,

   		input mask_1,
   		input mask_2,
   		input mask_3,
   		input mask_4,
   		input mask_5,

   		input valid_n_i,
   		input valid_s_i,
   		input valid_e_i,
   		input valid_w_i,
   		input valid_l_i,

		output grant_n_o,
   		output grant_s_o,
   		output grant_e_o,
   		output grant_w_o,
   		output grant_l_o,

		output req_port_addr1_o,
		output req_port_addr2_o, 
		output req_port_addr3_o,
		output req_port_addr4_o,
		output req_port_addr5_o
		);

  
endinterface
