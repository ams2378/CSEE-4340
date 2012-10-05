module comparator32_test();

reg [31:0] a_i;
reg [31:0] b_i;
logic gt;
logic lt;
logic eq;

comparator32 my_comparator32 (
	.a_i(a_i),
	.b_i(b_i),
	.gt_o(gt),
	.lt_o(lt),
	.eq_o(eq)
);

initial begin
$vcdpluson;

// making input signals 0 at start

a_i = 32'd0;
b_i = 32'd0;
#5  $display( "a=%h, b=%h, gt?%h lt?%h, eq?%h\n", a_i, b_i, gt, lt, eq );

a_i = 32'd0;
b_i = 32'd1;
#5  $display( "a=%h, b=%h, gt?%h lt?%h, eq?%h\n", a_i, b_i, gt, lt, eq );

a_i = 32'd1;
b_i = 32'd0;
#5  $display( "a=%h, b=%h, gt?%h lt?%h, eq?%h\n", a_i, b_i, gt, lt, eq );

a_i = 32'd1;
b_i = 32'd1;
#5  $display( "a=%h, b=%h, gt?%h lt?%h, eq?%h\n", a_i, b_i, gt, lt, eq );

a_i = 32'd4294967295;
b_i = 32'd4294967295;
#5  $display( "a=%h, b=%h, gt?%h lt?%h, eq?%h\n", a_i, b_i, gt, lt, eq );

a_i = 32'd4294967295;
b_i = 32'd4294967294;
#5  $display( "a=%h, b=%h, gt?%h lt?%h, eq?%h\n", a_i, b_i, gt, lt, eq );

a_i = 32'd4294967294;
b_i = 32'd4294967295;
#5  $display( "a=%h, b=%h, gt?%h lt?%h, eq?%h\n", a_i, b_i, gt, lt, eq );

a_i = 32'h7777_7777;
b_i = 32'h5555_5555;
#5  $display( "a=%h, b=%h, gt?%h lt?%h, eq?%h\n", a_i, b_i, gt, lt, eq );

end

endmodule
