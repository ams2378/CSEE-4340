/**
* @filename  		xbar.sv 
*    		

* @author   		Dechhin Lama	<ddl2126@columbia.edu>
			Adil Sadik  	<ams2378@columbia.edu>
*	     		
*  	 
*/

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


pop_req_gen pop_north (
	.address_route_n(d.address_route_n_i),
	.address_route_s(d.address_route_s_i),
	.address_route_e(d.address_route_e_i),
	.address_route_w(d.address_route_w_i),
	.address_route_l(d.address_route_l_i),
	

	.q_address(3'b001),
	
	.valid_n(d.valid_n_i),
	.valid_s(d.valid_s_i),
	.valid_e(d.valid_e_i),
	.valid_w(d.valid_w_i),
	.valid_l(d.valid_l_i),

	.pop_req_o(d.pop_req_n)
);


pop_req_gen pop_south (
	.address_route_n(d.address_route_n_i),
	.address_route_s(d.address_route_s_i),
	.address_route_e(d.address_route_e_i),
	.address_route_w(d.address_route_w_i),
	.address_route_l(d.address_route_l_i),

	.q_address(3'b010),
	
	.valid_n(d.valid_n_i),
	.valid_s(d.valid_s_i),
	.valid_e(d.valid_e_i),
	.valid_w(d.valid_w_i),
	.valid_l(d.valid_l_i),

	.pop_req_o(d.pop_req_s)
);


pop_req_gen pop_east (
	.address_route_n(d.address_route_n_i),
	.address_route_s(d.address_route_s_i),
	.address_route_e(d.address_route_e_i),
	.address_route_w(d.address_route_w_i),
	.address_route_l(d.address_route_l_i),

	.q_address(3'b011),
	
	.valid_n(d.valid_n_i),
	.valid_s(d.valid_s_i),
	.valid_e(d.valid_e_i),
	.valid_w(d.valid_w_i),
	.valid_l(d.valid_l_i),

	.pop_req_o(d.pop_req_e)
);


pop_req_gen pop_west (
	.address_route_n(d.address_route_n_i),
	.address_route_s(d.address_route_s_i),
	.address_route_e(d.address_route_e_i),
	.address_route_w(d.address_route_w_i),
	.address_route_l(d.address_route_l_i),

	.q_address(3'b100),
	
	.valid_n(d.valid_n_i),
	.valid_s(d.valid_s_i),
	.valid_e(d.valid_e_i),
	.valid_w(d.valid_w_i),
	.valid_l(d.valid_l_i),

	.pop_req_o(d.pop_req_w)
);


pop_req_gen pop_local (
	.address_route_n(d.address_route_n_i),
	.address_route_s(d.address_route_s_i),
	.address_route_e(d.address_route_e_i),
	.address_route_w(d.address_route_w_i),
	.address_route_l(d.address_route_l_i),

	.q_address(3'b101),
	
	.valid_n(d.valid_n_i),
	.valid_s(d.valid_s_i),
	.valid_e(d.valid_e_i),
	.valid_w(d.valid_w_i),
	.valid_l(d.valid_l_i),

	.pop_req_o(d.pop_req_l)
);





endmodule
