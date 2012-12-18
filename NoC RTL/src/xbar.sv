

module xbar (
	ifc_xbar.dut d
);

mux_data  north_data (
	.data_n_i(d.north_q_i),
	.data_s_i(d.south_q_i),
	.data_e_i(d.east_q_i),
	.data_w_i(d.west_q_i),
	.data_l_i(d.local_q_i),

	.address_route_i(d.address_route_n_i),

	.data_o(d.north_o)
); 

mux_data  south_data (
	.data_n_i(d.north_q_i),
	.data_s_i(d.south_q_i),
	.data_e_i(d.east_q_i),
	.data_w_i(d.west_q_i),
	.data_l_i(d.local_q_i),

	.address_route_i(d.address_route_s_i),

	.data_o(d.south_o)
); 

mux_data east_data (
	.data_n_i(d.north_q_i),
	.data_s_i(d.south_q_i),
	.data_e_i(d.east_q_i),
	.data_w_i(d.west_q_i),
	.data_l_i(d.local_q_i),

	.address_route_i(d.address_route_e_i),

	.data_o(d.east_o)
); 

mux_data west_data (
	.data_n_i(d.north_q_i),
	.data_s_i(d.south_q_i),
	.data_e_i(d.east_q_i),
	.data_w_i(d.west_q_i),
	.data_l_i(d.local_q_i),

	.address_route_i(d.address_route_w_i),

	.data_o(d.west_o)
); 

mux_data local_data (
	.data_n_i(d.north_q_i),
	.data_s_i(d.south_q_i),
	.data_e_i(d.east_q_i),
	.data_w_i(d.west_q_i),
	.data_l_i(d.local_q_i),

	.address_route_i(d.address_route_l_i),

	.data_o(d.local_o)
); 


mux_valid north_valid (
	.data_n_i(d.pop_req_n),
	.data_s_i(d.pop_req_s),
	.data_e_i(d.pop_req_e),
	.data_w_i(d.pop_req_w),
	.data_l_i(d.pop_req_l),

	.address_route_i(d.address_route_n_i),

	.data_o(d.valid_n_o)
);

mux_valid south_valid (
	.data_n_i(d.pop_req_n),
	.data_s_i(d.pop_req_s),
	.data_e_i(d.pop_req_e),
	.data_w_i(d.pop_req_w),
	.data_l_i(d.pop_req_l),

	.address_route_i(d.address_route_s_i),

	.data_o(d.valid_s_o)
);

mux_valid east_valid (
	.data_n_i(d.pop_req_n),
	.data_s_i(d.pop_req_s),
	.data_e_i(d.pop_req_e),
	.data_w_i(d.pop_req_w),
	.data_l_i(d.pop_req_l),

	.address_route_i(d.address_route_e_i),

	.data_o(d.valid_e_o)
);

mux_valid west_valid (
	.data_n_i(d.pop_req_n),
	.data_s_i(d.pop_req_s),
	.data_e_i(d.pop_req_e),
	.data_w_i(d.pop_req_w),
	.data_l_i(d.pop_req_l),

	.address_route_i(d.address_route_w_i),

	.data_o(d.valid_w_o)
);

mux_valid local_valid (
	.data_n_i(d.pop_req_n),
	.data_s_i(d.pop_req_s),
	.data_e_i(d.pop_req_e),
	.data_w_i(d.pop_req_w),
	.data_l_i(d.pop_req_l),

	.address_route_i(d.address_route_l_i),

	.data_o(d.valid_l_o)
);


endmodule
