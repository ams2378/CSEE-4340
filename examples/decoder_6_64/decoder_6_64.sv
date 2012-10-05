//Simple 6 bit to 64 wire decoder, written with a for loop
module decoder_6_64 ( decoder_i, decoder_o );

	input [5:0] decoder_i;
	output [63:0] decoder_o;

	reg [63:0] mid;
	
	always_comb begin
		for ( int iter = 0; iter < 64; iter++ ) begin
		
			mid[iter] = ( decoder_i==iter );
			
		end
	end
	
	assign decoder_o = mid;	

endmodule