module decoder_6_64_test();

reg [5:0] decoder_i;
logic [63:0] decoder_o;

decoder_6_64 my_decoder (
	.decoder_i(decoder_i),
	.decoder_o(decoder_o)
);

initial begin
$vcdpluson;

// making input signal 0 at start
decoder_i = 6'd0;

	for ( int iter=0; iter<64; iter++ ) begin

		decoder_i = iter;
		#5
		$display( "decode of input %d is 0x%h\n", iter, decoder_o );

	end

end

endmodule
