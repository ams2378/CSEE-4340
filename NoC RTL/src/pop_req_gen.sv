module pop_req_gen (
	input [2:0] address_route_n,
	input [2:0] address_route_s,
	input [2:0] address_route_e,
	input [2:0] address_route_w,
	input [2:0] address_route_l,
	
	input [2:0] q_address,

	input valid_n,
	input valid_s,
	input valid_e,
	input valid_w,
	input valid_l,

	output pop_req_o	
);

logic pop_req;

always_comb begin
	if (address_route_n == q_address && valid_n)
		pop_req = 1;
	else if (address_route_s == q_address && valid_s)
		pop_req = 1;
	else if (address_route_e == q_address && valid_e)
		pop_req = 1;
	else if (address_route_w == q_address && valid_w)
		pop_req = 1;
	else if (address_route_l == q_address && valid_l)
		pop_req = 1;
	else
		pop_req = 0;
end

assign pop_req_o = pop_req;

endmodule
