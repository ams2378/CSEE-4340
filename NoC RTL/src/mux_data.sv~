module mux_data  (
	input [15:0] data_n_i,
	input [15:0] data_s_i,
	input [15:0] data_e_i,
	input [15:0] data_w_i,
	input [15:0] data_l_i,

	input [2:0] address_route_i,
	
	output [15:0] data_o
);

//logic north = 3'b001;
//logic south = 3'b010;
//logic east = 3'b100;
//logic west = 3'b011;
//logic loc = 3'b101;
//logic none = 3'b111;

logic [15:0] data;

always_comb begin
	
	case (address_route_i) 
		3'b001:	data = data_n_i;
		3'b010:	data = data_s_i;
		3'b100: 	data = data_e_i;
		3'b011:	data = data_w_i;
		3'b101: 	data = data_l_i;
		3'b111: 	data = '0;   	
	endcase
end


assign data_o = data;

endmodule
