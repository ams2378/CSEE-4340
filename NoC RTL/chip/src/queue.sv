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
	input  grant_i,


	output [15:0] data_o,
	output valid_o,
	output mask_o

);

reg pop_q;

//instantiate DesignWare Queue
DW_fifo_s1_sf #(.width(16), .depth(5)) q (
	.clk(clk),
	.rst_n(~rst),

	.push_req_n(~valid_i),
	.pop_req_n(~pop_q),
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


//reg[2:0] pstate;
reg[2:0] state;
reg mask;


always_ff @(posedge clk) begin
	if (rst) begin
		state <= s1;
		pop_q <= 0;
		mask <= 0;
	end else case(state) 	
		s1:	begin if (grant_i == 0) begin
				state <= s1;
				pop_q <= 0;
				mask <= 0;
			end else if (grant_i ==1 && pop_req_i == 1) begin 
				state <= s2;
				mask <= 1;
				pop_q <= 1;
			end end
		
		s2:	begin if (pop_req_i == 0) begin
				state <= s2;
				pop_q <= 0;
				mask <= 1;
			end else if (pop_req_i == 1) begin 
				state <= s3;
				mask <= 1;
				pop_q <= 1;
			end end

		s3:	begin if (pop_req_i == 0) begin
				state <= s3;
				mask <= 1;
				pop_q <= 0;
			end else if (pop_req_i == 1) begin 
				state <= s4;
				mask <= 1;
				pop_q <= 1;
			end end

		s4: 	begin if (pop_req_i == 0) begin
				state <= s4;
				mask <= 1;
				pop_q <= 0;
			end else if (pop_req_i == 1) begin 
				state <= s5;
				mask <= 1;
				pop_q <= 1;
			end end

		s5:	begin if (pop_req_i == 0) begin
				state <= s5;
				mask <= 1;
				pop_q <= 0;
			end else if (pop_req_i == 1) begin 
				state <= s1;
				mask <= 0;
				pop_q <= 1;
			end end
	endcase
end




assign mask_o = mask;
assign valid_o = pop_q;

endmodule
