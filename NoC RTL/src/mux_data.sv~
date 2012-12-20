module mux_data  (
	input [15:0] data_n_i,
	input [15:0] data_s_i,
	input [15:0] data_e_i,
	input [15:0] data_w_i,
	input [15:0] data_l_i,

	input [2:0] address_route_i,
	
	output [15:0] data_o
);

logic north = 3'b000;
logic south = 3'b001;
logic east = 3'b010;
logic west = 3'b011;
logic loc = 3'b100;
logic none = 3'b111;

logic [15:0] data;

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
