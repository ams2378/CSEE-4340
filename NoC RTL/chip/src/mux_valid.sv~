module mux_valid  (
	input  data_n_i,
	input  data_s_i,
	input  data_e_i,
	input  data_w_i,
	input  data_l_i,

	input [2:0] address_route_i,
	
	output data_o
);

logic north = 3'b000;
logic south = 3'b001;
logic east = 3'b010;
logic west = 3'b011;
logic loc = 3'b100;
logic none = 3'b111;

logic data;

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
