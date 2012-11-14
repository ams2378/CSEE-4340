/*-----------------------------------------------------
Design Name : router
File Name   : FF.sv
Function    : Top level file 

author	    : Dechhin Lama <ddl2126@columbia.edu>
*///-----------------------------------------------------


module FF #(parameter WIDTH = 1) (
	input clk,
	input rst,

	input readEn_i,
	input writeEn_i,

	input [WIDTH-1:0] writedat_i,

	output read_valid_o,
	output [WIDTH-1:0] read_o
);

reg [WIDTH-1:0] data;
reg [WIDTH-1:0] read;
reg read_valid;

/*
 * the write block
 */
always_ff @(posedge clk) begin
	if (rst)
		data <= '0;
	else if (writeEn_i)
		data <= writedat_i;
	else
		data <=data;		// keep writing the data back
end

/*
 * the read block
 */
always_ff @(negedge clk) begin
	if (readEn_i) begin
		read <= data;
		read_valid <= 1;
	end
	else begin
		read <= '0;
		read_valid <= 0;
	end
end

assign read_o = read;
assign read_valid_o = read_valid;

endmodule
