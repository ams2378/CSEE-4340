/**
* @filename  		cam.sv 
*
* @brief     		Top level file which instantiate every other modules and represents overall microarchitecture
* @authors   		Ashwin Ramachandrar
*  	 
*/


module cam (
	ifc.dut d
	);

wire [31:0] read_addr;
wire [31:0] write_addr;
wire [31:0] match_addr;

wire [32*32-1:0] read_out;

/*
 * instantiate the read decoder
 */
decoder_5_32 read_decoder (
        .decoder_i (d.read_index_i),  
        .decoder_o (read_addr)
        );

/*
 * instantiate the write decoder
 */
decoder_5_32 write_decoder (
	.decoder_i (d.write_index_i),
	.decoder_o (write_addr)
	);

/*
 * instantiate the memory arrays
 */
camreg mem_array (
	.clk(d.clk),
	.rst(d.rst),
	
	.read_i(d.read_i),
	.read_addr_i (read_addr),
	
	.write_i(d.write_i),
	.write_addr_i (write_addr),
	.write_data_i(d.write_data_i),
	
	.search_i(d.search_i),
	.search_data_i(d.search_data_i),

	.read_valid_o(d.read_valid_o),
	.read_out_o (read_out),
	
	.match_o (match_addr)
	);

/*
 * instantiate the mux
 */
multiplexer mux (
	.data_i (read_out),
	.read_address_i (d.read_index_i),
	.data_o (d.read_value_o)
	);

/*
 * instantiate the priority encoder
 */
priorityencoder_32_5 match_encode (
	.inp_i (match_addr),
	.out_o (d.search_index_o),
	.valid_o (d.search_valid_o)
	);

endmodule

