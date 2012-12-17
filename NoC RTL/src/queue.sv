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
	ifc_queue.dut d

);

//instantiate DesignWare Queue
DW_fifo_s1_sf #(.width(16), .depth(5)) q (
	.clk(d.clk),
	.rst_n(d.rst),

	.push_req_n(d.valid_i),
	.pop_req_n(d.pop_req_i),
	.data_in(d.data_i),
	.diag_n('1),
	
	.data_out(d.data_o)
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
assign req_port_addr[0] = d.req_port_addr1_i;
assign req_port_addr[1] = d.req_port_addr2_i;
assign req_port_addr[2] = d.req_port_addr3_i;
assign req_port_addr[3] = d.req_port_addr4_i;
assign req_port_addr[4] = d.req_port_addr5_i;


always_ff @(posedge d.clk) begin
	if (d.rst)
		state <= s1;
	else case(state)
		s1:  	if (req_port_addr == '0)
				en<= 1;
			else if (req_port_addr != '0)
				en<= 0;
				state <= s2;
		
		s2:	if (d.pop_req_i == 0)
				en <= 0;
			else if (d.pop_req_i == 1) begin 
				en <= 0;
				state <= s3;
			end
		
		s3:	if (d.pop_req_i == 0)
				en <= 0;
			else if (d.pop_req_i == 1) begin 
				en <= 0;
				state <= s4;
			end

		s4:	if (d.pop_req_i == 0)
				en <= 0;
			else if (d.pop_req_i == 1) begin 
				en <= 0;
				state <= s5;
			end

		s5: 	if (d.pop_req_i == 0)
				en <= 0;
			else if (d.pop_req_i == 1) begin 
				en <= 0;
				state <= s6;
			end

		s6:	if (d.pop_req_i == 0)
				en <= 0;
			else if (d.pop_req_i == 1) begin 
				en <= 1;
				state <= s1;
			end
	endcase
end

assign d.en_o = en;

endmodule
