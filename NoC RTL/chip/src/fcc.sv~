/**
* @filename  		fcc.sv 
*
* @brief		Flow control counters for all five neighboring buffers     
* @author   		Dechhin Lama	<ddl2126@columbia.edu>
*	     		
*  	 
*/

module fcc(
	ifc_fcc.dut d	
);


/*
 * instantiate the counters
 * north counter
 */
counter north_counter(
	.clk(d.clk),
	.rst(d.rst),

	.incr_i(d.n_incr_i),
	.decr_i(d.n_decr_i), 

	.credit_en_o(d.credit_en_north_o)	
);

/*
 * south counter
 */
counter south_counter(
	.clk(d.clk),
	.rst(d.rst),

	.incr_i(d.s_incr_i),
	.decr_i(d.s_decr_i), 

	.credit_en_o(d.credit_en_south_o)	
);

/*
 * east counter
 */
counter east_counter(
	.clk(d.clk),
	.rst(d.rst),

	.incr_i(d.e_incr_i),
	.decr_i(d.e_decr_i), 

	.credit_en_o(d.credit_en_east_o)	
);

/*
 * west counter
 */
counter west_counter(
	.clk(d.clk),
	.rst(d.rst),

	.incr_i(d.w_incr_i),
	.decr_i(d.w_decr_i), 

	.credit_en_o(d.credit_en_west_o)	

);

/*
 * local counter
 */
counter local_counter(
	.clk(d.clk),
	.rst(d.rst),

	.incr_i(d.l_incr_i),
	.decr_i(d.l_decr_i), 

	.credit_en_o(d.credit_en_local_o)	

);

endmodule
