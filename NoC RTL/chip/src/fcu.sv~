/**
* filename  		fcu.sv 
* brief			Flow Control Unit- implements credit based flow control    		
* authors   		Adil sadik <ams2378@columbia.edu>
* data creation		11/11/12	
* 
* 
*	 
*/



module fcu (
	ifc_fcu.dut d
	);


single_fcu fcu_north (

	.clk (d.clk),
	.rst(d.rst),

	.granted(d.granted_n),
	.req_port_addr_i(d.req_port_addr1_i),
	.credit_en_i(d.credit_en_north_i),
	.grant_access_o(d.valid_north_o)
);

single_fcu fcu_south (

	.clk (d.clk),
	.rst(d.rst),

	.granted(d.granted_s),
	.req_port_addr_i(d.req_port_addr2_i),
	.credit_en_i(d.credit_en_south_i),
	.grant_access_o(d.valid_south_o)
);

single_fcu fcu_east (

	.clk (d.clk),
	.rst(d.rst),

	.granted(d.granted_e),
	.req_port_addr_i(d.req_port_addr3_i),
	.credit_en_i(d.credit_en_east_i),
	.grant_access_o(d.valid_east_o)
);

single_fcu fcu_west (

	.clk (d.clk),
	.rst(d.rst),

	.granted(d.granted_w),
	.req_port_addr_i(d.req_port_addr4_i),
	.credit_en_i(d.credit_en_west_i),
	.grant_access_o(d.valid_west_o)
);

single_fcu fcu_local (

	.clk (d.clk),
	.rst(d.rst),

	.granted(d.granted_l),
	.req_port_addr_i(d.req_port_addr5_i),
	.credit_en_i(d.credit_en_local_i),
	.grant_access_o(d.valid_local_o)
);


always_comb begin
	if (d.req_port_addr1_i != 3'b111 && d.credit_en_north_i && !d.rst)
		d.grant_access_north_o = 1;
	else 
		d.grant_access_north_o = 0;

	if (d.req_port_addr2_i != 3'b111 && d.credit_en_south_i && !d.rst)
		d.grant_access_south_o = 1;
	else
		d.grant_access_south_o = 0;

	if (d.req_port_addr3_i != 3'b111 && d.credit_en_east_i && !d.rst)
		d.grant_access_east_o = 1;
	else
		d.grant_access_east_o = 0;

	if (d.req_port_addr4_i != 3'b111 && d.credit_en_west_i && !d.rst)
		d.grant_access_west_o = 1;
	else
		d.grant_access_west_o = 0;

	if (d.req_port_addr5_i != 3'b111 && d.credit_en_local_i && !d.rst)
		d.grant_access_local_o = 1;
	else 
		d.grant_access_local_o = 0;

end


endmodule
