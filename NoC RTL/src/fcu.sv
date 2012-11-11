module fcu (
	
	input [2:0] req_port_addr1_i,
	input [2:0] req_port_addr2_i,	
	input [2:0] req_port_addr3_i,
	input [2:0] req_port_addr4_i,
	input [2:0] req_port_addr5_i,

	input credit_en_north,
	input credit_en_south,
	input credit_en_east,
	input credit_en_west,
	input credit_en_local,

	output grant_access_north,
	output grant_access_south,
	output grant_access_east,
	output grant_access_west,
	output grant_access_local

)



endmodule
