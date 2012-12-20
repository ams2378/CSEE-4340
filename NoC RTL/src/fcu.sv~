/**
* filename  		fcu.sv 
* brief			Flow Control Unit- implements credit based flow control    		
* authors   		Adil sadik <ams2378@columbia.edu>
* data creation		11/11/12	
* 
* 
*	 
*/



module fcu (
	ifc_fcu.dut d
	);
	
always_comb begin
	if (d.req_port_addr1_i != 3'b111 && d.credit_en_north_i)
		d.grant_access_north_o = 1;
	else 
		d.grant_access_north_o = 0;

	if (d.req_port_addr2_i != 3'b111 && d.credit_en_south_i)
		d.grant_access_south_o = 1;
	else
		d.grant_access_south_o = 0;

	if (d.req_port_addr3_i != 3'b111 && d.credit_en_east_i)
		d.grant_access_east_o = 1;
	else
		d.grant_access_east_o = 0;

	if (d.req_port_addr4_i != 3'b111 && d.credit_en_west_i)
		d.grant_access_west_o = 1;
	else
		d.grant_access_west_o = 0;

	if (d.req_port_addr5_i != 3'b111 && d.credit_en_local_i)
		d.grant_access_local_o = 1;
	else 
		d.grant_access_local_o = 0;

end


endmodule
