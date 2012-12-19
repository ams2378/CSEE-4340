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

	.data_o(d.north_q_o),
	.mask_o(d.mask_1)

);

queue s_queue (
	.clk(d.clk),
	.rst(d.rst),
		
	.pop_req_i(d.pop_req_s_i),
	.data_i(d.south_i),
	.valid_i(d.valid_s_i), 

	.data_o(d.south_q_o),
	.mask_o(d.mask_2)	
);

queue e_queue (
	.clk(d.clk),
	.rst(d.rst),
		
	.pop_req_i(d.pop_req_e_i),
	.data_i(d.east_i),
	.valid_i(d.valid_e_i), 

	.data_o(d.east_q_o),
	.mask_o(d.mask_3)	
);

queue w_queue (
	.clk(d.clk),
	.rst(d.rst),
		
	.pop_req_i(d.pop_req_w_i),
	.data_i(d.west_i),
	.valid_i(d.valid_w_i), 

	.data_o(d.west_q_o),
	.mask_o(d.mask_4)
);

queue l_queue (
	.clk(d.clk),
	.rst(d.rst),
		
	.pop_req_i(d.pop_req_l_i),
	.data_i(d.local_i),
	.valid_i(d.valid_l_i), 

	.data_o(d.local_q_o),
	.mask_o(d.mask_5)	
);


endmodule
