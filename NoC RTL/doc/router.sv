/*-----------------------------------------------------
Design Name : router
File Name   : router.sv
Function    : Top level file 

author	    : Dechhin Lama <ddl2126@columbia.edu>
*///-----------------------------------------------------


module router (
	input clk,
	input rst,
	
	input [15:0] north_i,
	input [15:0] south_i,
	input [15:0] east_i,
	input [15:0] west_i,
	input [15:0] local_i,
	
	input n_incr_i,
	input s_incr_i,
	input e_incr_i,
	input w_incr_i,
	input l_incr_i,

	output [15:0] north_o,
	output [15:0] south_o,
	output [15:0] east_o,
	output [15:0] west_o,
	output [15:0] local_o,

	output n_incr_o,
	output s_incr_o,
	output e_incr_o,
	output w_incr_o,
	output l_incr_o
	);

/*
 * instantiate the queue buffers
 
queue inputbuffers(
	.north_i(north_i),
	.south_i(south_i),
	.east_i(east_i),
 	.west_i(west_i),
	.local_i(local_i)
	);
*/	

endmodule

