/**
* @filename  		interface.sv 
*
* @brief     		The file defines the interfaces for test bench and DUT for the arbiter
* @authors   		Ashwin Ramachandran <ar2648@columbia.edu>
			Ayushi Rajeev <ar3110@columbia.edu>
*	 
*/

interface ifc_counter (input bit clk);
	logic incr_i;
	logic decr_i; 

	logic credit_en_o;	

	clocking cb @(posedge clk);
		default output #1;
		output incr_i;
		output decr_i; 

		input credit_en_o;	
	endclocking

	modport dut (
		input incr_i,
		input decr_i, 

		output credit_en_o	
	);

	modport bench (clocking cb);
endinterface
