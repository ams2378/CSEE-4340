/*-----------------------------------------------------
Design Name : router
File Name   : FF.sv
Function    : Flip flops for saving router's own addresses 

author	    : Dechhin Lama <ddl2126@columbia.edu>
*///-----------------------------------------------------


module FF (
	ifc_FF.dut d
	);

reg [7:0] data;

always_ff @(posedge d.clk) begin
	if (d.rst)
		data <= d.location;
	else
		data <= data;		// keep writing the data back
end

assign d.read_data_o = data;

endmodule

/*

module FF (
	ifc_FF.dut d
	
	);

reg [7:0] data;

always_ff @(posedge d.clk) begin
	if (d.rst)
		data <= 8'b00100010;
	else
		data <= data;		// keep writing the data back
end

assign d.read_data_o = data;

endmodule

*/
