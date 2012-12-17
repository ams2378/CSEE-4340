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
ifc_queue n ();
ifc_queue s ();
ifc_queue e ();
ifc_queue w ();
ifc_queue l ();

assign n.clk = d.clk;
assign s.clk = d.clk;
assign e.clk = d.clk;
assign w.clk = d.clk;
assign l.clk = d.clk;

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

assign n.valid_i = d.valid_n_i;
assign s.valid_i = d.valid_s_i;
assign e.valid_i = d.valid_e_i;
assign w.valid_i = d.valid_w_i;
assign l.valid_i = d.valid_l_i;

assign n.data_o = d.north_q_o;
assign s.data_o = d.south_q_o;
assign e.data_o = d.east_q_o;
assign w.data_o = d.west_q_o;
assign l.data_o = d.local_q_o;

assign n.en_o = d.en_n_o;
assign s.en_o = d.en_s_o;
assign e.en_o = d.en_e_o;
assign w.en_o = d.en_w_o;
assign l.en_o = d.en_l_o;

assign n.req_port_addr1_i = d.req_port_addr1_i[0];
assign n.req_port_addr2_i = d.req_port_addr2_i[0];
assign n.req_port_addr3_i = d.req_port_addr3_i[0];
assign n.req_port_addr4_i = d.req_port_addr4_i[0];
assign n.req_port_addr5_i = d.req_port_addr5_i[0];

assign s.req_port_addr1_i = d.req_port_addr1_i[1];
assign s.req_port_addr2_i = d.req_port_addr2_i[1];
assign s.req_port_addr3_i = d.req_port_addr3_i[1];
assign s.req_port_addr4_i = d.req_port_addr4_i[1];
assign s.req_port_addr5_i = d.req_port_addr5_i[1];

assign e.req_port_addr1_i = d.req_port_addr1_i[2];
assign e.req_port_addr2_i = d.req_port_addr2_i[2];
assign e.req_port_addr3_i = d.req_port_addr3_i[2];
assign e.req_port_addr4_i = d.req_port_addr4_i[2];
assign e.req_port_addr5_i = d.req_port_addr5_i[2];

assign w.req_port_addr1_i = d.req_port_addr1_i[3];
assign w.req_port_addr2_i = d.req_port_addr2_i[3];
assign w.req_port_addr3_i = d.req_port_addr3_i[3];
assign w.req_port_addr4_i = d.req_port_addr4_i[3];
assign w.req_port_addr5_i = d.req_port_addr5_i[3];

assign l.req_port_addr1_i = d.req_port_addr1_i[4];
assign l.req_port_addr2_i = d.req_port_addr2_i[4];
assign l.req_port_addr3_i = d.req_port_addr3_i[4];
assign l.req_port_addr4_i = d.req_port_addr4_i[4];
assign l.req_port_addr5_i = d.req_port_addr5_i[4];


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
