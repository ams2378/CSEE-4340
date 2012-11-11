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
	
	input clk,
	input rst,

	input pop_req_n_i,
	input pop_req_s_i,
	input pop_req_e_i,
	input pop_req_w_i,
	input pop_req_l_i,

	input [15:0] north_i,		
	input [15:0] south_i,	
	input [15:0] east_i,	
	input [15:0] west_i,	
	input [15:0] local_i,	

	output [15:0] north_o,		
	output [15:0] south_o,	
	output [15:0] east_o,	
	output [15:0] west_o,	
	output [15:0] local_o,	


)


queue n_queue (
	
	.clk (clk),
	.rst (rst),
	.pop_req_i(pop_req_n_i),
	.data_i(north_i),

	.data_o(north_o)	
)

queue s_queue (
	
	.clk (clk),
	.rst (rst),
	.pop_req_i(pop_req_s_i),
	.data_i(south_i),

	.data_o(south_o)	
)

queue e_queue (
	
	.clk (clk),
	.rst (rst),
	.pop_req_i(pop_req_e_i),
	.data_i(east_i),

	.data_o(east_o)	
)

queue w_queue (
	
	.clk (clk),
	.rst (rst),
	.pop_req_i(pop_req_w_i),
	.data_i(west_i),

	.data_o(west_o)	
)

queue l_queue (
	
	.clk (clk),
	.rst (rst),
	.pop_req_i(pop_req_l_i),
	.data_i(local_i),

	.data_o(local_o)	
)


endmodule
