/**
* filename  		inputbuffers.sv 
* brief			instantiating queues to have top level input fifo buffers for each input port     		
* authors   		Adil sadik <ams2378@columbia.edu>
			Dechhin Lama <ddl2126@columbia.edu>
* data creation		11/11/12	
* 
* 
*	 
*/


module inputbuffers (
	ifc_buffer.dut d	
);

/*
 * instantiate the ifc_queue interfaces and map the inpus and
 * outputs from an inputbuffer interface to a queue interface
 */

queue n_queue (
	.clk(d.clk),
	.rst(d.rst),
		
	.pop_req_i(d.pop_req_n_i),
	.data_i(d.north_i),
	.valid_i(d.valid_n_i), 

	.req_port_addr1_i(d.req_port_addr1_i[0]),
	.req_port_addr2_i(d.req_port_addr2_i[0]),
	.req_port_addr3_i(d.req_port_addr3_i[0]),
	.req_port_addr4_i(d.req_port_addr4_i[0]),
	.req_port_addr5_i(d.req_port_addr5_i[0]),

	.data_o(d.north_q_o),
	.en_o(d.en_n_o)

);

queue s_queue (
	.clk(d.clk),
	.rst(d.rst),
		
	.pop_req_i(d.pop_req_s_i),
	.data_i(d.south_i),
	.valid_i(d.valid_s_i), 

	.req_port_addr1_i(d.req_port_addr1_i[1]),
	.req_port_addr2_i(d.req_port_addr2_i[1]),
	.req_port_addr3_i(d.req_port_addr3_i[1]),
	.req_port_addr4_i(d.req_port_addr4_i[1]),
	.req_port_addr5_i(d.req_port_addr5_i[1]),

	.data_o(d.south_q_o),
	.en_o(d.en_s_o)	
);

queue e_queue (
	.clk(d.clk),
	.rst(d.rst),
		
	.pop_req_i(d.pop_req_e_i),
	.data_i(d.east_i),
	.valid_i(d.valid_e_i), 

	.req_port_addr1_i(d.req_port_addr1_i[2]),
	.req_port_addr2_i(d.req_port_addr2_i[2]),
	.req_port_addr3_i(d.req_port_addr3_i[2]),
	.req_port_addr4_i(d.req_port_addr4_i[2]),
	.req_port_addr5_i(d.req_port_addr5_i[2]),

	.data_o(d.east_q_o),
	.en_o(d.en_e_o)	
);

queue w_queue (
	.clk(d.clk),
	.rst(d.rst),
		
	.pop_req_i(d.pop_req_w_i),
	.data_i(d.west_i),
	.valid_i(d.valid_w_i), 

	.req_port_addr1_i(d.req_port_addr1_i[3]),
	.req_port_addr2_i(d.req_port_addr2_i[3]),
	.req_port_addr3_i(d.req_port_addr3_i[3]),
	.req_port_addr4_i(d.req_port_addr4_i[3]),
	.req_port_addr5_i(d.req_port_addr5_i[3]),

	.data_o(d.west_q_o),
	.en_o(d.en_w_o)
);

queue l_queue (
	.clk(d.clk),
	.rst(d.rst),
		
	.pop_req_i(d.pop_req_l_i),
	.data_i(d.local_i),
	.valid_i(d.valid_l_i), 

	.req_port_addr1_i(d.req_port_addr1_i[4]),
	.req_port_addr2_i(d.req_port_addr2_i[4]),
	.req_port_addr3_i(d.req_port_addr3_i[4]),
	.req_port_addr4_i(d.req_port_addr4_i[4]),
	.req_port_addr5_i(d.req_port_addr5_i[4]),

	.data_o(d.local_q_o),
	.en_o(d.en_l_o)	
);


endmodule
