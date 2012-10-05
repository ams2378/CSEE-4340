// A 32-bit comparator composed of two 16-bit comparators
module comparator32 ( a_i, b_i, gt_o, lt_o, eq_o );

	input [31:0] a_i;
	input [31:0] b_i;
	output gt_o;
	output lt_o;
	output eq_o;
	
	wire gt_hi;
	wire lt_hi;
	wire gt_lo;
	wire lt_lo;
	
	reg gt_mid;
	reg lt_mid;
	reg eq_mid;

	// The following design offers greater and less than comparisons
	// The design for a simple equals compartor could be written in short behavioral code

	comparator16 sub_comparator_hi (
		.a_i( a_i[31:16] ),
		.b_i( b_i[31:16] ),
		.gt_o( gt_hi ),
		.lt_o( lt_hi )
	);
	
	comparator16 sub_comparator_lo (
		.a_i( a_i[15:0] ),
		.b_i( b_i[15:0] ),
		.gt_o( gt_lo ),
		.lt_o( lt_lo )
	);

	always_comb begin
		casex({gt_hi,lt_hi,gt_lo,lt_lo})
		
			4'b10xx:	begin
							gt_mid=1'b1;
							lt_mid=1'b0;
							eq_mid=1'b0;
						end
			4'b01xx:	begin
							gt_mid=1'b0;
							lt_mid=1'b1;
							eq_mid=1'b0;
						end
			4'b0010:	begin
							gt_mid=1'b1;
							lt_mid=1'b0;
							eq_mid=1'b0;
						end
			4'b0001:	begin
							gt_mid=1'b0;
							lt_mid=1'b1;
							eq_mid=1'b0;
						end
			4'b0000:	begin
							gt_mid=1'b0;
							lt_mid=1'b0;
							eq_mid=1'b1;
						end
		endcase
	end
	
	assign gt_o = gt_mid;
	assign lt_o = lt_mid;
	assign eq_o = eq_mid;
	
endmodule
