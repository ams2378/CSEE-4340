/*-----------------------------------------------------
Design Name : CAM
File Name   : FF.sv
Function    : Flip flop- modified from basic definition to support matching functionality
*///-----------------------------------------------------

module register (
	input clk,
	input rst,

	input en_i,
	input [2:0] write_i,
	
	output [2:0] read_o
);

reg [2:0] data;
 
reg [2:0] read;


/*
 * the write block
 */
always_ff @(posedge clk) begin
	if (rst)
		data <= '0;
	else if (en_i)
		data <= write_i;
	else
		data <=data;		// keep writing the data back
end

/*
 * the read block
 */

assign read_o = data;

endmodule