/**
* filename  		arbiter.sv 
* brief			Arbiter module for the router     		
* authors   		Adil sadik <ams2378@columbia.edu>
* date creation		11/11/12	
* 
* 
*	 
*/

module arbiter (
		ifc_arb.dut d
		);

single_arb arb1 (
	.clk(d.clk),
	.rst(d.rst),

	.req_port_addr1_i(d.req_port_addr1_i[0]),
	.req_port_addr2_i(d.req_port_addr2_i[0]),
	.req_port_addr3_i(d.req_port_addr3_i[0]),
	.req_port_addr4_i(d.req_port_addr4_i[0]),
	.req_port_addr5_i(d.req_port_addr5_i[0]),

	.valid(d.valid_n_i),

	.mask_1(d.mask_1),
	.mask_2(d.mask_2),	
	.mask_3(d.mask_3),	
	.mask_4(d.mask_4),	
	.mask_5(d.mask_5),		

	.req_port_addr_o(d.req_port_addr1_o)
);

single_arb arb2 (
	.clk(d.clk),
	.rst(d.rst),

	.req_port_addr1_i(d.req_port_addr1_i[1]),
	.req_port_addr2_i(d.req_port_addr2_i[1]),
	.req_port_addr3_i(d.req_port_addr3_i[1]),
	.req_port_addr4_i(d.req_port_addr4_i[1]),
	.req_port_addr5_i(d.req_port_addr5_i[1]),

	.valid(d.valid_s_i),

	.mask_1(d.mask_1),
	.mask_2(d.mask_2),	
	.mask_3(d.mask_3),	
	.mask_4(d.mask_4),	
	.mask_5(d.mask_5),
		
	.req_port_addr_o(d.req_port_addr2_o)
);

single_arb arb3 (
	.clk(d.clk),
	.rst(d.rst),

	.req_port_addr1_i(d.req_port_addr1_i[2]),
	.req_port_addr2_i(d.req_port_addr2_i[2]),
	.req_port_addr3_i(d.req_port_addr3_i[2]),
	.req_port_addr4_i(d.req_port_addr4_i[2]),
	.req_port_addr5_i(d.req_port_addr5_i[2]),

	.valid(d.valid_e_i),

	.mask_1(d.mask_1),
	.mask_2(d.mask_2),	
	.mask_3(d.mask_3),	
	.mask_4(d.mask_4),	
	.mask_5(d.mask_5),		

	.req_port_addr_o(d.req_port_addr3_o)
);

single_arb arb4 (
	.clk(d.clk),
	.rst(d.rst),

	.req_port_addr1_i(d.req_port_addr1_i[3]),
	.req_port_addr2_i(d.req_port_addr2_i[3]),
	.req_port_addr3_i(d.req_port_addr3_i[3]),
	.req_port_addr4_i(d.req_port_addr4_i[3]),
	.req_port_addr5_i(d.req_port_addr5_i[3]),

	.valid(d.valid_w_i),

	.mask_1(d.mask_1),
	.mask_2(d.mask_2),	
	.mask_3(d.mask_3),	
	.mask_4(d.mask_4),	
	.mask_5(d.mask_5),
		
	.req_port_addr_o(d.req_port_addr4_o)
);

single_arb arb5 (
	.clk(d.clk),
	.rst(d.rst),

	.req_port_addr1_i(d.req_port_addr1_i[4]),
	.req_port_addr2_i(d.req_port_addr2_i[4]),
	.req_port_addr3_i(d.req_port_addr3_i[4]),
	.req_port_addr4_i(d.req_port_addr4_i[4]),
	.req_port_addr5_i(d.req_port_addr5_i[4]),
	
	.valid(d.valid_l_i),

	.mask_1(d.mask_1),
	.mask_2(d.mask_2),	
	.mask_3(d.mask_3),	
	.mask_4(d.mask_4),	
	.mask_5(d.mask_5),		

	.req_port_addr_o(d.req_port_addr5_o)
);




endmodule


