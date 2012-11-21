/**
* @filename  		address_gen.sv 
*
* @brief     		Generates the direction to which data flits need to be sent, comparing current router address to destination address.

* @author   		Dechhin Lama	<ddl2126@columbia.edu>
*	     		
*  	 
*/

module address_gen (
		ifc_agu.dut d;	
		);
	
	one_addr_gen n_addr_gen(
			.q_i (d.north_q_i),
			.myaddr_i (d.myaddr_i),
			.req_port_addr_o (d.req_port_addr1_o)
		);
	
	one_addr_gen s_addr_gen(
			.q_i (d.south_q_i),
			.myaddr_i (d.myaddr_i),
			.req_port_addr_o (d.req_port_addr2_o)
		);

	one_addr_gen e_addr_gen(
			.q_i (d.east_q_i),
			.myaddr_i (d.myaddr_i),
			.req_port_addr_o (d.req_port_addr3_o)
		);

	one_addr_gen w_addr_gen(
			.q_i (d.west_q_i),
			.myaddr_i (d.myaddr_i),
			.req_port_addr_o (d.req_port_addr4_o)
		);
	
	one_addr_gen l_addr_gen(
			.q_i (d.local_q_i),
			.myaddr_i (d.myaddr_i),
			.req_port_addr_o (d.req_port_addr5_o)
		);
	
		
endmodule

