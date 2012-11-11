/**
* @filename  		interface.sv 
*
* @brief     		The file defines the interfaces for test bench and DUT for the arbiter
* @authors   		Ashwin Ramachandran <ar2648@columbia.edu>
			Ayushi Rajeev <ar3110@columbia.edu>
*	 
*/

interface ifc_addr (input bit clk);
	logic [15:0] north_q_i;
	logic [15:0] south_q_i;
	logic [15:0] east_q_i;
	logic [15:0] west_q_i;
	logic [15:0] local_q_i;

	logic [7:0] myaddr_i;

	logic [2:0] req_port_addr1_o;
	logic [2:0] req_port_addr2_o;
	logic [2:0] req_port_addr3_o;
	logic [2:0] req_port_addr4_o;
	logic [2:0] req_port_addr5_o;

	clocking cb @(posedge clk);
		default output #1;

		output north_q_i;
		output south_q_i;
		output east_q_i;
		output west_q_i;
		output local_q_i;

		output myaddr_i;

		input req_port_addr1_o;
		input req_port_addr2_o;
		input req_port_addr3_o;
		input req_port_addr4_o;
		input req_port_addr5_o;

	endclocking

	modport dut (
		input north_q_i,
		input south_q_i,
		input east_q_i,
		input west_q_i,
		input local_q_i,

		input myaddr_i,

		output req_port_addr1_o,
		output req_port_addr2_o,
		output req_port_addr3_o,
		output req_port_addr4_o,
		output req_port_addr5_o
	);

	modport bench (clocking cb);
endinterface
