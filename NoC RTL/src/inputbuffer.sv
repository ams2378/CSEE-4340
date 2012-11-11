module inputbuffer_n (
	
	input clk,
	input rst_n,
	input pop_req_i,
	input [15:0] north_i,		

	output [15:0] north_o

)


queue n_queue (
	
	.clk (clk),
	.rst_n (rst_n),
		
)



