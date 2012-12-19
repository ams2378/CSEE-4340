module pop_req_gen (
	input [2:0] address_route_n;
	input [2:0] q_address;

	input valid_i;
	output pop_req_o;	
);

logic pop_req;

always_comb begin
	if (address_route_n == q_address && valid_i)
		pop_req = 1;
	else
		pop_req = 0;
end

assign pop_req_o = pop_req;

endmodule
