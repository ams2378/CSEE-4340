module comparator16_test();

reg [15:0] a_i;
reg [15:0] b_i;
logic gt;
logic lt;

comparator16 my_comparator16 (
	.a_i(a_i),
	.b_i(b_i),
	.gt_o(gt),
	.lt_o(lt)
);

initial begin
$vcdpluson;

// making input signals 0 at start

a_i = 16'd0;
b_i = 16'd0;
#5  $display( "a=%h, b=%h, gt?%h lt?%h\n", a_i, b_i, gt, lt );

a_i = 16'd0;
b_i = 16'd1;
#5  $display( "a=%h, b=%h, gt?%h lt?%h\n", a_i, b_i, gt, lt );

a_i = 16'd1;
b_i = 16'd0;
#5  $display( "a=%h, b=%h, gt?%h lt?%h\n", a_i, b_i, gt, lt );

a_i = 16'd1;
b_i = 16'd1;
#5  $display( "a=%h, b=%h, gt?%h lt?%h\n", a_i, b_i, gt, lt );

a_i = 16'd65535;
b_i = 16'd65535;
#5  $display( "a=%h, b=%h, gt?%h lt?%h\n", a_i, b_i, gt, lt );

a_i = 16'd65535;
b_i = 16'd65534;
#5  $display( "a=%h, b=%h, gt?%h lt?%h\n", a_i, b_i, gt, lt );

a_i = 16'd65534;
b_i = 16'd65535;
#5  $display( "a=%h, b=%h, gt?%h lt?%h\n", a_i, b_i, gt, lt );

a_i = 16'd23985;
b_i = 16'd9823;
#5  $display( "a=%h, b=%h, gt?%h lt?%h\n", a_i, b_i, gt, lt );

end

endmodule
