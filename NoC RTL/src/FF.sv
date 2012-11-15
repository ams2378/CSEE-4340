/*-----------------------------------------------------
Design Name : router
File Name   : FF.sv
Function    : Flip flops for saving router's own addresses 

author	    : Dechhin Lama <ddl2126@columbia.edu>
*///-----------------------------------------------------


module FF #(parameter WIDTH = 1) (
	input clk,
	input rst,
	input write_en_i,
	input [WIDTH-1:0] write_data_i,
	
	output [WIDTH-1:0] read_data_o
);

reg [WIDTH-1:0] data;

/*
 * the write block
 */
always_ff @(posedge clk) begin
	if (rst)
		data <= '0;
	else if (write_en_i)
		data <= write_data_i;
	else
		data <= data;		// keep writing the data back
end

assign read_data_o = data;

endmodule
