/**
* @filename  		noc.sv 
*

* @author   		Dechhin Lama	<ddl2126@columbia.edu>
			Adil Sadik  	<ams2378@columbia.edu>
*	     		
*  	 
*/

module noc(
	ifc_noc.dut d
);

logic [15:0] north_1_1;
logic n_valid_1_1;
logic n_incr_1_1;

logic [15:0] east_1_1;
logic e_valid_1_1;
logic e_incr_1_1;

logic[15:0] north_1_2;
logic n_valid_1_2;
logic n_incr_1_2;

logic [15:0] east_1_2;
logic e_valid_1_2;
logic e_incr_1_2;

logic [15:0] south_1_2;
logic s_valid_1_2;
logic s_incr_1_2;

logic [15:0] north_1_3;
logic n_valid_1_3;
logic n_incr_1_3;

logic [15:0] east_1_3;
logic e_valid_1_3;
logic e_incr_1_3;

logic [15:0] south_1_3;
logic s_valid_1_3;
logic s_incr_1_3;

logic [15:0] east_1_4;
logic e_valid_1_4;
logic e_incr_1_4;

logic [15:0] south_1_4;
logic s_valid_1_4;
logic s_incr_1_4;

logic [15:0] north_2_1;
logic n_valid_2_1;
logic n_incr_2_1;

logic [15:0] west_2_1;
logic w_valid_2_1;
logic w_incr_2_1;

logic [15:0] east_2_1;
logic e_valid_2_1;
logic e_incr_2_1;

logic [15:0] north_2_2;
logic n_valid_2_2;
logic n_incr_2_2;

logic [15:0] west_2_2;
logic w_valid_2_2;
logic w_incr_2_2;

logic [15:0] east_2_2;
logic e_valid_2_2;
logic e_incr_2_2;

logic [15:0] south_2_2;
logic s_valid_2_2;
logic s_incr_2_2;

logic [15:0] north_2_3;
logic n_valid_2_3;
logic n_incr_2_3;

logic [15:0] west_2_3;
logic w_valid_2_3;
logic w_incr_2_3;

logic [15:0] east_2_3;
logic e_valid_2_3;
logic e_incr_2_3;

logic [15:0] south_2_3;
logic s_valid_2_3;
logic s_incr_2_3;

logic [15:0] west_2_4;
logic w_valid_2_4;
logic w_incr_2_4;

logic [15:0] east_2_4;
logic e_valid_2_4;
logic e_incr_2_4;

logic [15:0] south_2_4;
logic s_valid_2_4;
logic s_incr_2_4;

logic [15:0] north_3_1;
logic n_valid_3_1;
logic n_incr_3_1;

logic [15:0] west_3_1;
logic w_valid_3_1;
logic w_incr_3_1;

logic [15:0] east_3_1;
logic e_valid_3_1;
logic e_incr_3_1;

logic [15:0] north_3_2;
logic n_valid_3_2;
logic n_incr_3_2;

logic [15:0] west_3_2;
logic w_valid_3_2;
logic w_incr_3_2;

logic [15:0] east_3_2;
logic e_valid_3_2;
logic e_incr_3_2;

logic [15:0] south_3_2;
logic s_valid_3_2;
logic s_incr_3_2;

logic [15:0] north_3_3;
logic n_valid_3_3;
logic n_incr_3_3;

logic [15:0] west_3_3;
logic w_valid_3_3;
logic w_incr_3_3;

logic [15:0] east_3_3;
logic e_valid_3_3;
logic e_incr_3_3;

logic [15:0] south_3_3;
logic s_valid_3_3;
logic s_incr_3_3;

logic [15:0] west_3_4;
logic w_valid_3_4;
logic w_incr_3_4;

logic [15:0] east_3_4;
logic e_valid_3_4;
logic e_incr_3_4;

logic [15:0] south_3_4;
logic s_valid_3_4;
logic s_incr_3_4;

logic [15:0] north_4_1;
logic n_valid_4_1;
logic n_incr_4_1;

logic [15:0] west_4_1;
logic w_valid_4_1;
logic w_incr_4_1;

logic [15:0] north_4_2;
logic n_valid_4_2;
logic n_incr_4_2;

logic [15:0] west_4_2;
logic w_valid_4_2;
logic w_incr_4_2;

logic [15:0] south_4_2;
logic s_valid_4_2;
logic s_incr_4_2;

logic [15:0] north_4_3;
logic n_valid_4_3;
logic n_incr_4_3;

logic [15:0] west_4_3;
logic w_valid_4_3;
logic w_incr_4_3;

logic [15:0] south_4_3;
logic s_valid_4_3;
logic s_incr_4_3;

logic [15:0] south_4_4;
logic s_valid_4_4;
logic s_incr_4_4;

logic [15:0] west_4_4;
logic w_valid_4_4;
logic w_incr_4_4;



router router_1_1(
	.clk(d.clk),
	.rst(d.rst),
	
	.location(8'b00010001),	
	
	.north_i(south_1_2),			//data
	.south_i('0),
	.east_i(west_2_1),
	.west_i('0),
	.local_i(d.local_1_1_i),
	
	.valid_n_i(s_valid_1_2),		//valid
	.valid_s_i('0),
	.valid_e_i(w_valid_2_1),
	.valid_w_i('0),
	.valid_l_i(d.valid_1_1_i),

	.n_incr_i(s_incr_1_2),			//incr
	.s_incr_i('0),	
	.e_incr_i(w_incr_2_1),
	.w_incr_i('0),
	.l_incr_i(d.incr_1_1_i),

	.north_o(north_1_1),
	.south_o('0),
	.east_o(east_1_1),
	.west_o('0),
	.local_o(d.local_1_1_o),

	.valid_n_o(n_valid_1_1),
	.valid_s_o('0),	
	.valid_e_o(e_valid_1_1),
	.valid_w_o('0),
	.valid_l_o(d.valid_1_1_o),

	.n_incr_o(n_incr_1_1),
	.s_incr_o('0),	
	.e_incr_o(e_incr_1_1),
	.w_incr_o('0),
	.l_incr_o(d.incr_1_1_o)
);




router router_1_2(
	.clk(d.clk),
	.rst(d.rst),
	
	.location(8'b00010010),	
	
	.north_i(south_1_3),
	.south_i(north_1_1),
	.east_i(west_2_2),
	.west_i('0),
	.local_i(d.local_1_2_i),
	
	.valid_n_i(s_valid_1_3),
	.valid_s_i(n_valid_1_1),
	.valid_e_i(w_valid_2_2),
	.valid_w_i('0),
	.valid_l_i(d.valid_1_2_i),

	.n_incr_i(s_incr_1_3),
	.s_incr_i(n_incr_1_1),	
	.e_incr_i(w_incr_2_2),
	.w_incr_i('0),
	.l_incr_i(d.incr_1_2_i),

	.north_o(north_1_2),
	.south_o(south_1_2),
	.east_o(east_1_2),
	.west_o('0),
	.local_o(d.local_1_2_o),

	.valid_n_o(n_valid_1_2),
	.valid_s_o(s_valid_1_2),	
	.valid_e_o(e_valid_1_2),
	.valid_w_o('0),
	.valid_l_o(d.valid_1_2_o),

	.n_incr_o(n_incr_1_2),
	.s_incr_o(s_incr_1_2),	
	.e_incr_o(e_incr_1_2),
	.w_incr_o('0),
	.l_incr_o(d.incr_1_2_o)
);

router router_1_3(
	.clk(d.clk),
	.rst(d.rst),
	
	.location(8'b00010100),	
	
	.north_i(south_1_4),
	.south_i(north_1_2),
	.east_i(west_2_3),
	.west_i('0),
	.local_i(d.local_1_3_i),
	
	.valid_n_i(s_valid_1_4),
	.valid_s_i(n_valid_1_2),
	.valid_e_i(w_valid_2_3),
	.valid_w_i('0),
	.valid_l_i(d.valid_1_3_i),

	.n_incr_i(s_incr_1_4),
	.s_incr_i(n_incr_1_2),	
	.e_incr_i(w_incr_2_3),
	.w_incr_i('0),
	.l_incr_i(d.incr_1_3_i),

	.north_o(north_1_3),
	.south_o(south_1_3),
	.east_o(east_1_3),
	.west_o('0),
	.local_o(d.local_1_3_o),

	.valid_n_o(n_valid_1_3),
	.valid_s_o(s_valid_1_3),	
	.valid_e_o(e_valid_1_3),
	.valid_w_o('0),
	.valid_l_o(d.valid_1_3_o),

	.n_incr_o(n_incr_1_3),
	.s_incr_o(s_incr_1_3),	
	.e_incr_o(e_incr_1_3),
	.w_incr_o('0),
	.l_incr_o(d.incr_1_3_o)
);

router router_1_4(
	.clk(d.clk),
	.rst(d.rst),
	
	.location(8'b00011000),	
	
	.north_i('0),
	.south_i(north_1_3),
	.east_i(west_2_4),
	.west_i('0),
	.local_i(d.local_1_4_i),
	
	.valid_n_i('0),
	.valid_s_i(n_valid_1_3),
	.valid_e_i(w_valid_2_4),
	.valid_w_i('0),
	.valid_l_i(d.valid_1_4_i),

	.n_incr_i('0),
	.s_incr_i(n_incr_1_3),	
	.e_incr_i(w_incr_1_3),
	.w_incr_i('0),
	.l_incr_i(d.incr_1_4_i),

	.north_o('0),
	.south_o(south_1_4),
	.east_o(east_1_4),
	.west_o('0),
	.local_o(d.local_1_4_o),

	.valid_n_o('0),
	.valid_s_o(s_valid_1_4),	
	.valid_e_o(e_valid_1_4),
	.valid_w_o('0),
	.valid_l_o(d.valid_1_4_o),

	.n_incr_o('0),
	.s_incr_o(s_incr_1_4),	
	.e_incr_o(e_incr_1_4),
	.w_incr_o('0),
	.l_incr_o(d.incr_1_4_o)

);
router router_2_1(
	.clk(d.clk),
	.rst(d.rst),
	
	.location(8'b00100001),	
	
	.north_i(south_2_2),
	.south_i('0),
	.east_i(west_3_1),
	.west_i(east_1_1),
	.local_i(d.local_2_1_i),
	
	.valid_n_i(s_valid_2_2),
	.valid_s_i('0),
	.valid_e_i(w_valid_3_1),
	.valid_w_i(e_valid_1_1),
	.valid_l_i(d.valid_2_1_i),

	.n_incr_i(s_incr_2_2),
	.s_incr_i('0),	
	.e_incr_i(w_incr_3_1),
	.w_incr_i(e_incr_1_1),
	.l_incr_i(d.incr_2_1_i),

	.north_o(north_2_1),
	.south_o('0),
	.east_o(east_2_1),
	.west_o(west_2_1),
	.local_o(d.local_2_1_o),

	.valid_n_o(n_valid_2_1),
	.valid_s_o('0),	
	.valid_e_o(e_valid_2_1),
	.valid_w_o(w_valid_2_1),
	.valid_l_o(d.valid_2_1_o),

	.n_incr_o(n_incr_2_1),
	.s_incr_o('0),	
	.e_incr_o(e_incr_2_1),
	.w_incr_o(w_incr_2_1),
	.l_incr_o(d.incr_2_1_o)
);

router router_2_2(
	.clk(d.clk),
	.rst(d.rst),
	
	.location(8'b00100010),	
	
	.north_i(south_2_3),
	.south_i(north_2_1),
	.east_i(west_3_2),
	.west_i(east_1_2),
	.local_i(d.local_2_2_i),
	
	.valid_n_i(s_valid_2_3),
	.valid_s_i(n_valid_2_1),
	.valid_e_i(w_valid_3_2),
	.valid_w_i(e_valid_1_2),
	.valid_l_i(d.valid_2_2_i),

	.n_incr_i(s_incr_2_3),
	.s_incr_i(n_incr_2_1),	
	.e_incr_i(w_incr_3_2),
	.w_incr_i(e_incr1_2),
	.l_incr_i(d.incr_2_2_i),

	.north_o(north_2_2),
	.south_o(south_2_2),
	.east_o(east_2_2),
	.west_o(west_2_2),
	.local_o(d.local_2_2_o),

	.valid_n_o(n_valid_2_2),
	.valid_s_o(s_valid_2_2),	
	.valid_e_o(e_valid_2_2),
	.valid_w_o(w_valid_2_2),
	.valid_l_o(d.valid_2_2_o),

	.n_incr_o(n_incr_2_2),
	.s_incr_o(s_incr_2_2),	
	.e_incr_o(e_incr_2_2),
	.w_incr_o(w_incr_2_2),
	.l_incr_o(d.incr_2_2_o)
);

router router_2_3(
	.clk(d.clk),
	.rst(d.rst),
	
	.location(8'b00100100),	
	
	.north_i(south_2_4),
	.south_i(north_2_2),
	.east_i(west_3_3),
	.west_i(east_1_3),
	.local_i(d.local_2_3_i),
	
	.valid_n_i(s_valid_2_4),
	.valid_s_i(n_valid_2_2),
	.valid_e_i(w_valid_3_3),
	.valid_w_i(e_valid_1_3),
	.valid_l_i(d.valid_2_3_i),

	.n_incr_i(s_incr_2_4),
	.s_incr_i(n_incr_2_2),	
	.e_incr_i(w_incr_3_3),
	.w_incr_i(e_incr_1_3),
	.l_incr_i(d.incr_2_3_i),

	.north_o(north_2_3),
	.south_o(south_2_3),
	.east_o(east_2_3),
	.west_o(west_2_3),
	.local_o(d.local_2_3_o),

	.valid_n_o(n_valid_2_3),
	.valid_s_o(s_valid_2_3),	
	.valid_e_o(e_valid_2_3),
	.valid_w_o(w_valid_2_3),
	.valid_l_o(d.valid_2_3_o),

	.n_incr_o(n_incr_2_3),
	.s_incr_o(s_incr_2_3),	
	.e_incr_o(e_incr_2_3),
	.w_incr_o(w_incr_2_3),
	.l_incr_o(d.incr_2_3_o)
);

router router_2_4(
	.clk(d.clk),
	.rst(d.rst),
	
	.location(8'b00101000),	
	
	.north_i('0),
	.south_i(north_2_3),
	.east_i(west_3_4),
	.west_i(east_1_4),
	.local_i(d.local_2_4_i),
	
	.valid_n_i('0),
	.valid_s_i(n_valid_2_3),
	.valid_e_i(w_valid_3_4),
	.valid_w_i(e_valid_1_4),
	.valid_l_i(d.valid_2_4_i),

	.n_incr_i('0),
	.s_incr_i(n_incr_2_3),	
	.e_incr_i(w_incr_3_4),
	.w_incr_i(e_incr_1_4),
	.l_incr_i(d.incr_2_4_i),

	.north_o('0),
	.south_o(south_2_4),
	.east_o(east_2_4),
	.west_o(west_2_4),
	.local_o(d.local_2_4_o),

	.valid_n_o('0),
	.valid_s_o(s_valid_2_4),	
	.valid_e_o(e_valid_2_4),
	.valid_w_o(w_valid_2_4),
	.valid_l_o(d.valid_2_4_o),

	.n_incr_o('0),
	.s_incr_o(s_incr_2_4),	
	.e_incr_o(e_incr_2_4),
	.w_incr_o(w_incr_2_4),
	.l_incr_o(d.incr_2_4_o)
);

router router_3_1(
	.clk(d.clk),
	.rst(d.rst),
	
	.location(8'b01000001),	
	
	.north_i(south_3_2),
	.south_i('0),
	.east_i(west_4_1),
	.west_i(east_2_1),
	.local_i(d.local_3_1_i),
	
	.valid_n_i(s_valid_3_2),
	.valid_s_i('0),
	.valid_e_i(w_valid_4_1),
	.valid_w_i(e_valid_2_1),
	.valid_l_i(d.valid_3_1_i),

	.n_incr_i(s_incr_3_2),
	.s_incr_i('0),	
	.e_incr_i(w_incr_4_1),
	.w_incr_i(e_incr_2_1),
	.l_incr_i(d.incr_3_1_i),

	.north_o(north_3_1),
	.south_o('0),
	.east_o(east_3_1),
	.west_o(west_3_1),
	.local_o(d.local_3_1_o),

	.valid_n_o(n_valid_3_1),
	.valid_s_o('0),	
	.valid_e_o(e_valid_3_1),
	.valid_w_o(w_valid_3_1),
	.valid_l_o(d.valid_3_1_o),

	.n_incr_o(n_incr_3_1),
	.s_incr_o('0),	
	.e_incr_o(e_incr_3_1),
	.w_incr_o(w_incr_3_1),
	.l_incr_o(d.incr_3_1_o)
);

router router_3_2(
	.clk(d.clk),
	.rst(d.rst),
	
	.location(8'b01000010),	
	
	.north_i(south_3_3),
	.south_i(north_3_1),
	.east_i(west_4_2),
	.west_i(east_2_2),
	.local_i(d.local_3_2_i),
	
	.valid_n_i(s_valid_3_3),
	.valid_s_i(n_valid_3_1),
	.valid_e_i(w_valid_4_2),
	.valid_w_i(e_valid_2_2),
	.valid_l_i(d.valid_3_2_i),

	.n_incr_i(s_incr_3_3),
	.s_incr_i(n_incr_3_1),	
	.e_incr_i(w_incr_4_2),
	.w_incr_i(e_incr_2_2),
	.l_incr_i(d.incr_3_2_i),

	.north_o(north_3_2),
	.south_o(south_3_2),
	.east_o(east_3_2),
	.west_o(west_3_2),
	.local_o(d.local_3_2_o),

	.valid_n_o(n_valid_3_2),
	.valid_s_o(s_valid_3_2),	
	.valid_e_o(e_valid_3_2),
	.valid_w_o(w_valid_3_2),
	.valid_l_o(d.valid_3_2_o),

	.n_incr_o(n_incr_3_2),
	.s_incr_o(s_incr_3_2),	
	.e_incr_o(e_incr_3_2),
	.w_incr_o(w_incr_3_2),
	.l_incr_o(d.incr_3_2_o)
);

router router_3_3(
	.clk(d.clk),
	.rst(d.rst),
	
	.location(8'b01000100),	
	
	.north_i(south_3_4),
	.south_i(north_3_2),
	.east_i(west_4_3),
	.west_i(east_2_3),
	.local_i(d.local_3_3_i),
	
	.valid_n_i(s_valid_3_4),
	.valid_s_i(n_valid_3_2),
	.valid_e_i(w_valid_4_3),
	.valid_w_i(e_valid_2_3),
	.valid_l_i(d.valid_3_3_i),

	.n_incr_i(s_incr_3_4),
	.s_incr_i(n_incr_3_2),	
	.e_incr_i(w_incr_4_3),
	.w_incr_i(e_incr_2_3),
	.l_incr_i(d.incr_3_3_i),

	.north_o(north_3_3),
	.south_o(south_3_3),
	.east_o(east_3_3),
	.west_o(west_3_3),
	.local_o(d.local_3_3_o),

	.valid_n_o(n_valid_3_3),
	.valid_s_o(s_valid_3_3),	
	.valid_e_o(e_valid_3_3),
	.valid_w_o(w_valid_3_3),
	.valid_l_o(d.valid_3_3_o),

	.n_incr_o(n_incr_3_3),
	.s_incr_o(s_incr_3_3),	
	.e_incr_o(e_incr_3_3),
	.w_incr_o(w_incr_3_3),
	.l_incr_o(d.incr_3_3_o)
);

router router_3_4(
	.clk(d.clk),
	.rst(d.rst),
	
	.location(8'b01001000),	
	
	.north_i('0),
	.south_i(north_3_3),
	.east_i(west_4_4),
	.west_i(east_2_4),
	.local_i(d.local_3_4_i),
	
	.valid_n_i('0),
	.valid_s_i(n_valid_3_3),
	.valid_e_i(w_valid_4_4),
	.valid_w_i(e_valid_2_4),
	.valid_l_i(d.valid_3_4_i),

	.n_incr_i('0),
	.s_incr_i(n_incr_3_3),	
	.e_incr_i(w_incr_4_4),
	.w_incr_i(e_incr_2_4),
	.l_incr_i(d.incr_3_4_i),

	.north_o('0),
	.south_o(south_3_4),
	.east_o(east_3_4),
	.west_o(west_3_4),
	.local_o(d.local_3_4_o),

	.valid_n_o('0),
	.valid_s_o(s_valid_3_4),	
	.valid_e_o(e_valid_3_4),
	.valid_w_o(w_valid_3_4),
	.valid_l_o(d.valid_3_4_o),

	.n_incr_o('0),
	.s_incr_o(s_incr_3_4),	
	.e_incr_o(e_incr_3_4),
	.w_incr_o(w_incr_3_4),
	.l_incr_o(d.incr_3_4_o)
);

router router_4_1(
	.clk(d.clk),
	.rst(d.rst),
	
	.location(8'b10000001),	
	
	.north_i(south_4_2),
	.south_i('0),
	.east_i('0),
	.west_i(east_3_1),
	.local_i(d.local_4_1_i),
	
	.valid_n_i(s_valid_4_2),
	.valid_s_i('0),
	.valid_e_i('0),
	.valid_w_i(e_valid_3_1),
	.valid_l_i(d.valid_4_1_i),

	.n_incr_i(s_incr_4_2),
	.s_incr_i('0),	
	.e_incr_i('0),
	.w_incr_i(e_incr_3_1),
	.l_incr_i(d.incr_4_1_i),

	.north_o(north_4_1),
	.south_o('0),
	.east_o('0),
	.west_o(west_4_1),
	.local_o(d.local_4_1_o),

	.valid_n_o(n_valid_4_1),
	.valid_s_o('0),	
	.valid_e_o('0),
	.valid_w_o(w_valid_4_1),
	.valid_l_o(d.valid_4_1_o),

	.n_incr_o(n_incr_4_1),
	.s_incr_o('0),	
	.e_incr_o('0),
	.w_incr_o(w_incr_4_1),
	.l_incr_o(d.incr_4_1_o)
);

router router_4_2(
	.clk(d.clk),
	.rst(d.rst),
	
	.location(8'b10000010),	
	
	.north_i(south_4_3),
	.south_i(north_4_1),
	.east_i('0),
	.west_i(east_3_2),
	.local_i(d.local_4_2_i),
	
	.valid_n_i(s_valid_4_3),
	.valid_s_i(n_valid_4_1),
	.valid_e_i('0),
	.valid_w_i(e_valid_3_2),
	.valid_l_i(d.valid_4_2_i),

	.n_incr_i(s_incr_4_3),
	.s_incr_i(n_incr_4_1),	
	.e_incr_i('0),
	.w_incr_i(e_incr_3_2),
	.l_incr_i(d.incr_4_2_i),

	.north_o(north_4_2),
	.south_o(south_4_2),
	.east_o('0),
	.west_o(west_4_2),
	.local_o(d.local_4_2_o),

	.valid_n_o(n_valid_4_2),
	.valid_s_o(s_valid_4_2),	
	.valid_e_o('0),
	.valid_w_o(w_valid_4_2),
	.valid_l_o(d.valid_4_2_o),

	.n_incr_o(n_incr_4_2),
	.s_incr_o(s_incr_4_2),	
	.e_incr_o('0),
	.w_incr_o(w_incr_4_2),
	.l_incr_o(d.incr_4_2_o)
);

router router_4_3(
	.clk(d.clk),
	.rst(d.rst),
	
	.location(8'b10000100),	
	
	.north_i(south_4_4),
	.south_i(north_4_2),
	.east_i('0),
	.west_i(east_3_3),
	.local_i(d.local_4_3_i),
	
	.valid_n_i(s_valid_4_4),
	.valid_s_i(n_valid_4_2),
	.valid_e_i('0),
	.valid_w_i(e_valid_3_3),
	.valid_l_i(d.valid_4_3_i),

	.n_incr_i(s_incr_4_4),
	.s_incr_i(n_incr_4_2),	
	.e_incr_i('0),
	.w_incr_i(e_incr_3_3),
	.l_incr_i(d.incr_4_3_i),

	.north_o(north_4_3),
	.south_o(south_4_3),
	.east_o('0),
	.west_o(west_4_3),
	.local_o(d.local_4_3_o),

	.valid_n_o(n_valid_4_3),
	.valid_s_o(s_valid_4_3),	
	.valid_e_o('0),
	.valid_w_o(w_valid_4_3),
	.valid_l_o(d.valid_4_3_o),

	.n_incr_o(n_incr_4_3),
	.s_incr_o(s_incr_4_3),	
	.e_incr_o('0),
	.w_incr_o(w_incr_4_3),
	.l_incr_o(d.incr_4_3_o)
);

router router_4_4(
	.clk(d.clk),
	.rst(d.rst),
	
	.location(8'b10001000),	
	
	.north_i('0),
	.south_i(north_4_3),
	.east_i('0),
	.west_i(east_3_4),
	.local_i(d.local_4_4_i),
	
	.valid_n_i('0),
	.valid_s_i(n_valid_4_3),
	.valid_e_i('0),
	.valid_w_i(e_valid_3_4),
	.valid_l_i(d.valid_4_4_i),

	.n_incr_i('0),
	.s_incr_i(n_incr_4_3),	
	.e_incr_i('0),
	.w_incr_i(e_incr_3_4),
	.l_incr_i(d.incr_4_4_i),

	.north_o('0),
	.south_o(south_4_4),
	.east_o('0),
	.west_o(west_4_4),
	.local_o(d.local_4_4_o),

	.valid_n_o('0),
	.valid_s_o(s_valid_4_4),	
	.valid_e_o('0),
	.valid_w_o(w_valid_4_4),
	.valid_l_o(d.valid_4_4_o),

	.n_incr_o('0),
	.s_incr_o(s_incr_4_4),	
	.e_incr_o('0),
	.w_incr_o(w_incr_4_4),
	.l_incr_o(d.incr_4_4_o)
);

endmodule




