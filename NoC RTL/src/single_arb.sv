module single_arb (
		input clk,
		input rst,

		input req_port_addr1_i,
		input req_port_addr2_i,
		input req_port_addr3_i,
		input req_port_addr4_i,
		input req_port_addr5_i,

		input valid,

		input mask_1,
		input mask_2,
		input mask_3,
		input mask_4,
		input mask_5,

		output grant_n,
		output grant_s,
		output grant_e,
		output grant_w,
		output grant_l,

		output [2:0] req_port_addr_o
		);

logic enable;

reg [2:0] state;
logic [4:0] requests;
logic [4:0] masks;

logic [2:0] req_port_addr;
logic [2:0] req_port_addr_o_temp;
logic [2:0] req_port_addr_o_temp2;
logic en_reg;
logic granted;
logic [4:0] grant_one_hot;

//parameter s1 =  3'b000;
//parameter s2 =  3'b001;
//parameter s3 =  3'b010;
//parameter s4 =  3'b011;
//parameter s5 =  3'b100;
//parameter s6 =  3'b101;


always_comb begin
/*

	en_n = ~req_port_addr1_i | en_n_i;
 	en_s = ~req_port_addr2_i | en_s_i;
	en_e = ~req_port_addr3_i | en_e_i;
	en_w = ~req_port_addr4_i | en_w_i;
	en_l = ~req_port_addr5_i | en_l_i;
	
	enable = en_n & en_s & en_e & en_w & en_l;
*/

	masks[0] = mask_1;
	masks[1] = mask_2;
	masks[2] = mask_3;
	masks[3] = mask_4;
	masks[4] = mask_5;

	requests[0] = req_port_addr1_i;
	requests[1] = req_port_addr2_i;
	requests[2] = req_port_addr3_i;
	requests[3] = req_port_addr4_i;
	requests[4] = req_port_addr5_i;



end



DW_arb_rr #(.n(5), .output_mode(1)) arb(
	.clk(clk),
	.rst_n(~rst),
	.enable(enable),
	.init_n('1),
	.request(requests),
	.mask(masks),
	
	.grant(grant_one_hot),
	.grant_index(req_port_addr),
	.granted(en_reg)
);

always_comb begin
	if (!req_port_addr1_i && !req_port_addr2_i  && !req_port_addr3_i  && !req_port_addr4_i  && !req_port_addr5_i && state== 3'b000) begin
		req_port_addr_o_temp = 3'b111;
	end else begin
		req_port_addr_o_temp = req_port_addr;
	end
	
end


//FSM
// or valid or req_port_addr1_i or  req_port_addr2_i or  req_port_addr3_i or  req_port_addr4_i or req_port_addr5_i

always_ff @(posedge clk) begin
	if (rst)
		state <= 3'b000; //s1;
	else case(state)
		3'b000:  begin	

			if (req_port_addr1_i ||  req_port_addr2_i ||  req_port_addr3_i ||  req_port_addr4_i 				||  req_port_addr5_i) begin
				state <= 3'b001; //s2;
				enable <= 1;    // changes
			end else begin
				state <= 3'b000; //s1;
				enable <= 0;
			end
		end
		3'b001: begin	
			if (valid == 0) begin
				state <=  3'b001; //s2;
				enable <= 0;
			end else if (valid == 1) begin
				state <= 3'b010; //s3; 
				enable <= 0;
			end
		end
		3'b010:	begin
			if (valid == 0) begin
				state <=  3'b010; //s3;
				enable <= 0;
			end else if (valid == 1) begin 
				state <= 3'b011;// s4;
				enable <= 0;
			end
		end
		3'b011:	begin
			if (valid == 0) begin
				state <=  3'b011; //s4;
				enable <= 0;
			end else if (valid == 1) begin 
				state <= 3'b100; //s5;
				enable <= 0;
			end
		end
		3'b100: begin
		 	if (valid == 0) begin
				state <=  3'b100; //s5;
				enable <= 0;
			end else if (valid == 1) begin 
				state <= 3'b101; //s6;
				enable <= 0;
			end
		end
		3'b101: begin
			if (valid == 0) begin
				state <=  3'b101; //s6;
				enable <= 0;
			end else if (valid == 1) begin 
				state <= 3'b000; //s1;
				enable <= 0;
			end
		end
	endcase
end


	arb_reg register(
		//.clk(clk),
		.rst(rst),
		
		.write_i(req_port_addr_o_temp),
		.en_i(en_reg),
		
		.read_o(req_port_addr_o_temp2)	
	);




assign req_port_addr_o = req_port_addr_o_temp2;
assign granted = en_reg;

assign grant_n = granted && grant_one_hot[0];
assign grant_s = granted && grant_one_hot[1];
assign grant_e = granted && grant_one_hot[2];
assign grant_w = granted && grant_one_hot[3];
assign grant_l = granted && grant_one_hot[4];

endmodule


