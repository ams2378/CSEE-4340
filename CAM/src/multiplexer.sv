/*-----------------------------------------------------
Design Name : CAM
File Name   : multiplexer.sv
Function    : multiplexer to route correct data output from CAM
*///-----------------------------------------------------
module multiplexer ( input[32*32-1 : 0] data_i, input[4:0] read_address_i,  output [31:0] data_o );

logic [31:0] data_out;

always_comb begin
	for (int i = 0; i< 32; i++) begin
		if (read_address_i [4:0] == i)
			data_out [31:0] = data_i[ i*32 +: 32];
	end
end

assign data_o = data_out;

endmodule 

