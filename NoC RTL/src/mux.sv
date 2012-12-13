module mux #(parameter WIDTH =1) (
	input [WIDTH-1:0] data_n_i,
	input [WIDTH-1:0] data_s_i,
	input [WIDTH-1:0] data_e_i,
	input [WIDTH-1:0] data_w_i,
	input [WIDTH-1:0] data_l_i,

	input [3:0] address_route_i,
	
	output [WIDTH-1:0] data_o
);

parameter north = 3'b000;
parameter south = 3'b001;
parameter east = 3'b010;
parameter west = 3'b011;
parameter loc = 3'b100;
parameter none = 3'b111;

logic data [WIDTH-1:0];

always_comb begin
	case (address_route_i) 
		north:	data = data_n_i;
		south:	data = data_s_i;
		east: 	data = data_e_i;
		west:	data = data_w_i;
		loc: 	data = data_l_i;
		none: 	data = '0;   	
	endcase
end


assign data_o = data;

endmodule
