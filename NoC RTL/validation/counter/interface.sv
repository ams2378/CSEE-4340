/**
* @filename  		interface.sv 
*
* @brief     		This file defines the interfaces for the testbench and DUT for the counter
* @authors   		Ayushi Rajeev		<ar3110@columbia.edu>
*			Ashwin Ramachandran	<ar2648@columbia.edu>
*	 
*/

interface ifc_counter ();
	logic incr_i;
	logic decr_i; 

	logic credit_en_o;

	modport dut (
		input incr_i,
		input decr_i, 

		output credit_en_o	
	);

	modport bench (
		output incr_i,
		output decr_i, 

		input credit_en_o
	);
endinterface
