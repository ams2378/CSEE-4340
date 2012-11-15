/**
 * @filename  		interface.sv 
 *
 * @brief     		This file defines the interfaces for the testbench and DUT for the FCC
 * @authors   		Ayushi Rajeev		<ar3110@columbia.edu>
 *			Ashwin Ramachandran	<ar2648@columbia.edu>
 *	 
 */

interface ifc_fcc (input bit clk);
   logic rst;

   logic n_incr_i;
   logic s_incr_i;
   logic e_incr_i;
   logic w_incr_i;
   logic l_incr_i;

   logic n_decr_i; 
   logic s_decr_i; 
   logic e_decr_i; 
   logic w_decr_i; 
   logic l_decr_i;

   logic credit_en_north_o;
   logic credit_en_south_o;
   logic credit_en_east_o;
   logic credit_en_west_o;
   logic credit_en_local_o;

   clocking cb @(posedge clk);
	output rst;

	output n_incr_i;
        output s_incr_i;
        output e_incr_i;
        output w_incr_i;
        output l_incr_i;

        output n_decr_i;
        output s_decr_i;
        output e_decr_i;
        output w_decr_i;
        output l_decr_i;

        input  credit_en_north_o;
        input  credit_en_south_o;
        input  credit_en_east_o;
        input  credit_en_west_o;
        input  credit_en_local_o;
   endclocking

   modport dut (
		input clk,
		input rst,

		input  n_incr_i,
		input  s_incr_i,
		input  e_incr_i,
		input  w_incr_i,
		input  l_incr_i,

		input  n_decr_i, 
		input  s_decr_i, 
		input  e_decr_i, 
		input  w_decr_i, 
		input  l_decr_i,

		output credit_en_north_o,
		output credit_en_south_o,
		output credit_en_east_o,
		output credit_en_west_o,
		output credit_en_local_o
		);

   modport bench (clocking cb);
endinterface
