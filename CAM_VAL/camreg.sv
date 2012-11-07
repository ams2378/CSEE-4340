/**
* @filename  		camreg.sv 
*
* @brief     		Instantiate FF to construct memory module
* @authors   		Ashwin Ramachandrar
*  	 
*/

module camreg (
	input clk,
	input rst,

	input read_i,	
	input [31:0] read_addr_i,
	
	input write_i,
	input [31:0] write_addr_i,
	input [31:0] write_data_i,

	input search_i,
	input [31:0] search_data_i,

	output read_valid_o,
	output [32*32-1:0] read_out_o,
	output [31:0] match_o
	);

wire [31:0] read_valids;

logic do_write;
logic read_valid;

generate
	for (genvar iter = 0; iter < 32 ; iter++) begin
		FF #(.WIDTH(32)) array
			(.clk,
			 .rst,

			 .readEn_i (read_addr_i[iter] & read_i),

			 .writeEn_i (write_addr_i[iter] & write_i),
			 .writedat_i (write_data_i),

			 .search_i,
			 .searchn_i (search_data_i),

			 .match_o (match_o[iter]), // set match output MSB to LSB for priority encoder
			 .read_valid_o (read_valids[iter]),
			 .read_o (read_out_o[32*iter +: 32])
			);
	end
endgenerate

always_comb begin
	if (read_valids == 0)
		read_valid = 0;
	else
		read_valid = 1;
end

assign read_valid_o = read_valid;

endmodule
