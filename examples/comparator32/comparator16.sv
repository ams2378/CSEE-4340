// A 16-bit comparator composed of 4-bit comparators
module comparator16 ( a_i, b_i, gt_o, lt_o );

	input [15:0] a_i;
	input [15:0] b_i;
	output gt_o;
	output lt_o;
	
	wire [3:0] gt_bits;
	wire [3:0] lt_bits;

	comparator4 sub_comparator_3 (
		.a_i( a_i[15:12] ),
		.b_i( b_i[15:12] ),
		.gt_o( gt_bits[3] ),
		.lt_o( lt_bits[3] )
	);
	
	comparator4 sub_comparator_2 (
		.a_i( a_i[11:8] ),
		.b_i( b_i[11:8] ),
		.gt_o( gt_bits[2] ),
		.lt_o( lt_bits[2] )
	);
	
	comparator4 sub_comparator_1 (
		.a_i( a_i[7:4] ),
		.b_i( b_i[7:4] ),
		.gt_o( gt_bits[1] ),
		.lt_o( lt_bits[1] )
	);
	
	comparator4 sub_comparator_0 (
		.a_i( a_i[3:0] ),
		.b_i( b_i[3:0] ),
		.gt_o( gt_bits[0] ),
		.lt_o( lt_bits[0] )
	);
	
	comparator4 aggregate_comparator (
		.a_i( gt_bits ),
		.b_i( lt_bits ),
		.gt_o( gt_o ),
		.lt_o( lt_o )
	);
	
endmodule