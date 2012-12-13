/*-----------------------------------------------------
Design Name : router
File Name   : router.sv
Function    : Top level file 

author	    : Dechhin Lama <ddl2126@columbia.edu>
*///-----------------------------------------------------


module router (
	ifc.dut d
	);



/*
 * instantiate ifc_buffer interface and map the inputs and
 * outputs
 */
ifc_buffer b ();

assign b.clk = d.clk;
assign b.rst = d.rst;

assign b.north_i = d.north_i;
assign b.south_i = d.south_i;
assign b.east_i = d.east_i;
assign b.west_i = d.west_i;
assign b.local_i = d.local_i;

assign b.valid_n_i = d.valid_n_i;
assign b.valid_s_i = d.valid_s_i;
assign b.valid_e_i = d.valid_e_i;
assign b.valid_w_i = d.valid_w_i;
assign b.valid_l_i = d.valid_l_i;

assign b.pop_req_n_i=f.grant_access_north_o;
assign b.pop_req_s_i=f.grant_access_south_o;
assign b.pop_req_e_i=f.grant_access_east_o;
assign b.pop_req_w_i=f.grant_access_west_o;
assign b.pop_req_l_i=f.grant_access_local_o;




/*
 * instantiate the inputbuffers 
 */
inputbuffers inputbuffers_unit(
	.d (b.dut)
);



/*
 * instantiate ifc_agu interface and map the inputs and
 * outputs 
 */
ifc_agu a ();

assign a.north_q_i = b.north_q_o;
assign a.south_q_i = b.south_q_o;
assign a.west_q_i = b.east_q_o;
assign a.east_q_i = b.west_q_o;
assign a.local_q_i = b.local_q_o;

assign a.myaddr_i= ff.read_data_o;



/*
 * instantiate the address generator */
address_gen agu(
    .d (a.dut)
);




/*
 * instantiate ifc_FF interface and map the inputs and
 * outputs 
 */
ifc_FF ff ();

assign ff.clk = d.clk;
assign ff.rst = d.rst;


/*
 * instantiate the FF */
FF loc(
    .d (ff.dut)
);




/*
 * instantiate ifc_arb interface and map the inputs and
 * outputs 
 */
ifc_arb ar ();

assign ar.req_port_addr1_i= a.req_port_addr1_o;
assign ar.req_port_addr2_i= a.req_port_addr2_o;
assign ar.req_port_addr3_i= a.req_port_addr3_o;
assign ar.req_port_addr4_i= a.req_port_addr4_o;
assign ar.req_port_addr5_i= a.req_port_addr5_o;

assign ar.en_n_i = b.en_n_o;
assign ar.en_s_i = b.en_s_o;
assign ar.en_e_i = b.en_e_o;
assign ar.en_w_i = b.en_w_o;
assign ar.en_l_i = b.en_l_o;

/*
 * instantiate the arbiter */
arbiter arbiter_unit(
	.d (ar.dut)
);




/*
 * instantiate ifc_fcu interface and map the inputs and
 * outputs
 */
ifc_fcu f ();

assign f.req_port_addr1_i= ar.req_port_addr1_o;
assign f.req_port_addr2_i= ar.req_port_addr2_o;
assign f.req_port_addr3_i= ar.req_port_addr3_o;
assign f.req_port_addr4_i= ar.req_port_addr4_o;
assign f.req_port_addr5_i= ar.req_port_addr5_o;

assign f.credit_en_north_i = c.credit_en_north_o;
assign f.credit_en_south_i = c.credit_en_south_o;
assign f.credit_en_east_i  = c.credit_en_east_o;
assign f.credit_en_west_i  = c.credit_en_west_o;
assign f.credit_en_local_i = c.credit_en_local_o;
   
/*
 * instantiate the fcu */
fcu fcu_unit(
	.d (f.dut)
);



/*
 * instantiate ifc_fcc interface and map the inputs and
 * outputs
 */
ifc_fcc c ();

assign c.clk = d.clk;
assign c.rst = d.rst;

assign c.n_incr_i= d.n_incr_i;
assign c.s_incr_i= d.s_incr_i;
assign c.e_incr_i= d.e_incr_i;
assign c.w_incr_i= d.w_incr_i;
assign c.l_incr_i= d.l_incr_i;

assign c.n_decr_i= x.valid_n_o;
assign c.s_decr_i= x.valid_s_o;
assign c.e_decr_i= x.valid_e_o;
assign c.w_decr_i= x.valid_w_o;
assign c.l_decr_i= x.valid_l_o;


	
/*
 * instantiate the fcc 
 */
fcc fcc_unit(
	.d (c.dut)
);



/*
 * instantiate ifc_xbar interface and map the inputs and
 * outputs
 */
ifc_xbar x ();

assign x.pop_req_n= f.grant_access_north_o;
assign x.pop_req_s= f.grant_access_south_o;
assign x.pop_req_e= f.grant_access_east_o;
assign x.pop_req_w= f.grant_access_west_o;
assign x.pop_req_l= f.grant_access_local_o;

assign x.address_route_n_i =  ar.req_port_addr1_o;
assign x.address_route_s_i =  ar.req_port_addr2_o;
assign x.address_route_e_i =  ar.req_port_addr3_o;
assign x.address_route_w_i =  ar.req_port_addr4_o;
assign x.address_route_l_i =  ar.req_port_addr5_o;

assign x.north_q_i = b.north_q_o;
assign x.south_q_i= b.south_q_o;
assign x.east_q_i= b.east_q_o;
assign x.west_q_i= b.west_q_o;
assign x.local_q_i= b.local_q_o;

assign x.north_o = d.north_o;
assign x.south_o = d.south_o;
assign x.east_o = d.east_o;
assign x.west_o = d.west_o;
assign x.local_o = d.local_o;

assign x.valid_n_o = d.valid_n_o;
assign x.valid_s_o = d.valid_s_o;
assign x.valid_e_o = d.valid_e_o;
assign x.valid_w_o = d.valid_w_o;
assign x.valid_l_o = d.valid_l_o;



/*
 * instantiate the xbar */
xbar xbar_unit(
	.d (x.dut)
);



endmodule

