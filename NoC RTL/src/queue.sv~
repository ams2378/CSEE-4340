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

	input req_port_addr1_i,
	input req_port_addr2_i,
	input req_port_addr3_i,
	input req_port_addr4_i,
	input req_port_addr5_i,


	output [15:0] data_o,
	output en_o

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
parameter s6 = 3'b101;


reg[2:0] state;
reg en;

wire [4:0] req_port_addr;
assign req_port_addr[0] = req_port_addr1_i;
assign req_port_addr[1] = req_port_addr2_i;
assign req_port_addr[2] = req_port_addr3_i;
assign req_port_addr[3] = req_port_addr4_i;
assign req_port_addr[4] = req_port_addr5_i;


always_ff @(posedge clk) begin
	if (rst)
		state <= s1;
	else case(state)
		s1:  	if (req_port_addr == '0)
				en <= 1;
			else if (req_port_addr != '0) begin
				en <= 0;
				state <= s2;
			end
		
		s2:	if (pop_req_i == 0)
				en <= 0;
			else if (pop_req_i == 1) begin 
				en <= 0;
				state <= s3;
			end
		
		s3:	if (pop_req_i == 0)
				en <= 0;
			else if (pop_req_i == 1) begin 
				en <= 0;
				state <= s4;
			end

		s4:	if (pop_req_i == 0)
				en <= 0;
			else if (pop_req_i == 1) begin 
				en <= 0;
				state <= s5;
			end

		s5: 	if (pop_req_i == 0)
				en <= 0;
			else if (pop_req_i == 1) begin 
				en <= 0;
				state <= s6;
			end

		s6:	if (pop_req_i == 0)
				en <= 0;
			else if (pop_req_i == 1) begin 
				en <= 1;
				state <= s1;
			end
	endcase
end

assign en_o = en;

endmodule
