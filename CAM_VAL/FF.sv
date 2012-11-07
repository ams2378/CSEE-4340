/**
* @filename  		FF.sv 
*
* @brief     		Flip flop- modified from basic definition to support matching functionality
* @authors   		Ashwin Ramachandrar
*  	 
* @modified by		Adil Sadik <ams2378@columbia.edu>
*/

module FF #(parameter WIDTH = 1) (
	input clk,
	input rst,

	input readEn_i,
	input writeEn_i,
	input search_i,

	input [WIDTH-1:0] writedat_i,
	input [WIDTH-1:0] searchn_i,

	output match_o,
	output read_valid_o,
	output [WIDTH-1:0] read_o
);

reg [WIDTH-1:0] data;
 
reg [WIDTH-1:0] read;

reg match;
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
always_comb begin
	if (rst) begin
		read_valid <= 0;
		read <= '0;
	end	
	else if (readEn_i) begin
		read <= data;
		read_valid <= 1;
	end
	else begin
		read <= '0;
		read_valid <= 0;
	end
end

/*
 * equality checking block
 */
always_comb begin

	if (rst)
		match <= '0;		
	else if (search_i) begin
		if (data == searchn_i)
			match <= '1;
		else
			match <= '0;
	end
	else
		match <= '0;
end

assign read_o = read;
assign match_o = match;
assign read_valid_o = read_valid;

endmodule
