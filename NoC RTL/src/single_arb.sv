module single_arb (
		input clk,
		input rst,

		input req_port_addr1_i,
		input req_port_addr2_i,
		input req_port_addr3_i,
		input req_port_addr4_i,
		input req_port_addr5_i,
/*
		input en_n_i,
		input en_s_i,
		input en_e_i,
		input en_w_i,
		input en_l_i,
*/
		input valid;

		output [2:0] req_port_addr_o
		);

logic enable;

//logic [4:0] mask;

/*
logic en_n;
logic en_s;
logic en_e;
logic en_w;
logic en_l;

logic [4:0] requests;
*/
reg [2:0] state;

logic [2:0] req_port_addr;
logic [2:0] req_port_addr_o_temp;

parameter s1 =  3'b000;
parameter s2 =  3'b001;
parameter s3 =  3'b010;
parameter s4 =  3'b011;
parameter s5 =  3'b100;
parameter s6 =  3'b101;


/*
always_comb begin
	en_n = ~req_port_addr1_i | en_n_i;
 	en_s = ~req_port_addr2_i | en_s_i;
	en_e = ~req_port_addr3_i | en_e_i;
	en_w = ~req_port_addr4_i | en_w_i;
	en_l = ~req_port_addr5_i | en_l_i;
	
	enable = en_n & en_s & en_e & en_w & en_l;

	mask[0] = ~en_n_i;
	mask[1] = ~en_s_i;
	mask[2] = ~en_e_i;
	mask[3] = ~en_w_i;
	mask[4] = ~en_l_i;

	requests[0] = req_port_addr1_i;
	requests[1] = req_port_addr2_i;
	requests[2] = req_port_addr3_i;
	requests[3] = req_port_addr4_i;
	requests[4] = req_port_addr5_i;

end
*/


DW_arb_rr #(.n(5)) arb(
	.clk(clk),
	.rst_n(~rst),
	.enable(enable),
	.init_n('1),
	.request(requests),
	.mask(mask),
	
	.grant_index(req_port_addr)
);

always_comb begin
	if (!req_port_addr1_i && !req_port_addr2_i  && !req_port_addr3_i  && !req_port_addr4_i  && !req_port_addr5_i) begin
		req_port_addr_o_temp = 3'b111;
	end else begin
		req_port_addr_o_temp = req_port_addr;
	end
	
end


//FSM
always_ff @(posedge clk) begin
	if (rst)
		state <= s1;
	else case(state)
		s1:  	if (req_port_addr1_i ||  req_port_addr2_i ||  req_port_addr3_i ||  req_port_addr4_i ||  req_port_addr5_i)
				enable <= 1;
				state <= s2;
			else begin
				enable <= 1;
				state <= s1;
			end
		
		s2:	if (valid == 0)
				enable <= 0;
			else if (valid == 1) begin 
				enable <= 0;
				state <= s3;
			end
		
		s3:	if (valid == 0)
				enable <= 0;
			else if (valid == 1) begin 
				enable <= 0;
				state <= s4;
			end

		s4:	if (valid == 0)
				enable <= 0;
			else if (valid == 1) begin 
				enable <= 0;
				state <= s5;
			end

		s5: 	if (valid == 0)
				enable <= 0;
			else if (valid == 1) begin 
				enable <= 0;
				state <= s6;
			end

		s6:	if (valid == 0)
				enable <= 0;
			else if (valid == 1) begin 
				enable <= 1;
				state <= s1;
			end
	endcase
end



assign req_port_addr_o = req_port_addr_o_temp;

endmodule


