/**
 * @filename  		router_check.sv 
 *
 * @brief     		The file includes the checker class
 * @authors   		Ayushi Rajeev		<ar3110@columbia.edu>
 *			Ashwin Ramachandran	<ar2648@columbia.edu>
 *	     		
 *  	 
 */

class router_check;

    function bit check_results (int cycle,
			       int dut_value, 
			       int bench_value,
			       bit verbose);
   
	bit passed = (dut_value == bench_value);
	if(verbose)
		$display("dut_value: %d", dut_value);
	if(passed) begin
		if(verbose) 
			$display ("%t : pass \n", cycle);
		end
	else begin
		$display("%t : fail \n", cycle);
		$display("dut value: %d", dut_value);
		$display("bench value: %d", bench_value);
		$exit();
	end
	return passed;
    endfunction
endclass
