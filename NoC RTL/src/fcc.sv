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
 * instantiate ifc_counter interfaces and perform the
 * mapping from ifc_fcc signals to ifc_counter signals
 */
ifc_counter n(d.clk);
ifc_counter s(d.clk);
ifc_counter e(d.clk);
ifc_counter w(d.clk);
ifc_counter l(d.clk);

assign n.rst = d.rst;
assign s.rst = d.rst;
assign e.rst = d.rst;
assign w.rst = d.rst;
assign l.rst = d.rst;

assign n.incr_i = d.n_incr_i;
assign s.incr_i = d.s_incr_i;
assign e.incr_i = d.e_incr_i;
assign w.incr_i = d.w_incr_i;
assign l.incr_i = d.l_incr_i;

assign n.decr_i = d.n_decr_i;
assign s.decr_i = d.s_decr_i;
assign e.decr_i = d.e_decr_i;
assign w.decr_i = d.w_decr_i;
assign l.decr_i = d.l_decr_i;

assign n.credit_en_o = d.credit_en_north_o;
assign s.credit_en_o = d.credit_en_south_o;
assign e.credit_en_o = d.credit_en_east_o;
assign w.credit_en_o = d.credit_en_west_o;
assign l.credit_en_o = d.credit_en_local_o;

/*
 * instantiate the counters
 * north counter
 */
counter north_counter(
	.d(n.dut)
);

/*
 * south counter
 */
counter south_counter(
	.d(s.dut)
);

/*
 * east counter
 */
counter east_counter(
	.d(e.dut)
);

/*
 * west counter
 */
counter west_counter(
	.d(w.dut)
);

/*
 * local counter
 */
counter local_counter(
	.d(l.dut)
);

endmodule
