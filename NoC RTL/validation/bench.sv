/**
* @filename  		bench.sv 
*
* @brief     		The file includes the software model of the router and the random verification tb
* @authors   		Ayushi Rajeev <ar3110@columbia.edu>
			Ashwin Ramachandran <ar2648@columbia.edu>
*	     		
*  	 
*/

class router_transaction;

	function new();
	endfunction

endclass

class router_test;

	function void golden_result();
	endfunction

endclass

class router_check;

	function bit check_results();
	endfunction

endclass

class router_env;

	function configure();
	endfunction

endclass

program tb (ifc.bench ds);

	task do_cycle;
	endtask

	initial begin
	end
endprogram
