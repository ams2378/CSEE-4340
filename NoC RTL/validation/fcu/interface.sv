/**
 * @filename  		interface.sv 
 *
 * @brief     		This file defines the interfaces for the testbench and DUT for the FCC
 * @authors   		Ayushi Rajeev		<ar3110@columbia.edu>
 *			Ashwin Ramachandran	<ar2648@columbia.edu>
 *	 
 */

interface ifc_fcu (input bit clk);
	logic [2:0] req_port_addr1_i;
	logic [2:0] req_port_addr2_i;
	logic [2:0] req_port_addr3_i;
	logic [2:0] req_port_addr4_i;
	logic [2:0] req_port_addr5_i;

	logic credit_en_north;
	logic credit_en_south;
	logic credit_en_east;
	logic credit_en_west;
	logic credit_en_local;

	logic grant_access_north;
	logic grant_access_south;
	logic grant_access_east;
	logic grant_access_west;
	logic grant_access_local;

   	clocking cb @(posedge clk);
      		default output #1;

		output       req_port_addr1_i;
		output       req_port_addr2_i; 
		output       req_port_addr3_i;
		output       req_port_addr4_i; 
		output 	    req_port_addr5_i;

		output 	    credit_en_north;
		output 	    credit_en_south;
		output 	    credit_en_east;
		output 	    credit_en_west;
		output 	    credit_en_local;

		input 	    grant_access_north;
		input 	    grant_access_south;
		input 	    grant_access_east;
		input 	    grant_access_west;
		input 	    grant_access_local;
	endclocking

   	modport dut (
		input 	    clk,

		input       req_port_addr1_i,
		input       req_port_addr2_i, 
		input       req_port_addr3_i,
		input       req_port_addr4_i, 
		input 	    req_port_addr5_i,

		input 	    credit_en_north,
		input 	    credit_en_south,
		input 	    credit_en_east,
		input 	    credit_en_west,
		input 	    credit_en_local,

		output 	    grant_access_north, 
		output 	    grant_access_south,
		output 	    grant_access_east,
		output 	    grant_access_west,
		output 	    grant_access_local
		);

   	modport bench (clocking cb);
endinterface
