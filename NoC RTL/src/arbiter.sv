/**
* filename  		arbiter.sv 
* brief			Arbiter module for the router     		
* authors   		Adil sadik <ams2378@columbia.edu>
* data creation		11/11/12	
* 
* 
*	 
*/

module arbiter (

	input [2:0] req_port_addr1_i,
	input [2:0] req_port_addr2_i,	
	input [2:0] req_port_addr3_i,
	input [2:0] req_port_addr4_i,
	input [2:0] req_port_addr5_i,

	output [2:0] req_port_addr1_o,
	output [2:0] req_port_addr2_o,	
	output [2:0] req_port_addr3_o,
	output [2:0] req_port_addr4_o,
	output [2:0] req_port_addr5_o

)




endmodule


