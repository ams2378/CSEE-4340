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
	
	output [15:0] north_o,
	output [15:0] south_o,
	output [15:0] east_o,
	output [15:0] west_o,
	output [15:0] local_o,
	);

/*
 * instantiate the queu buffers
 */
queue inputbuffers(
	.north_i(north_i);
	.south_i(south_i);
	.east_i(east_i);
	.west_i(west_i);
	.local_i(local_i);
	);
	

endmodule

