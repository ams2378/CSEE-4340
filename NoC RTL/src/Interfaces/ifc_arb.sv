/**
 * @filename  		ifc_arb.sv 
 *
 * @brief     		The file defines the interfaces for test bench and DUT for the arbiter
 * @authors   		Ashwin Ramachandran <ar2648@columbia.edu>
 			Ayushi Rajeev <ar3110@columbia.edu>
			Dechhin Lama <ddl2126@columbia.edu>
 *	 
 */

interface ifc_arb ();
   logic [2:0] req_port_addr1_i;
   logic [2:0] req_port_addr2_i;	
   logic [2:0] req_port_addr3_i;
   logic [2:0] req_port_addr4_i;
   logic [2:0] req_port_addr5_i;

   logic [2:0] req_port_addr1_o;
   logic [2:0] req_port_addr2_o;	
   logic [2:0] req_port_addr3_o;
   logic [2:0] req_port_addr4_o;
   logic [2:0] req_port_addr5_o;

   modport dut (
		input  req_port_addr1_i,
		input  req_port_addr2_i, 
		input  req_port_addr3_i,
		input  req_port_addr4_i,
		input  req_port_addr5_i,

		output req_port_addr1_o,
		output req_port_addr2_o, 
		output req_port_addr3_o,
		output req_port_addr4_o,
		output req_port_addr5_o
		);

  
endinterface
