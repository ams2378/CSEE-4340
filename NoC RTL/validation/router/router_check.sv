/**
 * @filename  		router_check.sv 
 *
 * @brief     		The file includes the checker class
 * @authors   		Ayushi Rajeev		<ar3110@columbia.edu>
 *			Ashwin Ramachandran	<ar2648@columbia.edu>
 *	     		
 *  	 
 */

  class CAM_checker; //checker class
    
    bit pass; 
    function bit check_result (bit dut_valid_n_o, bit dut_valid_s_o, 
			       bit dut_valid_e_o, bit dut_valid_w_o, 
			       bit dut_valid_l_o, bit bench_valid_n_o, bit bench_valid_s_o, 
			       bit bench_valid_e_o, bit bench_valid_w_o, 
			       bit bench_valid_l_o,int dut_north_o, 
			       int dut_south_o, int dut_east_o, int dut_west_o, int dut_local_o, int bench_north_o, int bench_south_o, int bench_east_o, int bench_west_o, int bench_local_o, bit dut_n_incr_o, bit dut_s_incr_i, bit dut_e_incr_i, bit dut_w_incr_i, bit dut_l_incr_i, bit bench_incr_n_o, bit bench_incr_s_o, bit bench_incr_e_o, bit bench_incr_w_o, bit bench_incr_l_o, bit verbose);

         	     
	bit valid_n_passed = (dut_valid_n_o == bench_valid_n_o); 
	bit valid_s_passed = (dut_valid_s_o == bench_valid_s_o);
	bit valid_e_passed = (dut_valid_e_o == bench_valid_e_o);                     
	bit valid_w_passed = (dut_valid_w_o == bench_valid_w_o);
	bit valid_l_passed = (dut_valid_l_o == bench_valid_l_o);

	bit north_passed = (dut_north_o == bench_north_o);
	bit south_passed = (dut_south_o == bench_south_o);
	bit east_passed = (dut_east_o == bench_east_o);
	bit west_passed = (dut_west_o == bench_west_o);                   
	bit local_passed = (dut_local_o == bench_local_o);

	bit incr_n_passed = (dut_incr_n_o == bench_incr_n_o); 
	bit incr_s_passed = (dut_incr_s_o == bench_incr_s_o);
	bit incr_e_passed = (dut_incr_e_o == bench_incr_e_o);                     
	bit incr_w_passed = (dut_incr_w_o == bench_incr_w_o);
	bit incr_l_passed = (dut_incr_l_o == bench_incr_l_o);
	

	bit passed		  =   (valid_n_passed & valid_s_passed & valid_e_passed & valid_w_passed & valid_l_passed & north_passed & south_passed & east_passed & west_passed & local_passed & incr_n_passed & incr_s_passed & incr_e_passed & incr_w_passed & incr_l_passed );
	
	pass 			  =	passed;

	if (passed)	begin
	        if(verbose) $display("%t : pass \n", $realtime);
	end
	else begin
/*check for output valid signals*/
		if ( !valid_n_passed & verbose ) begin
		        $display("%t : error in valid_north \n", $realtime);
            		$display("dut value: %d", dut_valid_n_o);
            		$display("bench value: %d", bench_valid_n_o);
		end
		if ( !valid_s_passed & verbose ) begin
		        $display("%t : error in valid_south \n", $realtime);
            		$display("dut value: %d", dut_valid_s_o);
            		$display("bench value: %d", bench_valid_s_o);
		end
		if ( !valid_e_passed & verbose ) begin
		        $display("%t : error in valid_east \n", $realtime);
            		$display("dut value: %d", dut_valid_e_o);
            		$display("bench value: %d", bench_valid_e_o);
		end
		if ( !valid_w_passed & verbose ) begin
		        $display("%t : error in valid_west \n", $realtime);
            		$display("dut value: %d", dut_valid_w_o);
            		$display("bench value: %d", bench_valid_w_o);
		end		
		if ( !valid_l_passed & verbose ) begin
		        $display("%t : error in valid_localth \n", $realtime);
            		$display("dut value: %d", dut_valid_l_o);
            		$display("bench value: %d", bench_valid_l_o);
		end
/* check output data*/
		if ( !north_passed & verbose ) begin
		        $display("%t : error in north data \n", $realtime);
            		$display("dut value: %d", dut_north_o);
            		$display("bench value: %d", bench_north_o);
		end
		if ( !south_passed & verbose ) begin
		        $display("%t : error in south data \n", $realtime);
            		$display("dut value: %d", dut_south_o);
            		$display("bench value: %d", bench_south_o);
		end
		if ( !east_passed & verbose ) begin
		        $display("%t : error in east data \n", $realtime);
            		$display("dut value: %d", dut_east_o);
            		$display("bench value: %d", bench_east_o);
		end
		if ( !west_passed & verbose ) begin
		        $display("%t : error in west data \n", $realtime);
            		$display("dut value: %d", dut_west_o);
            		$display("bench value: %d", bench_west_o);
		end
		if ( !local_passed & verbose ) begin
		        $display("%t : error in local data \n", $realtime);
            		$display("dut value: %d", dut_local_o);
            		$display("bench value: %d", bench_local_o);
		end
/* check increment signals */
		if ( !incr_n_passed & verbose ) begin
		        $display("%t : error in north increment signal \n", $realtime);
            		$display("dut value: %d", dut_incr_n_o);
            		$display("bench value: %d", bench_incr_n_o);
		end
		if ( !incr_s_passed & verbose ) begin
		        $display("%t : error in south increment signal \n", $realtime);
            		$display("dut value: %d", dut_incr_s_o);
            		$display("bench value: %d", bench_incr_s_o);
		end
		if ( !incr_e_passed & verbose ) begin
		        $display("%t : error in east increment signal \n", $realtime);
            		$display("dut value: %d", dut_incr_e_o);
            		$display("bench value: %d", bench_incr_e_o);
		end
		if ( !incr_w_passed & verbose ) begin
		        $display("%t : error in west increment signal \n", $realtime);
            		$display("dut value: %d", dut_incr_w_o);
            		$display("bench value: %d", bench_incr_w_o);
		end
		if ( !incr_l_passed & verbose ) begin
		        $display("%t : error in local increment signal \n", $realtime);
            		$display("dut value: %d", dut_incr_l_o);
            		$display("bench value: %d", bench_incr_l_o);
		end

		$exit();
	end
        return passed;
    endfunction
