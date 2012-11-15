/*-----------------------------------------------------
Design Name : router
File Name   : FF.sv
Function    : Flip flops for saving router's own addresses 

author	    : Dechhin Lama <ddl2126@columbia.edu>
*///-----------------------------------------------------


module FF #(parameter WIDTH = 1) (
	ifc_FF d
	);

reg [WIDTH-1:0] data;

/*
 * the write block
 */
always_ff @(posedge d.clk) begin
	if (d.rst)
		data <= '0;
	else if (d.write_en_i)
		data <= d.write_data_i;
	else
		data <= data;		// keep writing the data back
end

assign d.read_data_o = data;

endmodule
