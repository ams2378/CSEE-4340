/**
* @filename  		fcc.sv 
*
* @brief		Flow control counters for all five neighboring buffers     
* @author   		ddl2126	<ddl2126@columbia.edu>
*	     		
*  	 
*/

module fcc(
	input n_incr_i;
	input s_incr_i;
	input e_incr_i;
	input w_incr_i;
	input l_incr_i;

	input n_decr_i, 
	input s_decr_i, 
	input e_decr_i, 
	input w_decr_i, 
	input l_decr_i,

	output credit_en_north,
	output credit_en_south,
	output credit_en_east,
	output credit_en_west,
	output credit_en_local, 
);


/*
 * instantiate the counters
 * north counter */
counter north_counter(
	.incr_i(n_incr_i),
	.decr_i(n_decr_i),
	.credit_en_o(credit_en_north)
);

/*
 * south counter */
counter south_counter(
	.incr_i(s_incr_i),
	.decr_i(s_decr_i),
	.credit_en_o(credit_en_south)
);

/*
 * east counter */
counter east_counter(
	.incr_i(e_incr_i),
	.decr_i(e_decr_i),
	.credit_en_o(credit_en_east)
);

/*
 * west counter */
counter west_counter(
	.incr_i(w_incr_i),
	.decr_i(w_decr_i),
	.credit_en_o(credit_en_west)
);

/*
 * local counter */
counter local_counter(
	.incr_i(l_incr_i),
	.decr_i(l_decr_i),
	.credit_en_o(credit_en_local)
);

endmodule
