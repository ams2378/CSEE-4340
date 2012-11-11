/*-----------------------------------------------------
Design Name : router
File Name   : router.sv
Function    : Top level file 

author	    : Dechhin Lama <ddl2126@columbia.edu>
*///-----------------------------------------------------


module router (
	ifc.dut d
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


/*
 * instantiate the counters
 * north neighbor counter */
counter north_counter(
	n_incr_i(incr_i)
)



endmodule

