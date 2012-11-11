/*-----------------------------------------------------
Design Name :router
File Name   : router.sv
Function    : Top level file 
*///-----------------------------------------------------


module router (
	input clk,
	input rst,
	
	input [15:0] north_i,
	input [15:0] south_i,
	input [15:0] east_i,
	input [15:0] west_i,
	input [15:0] local_i,
	
	input n_iner_i,
	input s_iner_i,
	input e_iner_i,
	input w_iner_i,
	input l_iner_i,

	output [15:0] north_o,
	output [15:0] south_o,
	output [15:0] east_o,
	output [15:0] west_o,
	output [15:0] local_o,

	output n_iner_o,
	output s_iner_o,
	output e_iner_o,
	output w_iner_o,
	output l_iner_o
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

