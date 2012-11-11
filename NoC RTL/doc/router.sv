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
 * north queue */
queue north_buffer(
	.clk(clk),
	.rst(rst),

	.north_i(data_i)	
	);

/*
 * south queue */
queue south_buffer(
	.clk(clk),
	.rst(rst),

	.south_i(data_i)	
	);

/*
 * east queue */
queue east_buffer(
	.clk(clk),
	.rst(rst),

	.east_i(data_i)	
	);

/*
 * west queue */
queue west_buffer(
	.clk(clk),
	.rst(rst),

	.west_i(data_i)	
	);

/*
 * local queue */
queue local_buffer(
	.clk(clk),
	.rst(rst),

	.local_i(data_i)	
	);



endmodule

