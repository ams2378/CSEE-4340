/**
* filename  		queue.sv 
* brief			Simple queue with width 5 and input data length of 16 bits     		
* authors   		Dechhin Lama (ddl2126@columbia.edu)
* data creation		11/11/12	
* 
* 
*	 
*/


module queue (
	input  clk,
	input  rst,
		
	input  pop_req_i,
	input  [15:0] data_i,
	input  valid_i, 


	output [15:0] data_o,
	output mask_o

);

//instantiate DesignWare Queue
DW_fifo_s1_sf #(.width(16), .depth(5)) q (
	.clk(clk),
	.rst_n(~rst),

	.push_req_n(~valid_i),
	.pop_req_n(~pop_req_i),
	.data_in(data_i),
	.diag_n('1),
	
	.data_out(data_o)
);


//FSM
parameter s1 = 3'b000;
parameter s2 = 3'b001;
parameter s3 = 3'b010;
parameter s4 = 3'b011;
parameter s5 = 3'b100;


reg[2:0] state;
reg mask;


always_ff @(posedge clk) begin
	if (rst)
		state <= s1;
	else case(state)		
		s1:	if (pop_req_i == 0)
				mask <= 0;
			else if (pop_req_i == 1) begin 
				mask <= 1;
				state <= s2;
			end
		
		s2:	if (pop_req_i == 0)
				mask <= 1;
			else if (pop_req_i == 1) begin 
				mask <= 1;
				state <= s3;
			end

		s3:	if (pop_req_i == 0)
				mask <= 1;
			else if (pop_req_i == 1) begin 
				mask <= 1;
				state <= s4;
			end

		s4: 	if (pop_req_i == 0)
				mask <= 1;
			else if (pop_req_i == 1) begin 
				mask <= 1;
				state <= s5;
			end

		s5:	if (pop_req_i == 0)
				mask <= 1;
			else if (pop_req_i == 1) begin 
				mask <= 0;
				state <= s1;
			end
	endcase
end

assign mask_o = mask;

endmodule
