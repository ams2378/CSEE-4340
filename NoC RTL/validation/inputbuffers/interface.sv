/**
 * @filename  		interface.sv 
 *
 * @brief     		This file defines the interfaces for the testbench and DUT for the input buffers
 * @authors   		Ayushi Rajeev		<ar3110@columbia.edu>
 *			Ashwin Ramachandran	<ar2648@columbia.edu>
 *	 
 */

interface ifc_buffer (input bit clk);
   logic rst;

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

   logic [15:0] north_q_o;			
   logic [15:0] south_q_o;	
   logic [15:0] east_q_o;	
   logic [15:0] west_q_o;	
   logic [15:0] local_q_o;

   clocking cb @(posedge clk);
      default output #1;

      output 	rst;

      output 	pop_req_n_i;	
      output 	pop_req_s_i;
      output 	pop_req_e_i;
      output 	pop_req_w_i;
      output 	pop_req_l_i;

      output 	north_i;			
      output 	south_i;	
      output 	east_i;	
      output 	west_i;	
      output 	local_i;	

      input 	north_q_o;			
      input 	south_q_o;	
      input 	east_q_o;	
      input 	west_q_o;	
      input 	local_q_o;
   endclocking

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

		output north_q_o, 
		output south_q_o, 
		output east_q_o, 
		output west_q_o, 
		output local_q_o	
		);

   modport bench (clocking cb);
endinterface
