module inputbuffers (
	ifc_buffer.dut d	
);


queue n_queue (
	
	.clk (d.clk),
	.rst (d.rst),
	.pop_req_i(d.pop_req_n_i),
	.data_i(d.north_i),

	.data_o(d.north_o)	
);

queue s_queue (
	
	.clk (d.clk),
	.rst (d.rst),
	.pop_req_i(d.pop_req_s_i),
	.data_i(d.south_i),

	.data_o(d.south_o)	
);

queue e_queue (
	
	.clk (d.clk),
	.rst (d.rst),
	.pop_req_i(d.pop_req_e_i),
	.data_i(d.east_i),

	.data_o(d.east_o)	
);

queue w_queue (
	
	.clk (d.clk),
	.rst (d.rst),
	.pop_req_i(d.pop_req_w_i),
	.data_i(d.west_i),

	.data_o(d.west_o)	
);

queue l_queue (
	
	.clk (d.clk),
	.rst (d.rst),
	.pop_req_i(d.pop_req_l_i),
	.data_i(d.local_i),

	.data_o(d.local_o)	
);


endmodule
