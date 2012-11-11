/**
* @filename  		address_gen.sv 
*
* @brief     		Generates the direction to which data flits need to be sent comparing current router address to destination address.

* @authors   		ddl2126	<ddl2126@columbia.edu>
*	     		
*  	 
*/

module address_gen (
	input [15:0] north_q_i,
	input [15:0] south_q_i,
	input [15:0] east_q_i,
	input [15:0] west_q_i,
	input [15:0] local_q_i,

	input [7:0] myaddr_i,

	output [2:0] req_port_addr1_o;
	output [2:0] req_port_addr2_o;
	output [2:0] req_port_addr3_o;
	output [2:0] req_port_addr4_o;
	output [2:0] req_port_addr5_o;
)



endmodule

