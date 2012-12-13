/*-----------------------------------------------------
Design Name : router
File Name   : FF.sv
Function    : Flip flops for saving router's own addresses 

author	    : Dechhin Lama <ddl2126@columbia.edu>
*///-----------------------------------------------------


module FF (
	input clk,
	input rst,
	
	output [7:0] read_data_o
	);

reg [7:0] data;

always_ff @(posedge clk) begin
	if (rst)
		data <= 8'b00010001;
	else
		data <= data;		// keep writing the data back
end

assign read_data_o = data;

endmodule
