/**
* filename  		inputbuffers.sv 
* brief			instantiating queues to have top level input fifo buffers for each input port     		
* authors   		Adil sadik <ams2378@columbia.edu>
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
ifc_queue n (d.clk);
ifc_queue s (d.clk);
ifc_queue e (d.clk);
ifc_queue w (d.clk);
ifc_queue l (d.clk);

assign n.rst = d.rst;
assign s.rst = d.rst;
assign e.rst = d.rst;
assign w.rst = d.rst;
assign l.rst = d.rst;

assign n.pop_req_i = d.pop_req_n_i;
assign s.pop_req_i = d.pop_req_s_i;
assign e.pop_req_i = d.pop_req_e_i;
assign w.pop_req_i = d.pop_req_w_i;
assign l.pop_req_i = d.pop_req_l_i;

assign n.data_i = d.north_i;	
assign s.data_i = d.south_i;
assign e.data_i = d.east_i;
assign w.data_i = d.west_i;
assign l.data_i = d.local_i;

assign n.data_o = d.north_q_o;
assign s.data_o = d.south_q_o;
assign e.data_o = d.east_q_o;
assign w.data_o = d.west_q_o;
assign l.data_o = d.local_q_o;

queue n_queue (
	.d (n.dut)
);

queue s_queue (
	.d (s.dut)	
);

queue e_queue (
	.d (e.dut)	
);

queue w_queue (
	.d (w.dut)
);

queue l_queue (
	.d (l.dut)	
);


endmodule
