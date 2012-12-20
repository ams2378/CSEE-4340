/**
 * @filename  		ifc_buffer.sv 
 *
 * @brief     		This file defines the interfaces for the testbench and DUT for the input buffers
 * @authors   		Ayushi Rajeev		<ar3110@columbia.edu>
 *			Ashwin Ramachandran	<ar2648@columbia.edu>
 *	 
 */

interface ifc_buffer ();
   logic rst;
   logic clk;

   logic pop_req_n_i;	
   logic pop_req_s_i;
   logic pop_req_e_i;
   logic pop_req_w_i;
   logic pop_req_l_i;

   logic [15:0] north_i;			
   logic [15:0] south_i;	
   logic [15:0] east_i;	
   logic [15:0] west_i;	
   logic [15:0] local_i;

   logic valid_n_i;
   logic valid_s_i;
   logic valid_e_i;
   logic valid_w_i;
   logic valid_l_i;

   logic [15:0] north_q_o;			
   logic [15:0] south_q_o;	
   logic [15:0] east_q_o;	
   logic [15:0] west_q_o;	
   logic [15:0] local_q_o;

   logic mask_1;
   logic mask_2;
   logic mask_3;
   logic mask_4;
   logic mask_5;

   logic valid_n_o;
   logic valid_s_o;
   logic valid_e_o;
   logic valid_w_o;
   logic valid_l_o;

   logic grant_n_i;
   logic grant_s_i;
   logic grant_e_i;
   logic grant_w_i;
   logic grant_l_i;


   modport dut (
		input  clk,
		input  rst,

		input  pop_req_n_i, 
		input  pop_req_s_i,
		input  pop_req_e_i,
		input  pop_req_w_i,
		input  pop_req_l_i,

		input  north_i, 
		input  south_i, 
		input  east_i, 
		input  west_i, 
		input  local_i, 

		input valid_n_i,
		input valid_s_i,
		input valid_e_i,
		input valid_w_i,
		input valid_l_i,

		input grant_n_i,
		input grant_s_i,
		input grant_e_i,
		input grant_w_i,
		input grant_l_i,
		
		output valid_n_o,
		output valid_s_o,
		output valid_e_o,
		output valid_w_o,
		output valid_l_o,

		output north_q_o, 
		output south_q_o, 
		output east_q_o, 
		output west_q_o, 
		output local_q_o,

		output mask_1, 
		output mask_2,
		output mask_3,
		output mask_4,
		output mask_5	
		);

endinterface
