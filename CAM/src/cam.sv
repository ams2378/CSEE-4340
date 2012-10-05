/*-----------------------------------------------------
Design Name : CAM
File Name   : cam.sv
Function    : Top level file which instantiate every other modules and represents overall microarchitecture
*///-----------------------------------------------------

module cam (
	input clk,
	input rst,
	
	input read_i,
	input [4:0] read_index_i,

	input write_i,
	input [4:0] write_index_i,
	input [31:0] write_data_i,

	input search_i,
	input [31:0] search_data_i,

	output read_valid_o,
	output [31:0] read_value_o,
	
	output search_valid_o,
	output [4:0] search_index_o
	);

wire [31:0] read_addr;
wire [31:0] write_addr;
wire [31:0] match_addr;

wire [32*32-1:0] read_out;

/*
 * instantiate the read decoder
 */
decoder_5_32 read_decoder (
        .decoder_i (read_index_i),  
        .decoder_o (read_addr)
        );

/*
 * instantiate the write decoder
 */
decoder_5_32 write_decoder (
	.decoder_i (write_index_i),
	.decoder_o (write_addr)
	);

/*
 * instantiate the memory arrays
 */
camreg mem_array (
	.clk,
	.rst,
	
	.read_i,
	.read_addr_i (read_addr),
	
	.write_i,
	.write_addr_i (write_addr),
	.write_data_i,
	
	.search_i,
	.search_data_i,

	.read_valid_o,
	.read_out_o (read_out),
	
	.match_o (match_addr)
	);

/*
 * instantiate the mux
 */
multiplexer mux (
	.data_i (read_out),
	.read_address_i (read_index_i),
	.data_o (read_value_o)
	);

/*
 * instantiate the priority encoder
 */
priorityencoder_32_5 match_encode (
	.inp_i (match_addr),
	.out_o (search_index_o),
	.valid_o (search_valid_o)
	);

endmodule
