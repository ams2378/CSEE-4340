/**
 * @filename  		router_check.sv 
 *
 * @brief     		The file includes the checker class
 * @authors   		Ayushi Rajeev		<ar3110@columbia.edu>
 *			Ashwin Ramachandran	<ar2648@columbia.edu>
 *	     		
 *  	 
 */

class router_check; //checker class
   
   bit pass;

   bit dut_valid_n_q[$:1];
   /*bit dut_valid_s_q[$:1];
   bit dut_valid_e_q[$:1];
   bit dut_valid_w_q[$:1];
   bit dut_valid_l_q[$:1];*/

   bit [15:0] dut_data_n_q[$:1];
   /*bit [15:0] dut_data_s_q[$:1];
   bit [15:0] dut_data_e_q[$:1];
   bit [15:0] dut_data_w_q[$:1];
   bit [15:0] dut_data_l_q[$:1];*/

   bit dut_incr_n_q[$:1];
   /*bit dut_incr_s_q[$:1];
   bit dut_incr_e_q[$:1];
   bit dut_incr_w_q[$:1];
   bit dut_incr_l_q[$:1];*/

   function new();
	pass = 0;

	dut_valid_n_q = {};
	dut_valid_n_q.push_back(1'b0);
	dut_valid_n_q.push_back(1'b0);

	dut_data_n_q = {};
	dut_data_n_q.push_back(16'd0);
	dut_data_n_q.push_back(16'd0);

	dut_incr_n_q = {};
	dut_incr_n_q.push_back(1'b0);
	dut_incr_n_q.push_back(1'b0);
   endfunction

   function void pop_queues();
	dut_valid_n_q.pop_front();

	dut_data_n_q.pop_front();

	dut_incr_n_q.pop_front();
   endfunction

   function bit check_result (bit dut_valid_n_o, bit dut_valid_s_o, 
			      bit 	 dut_valid_e_o, bit dut_valid_w_o, 
			      bit 	 dut_valid_l_o, 

			      bit 	 bench_valid_n_o, bit bench_valid_s_o, 
			      bit 	 bench_valid_e_o, bit bench_valid_w_o, 
			      bit 	 bench_valid_l_o,
   
			      bit [15:0] dut_north_o, 
			      bit [15:0] dut_south_o, bit [15:0] dut_east_o,
			      bit [15:0] dut_west_o, bit [15:0] dut_local_o,

			      bit [15:0] bench_north_o, bit [15:0] bench_south_o,
			      bit [15:0] bench_east_o, bit [15:0] bench_west_o, 
			      bit [15:0] bench_local_o,

			      bit 	 dut_incr_n_o, 
			      bit 	 dut_incr_s_o, bit dut_incr_e_o, 
			      bit 	 dut_incr_w_o, bit dut_incr_l_o,

			      bit 	 bench_incr_n_o, bit bench_incr_s_o,
			      bit 	 bench_incr_e_o, bit bench_incr_w_o,
			      bit 	 bench_incr_l_o, bit verbose);
	
        bit 				 valid_n_passed; 
        bit 				 valid_s_passed;
        bit 				 valid_e_passed;
        bit 				 valid_w_passed;
        bit 				 valid_l_passed;

        bit 				 north_passed;
        bit 				 south_passed;
        bit 				 east_passed;
        bit 				 west_passed;                   
        bit 				 local_passed;

        bit 				 incr_n_passed; 
        bit 				 incr_s_passed;
        bit 				 incr_e_passed;                     
        bit 				 incr_w_passed;
        bit 				 incr_l_passed;

	bit 				 passed;

        pop_queues();

	dut_valid_n_q.push_back(dut_valid_n_o);

	dut_data_n_q.push_back(dut_north_o);

	dut_incr_n_q.push_back(dut_incr_n_o);

	valid_n_passed = (dut_valid_n_q[0] == bench_valid_n_o);
	valid_s_passed = (dut_valid_s_o == bench_valid_s_o);
	valid_e_passed = (dut_valid_e_o == bench_valid_e_o);
	valid_w_passed = (dut_valid_w_o == bench_valid_w_o);
	valid_w_passed = (dut_valid_w_o == bench_valid_w_o);
	valid_l_passed = (dut_valid_l_o == bench_valid_l_o);

	north_passed = ((dut_valid_n_q[0] == 0) && (bench_valid_n_o == 0)) ||(dut_data_n_q[0] == bench_north_o);
	south_passed = ((dut_valid_s_o == 0) && (bench_valid_s_o == 0)) ||(dut_south_o == bench_south_o);      
	east_passed = ((dut_valid_e_o == 0) && (bench_valid_e_o == 0)) ||(dut_east_o == bench_east_o);
	west_passed = ((dut_valid_w_o == 0) && (bench_valid_w_o == 0)) ||(dut_west_o == bench_west_o);
	local_passed = ((dut_valid_l_o == 0) && (bench_valid_l_o == 0)) ||(dut_local_o == bench_local_o);

	incr_n_passed = (dut_incr_n_q[0] == bench_incr_n_o); 
	incr_s_passed = (dut_incr_s_o == bench_incr_s_o);
	incr_e_passed = (dut_incr_e_o == bench_incr_e_o);
	incr_w_passed = (dut_incr_w_o == bench_incr_w_o);
	incr_l_passed = (dut_incr_l_o == bench_incr_l_o);     

	passed		  =   (valid_n_passed & valid_s_passed & valid_e_passed & valid_w_passed & valid_l_passed & north_passed & south_passed & east_passed & west_passed & local_passed & incr_n_passed & incr_s_passed & incr_e_passed & incr_w_passed & incr_l_passed );
      
      pass 			  =	passed;

      if (passed)	begin
	 if(verbose) $display("%t : pass \n", $realtime);
      end
      else begin
	 /*check for output valid signals*/
	 if ( !valid_n_passed & verbose ) begin
	    $display("%t : error in valid_north \n", $realtime);
            $display("dut value: %b", dut_valid_n_q[0]);
            $display("bench value: %b", bench_valid_n_o);
	 end
	 if ( !valid_s_passed & verbose ) begin
	    $display("%t : error in valid_south \n", $realtime);
            $display("dut value: %b", dut_valid_s_o);
            $display("bench value: %b", bench_valid_s_o);
	 end
	 if ( !valid_e_passed & verbose ) begin
	    $display("%t : error in valid_east \n", $realtime);
            $display("dut value: %b", dut_valid_e_o);
            $display("bench value: %b", bench_valid_e_o);
	 end
	 if ( !valid_w_passed & verbose ) begin
	    $display("%t : error in valid_west \n", $realtime);
            $display("dut value: %b", dut_valid_w_o);
            $display("bench value: %b", bench_valid_w_o);
	 end		
	 if ( !valid_l_passed & verbose ) begin
	    $display("%t : error in valid_local \n", $realtime);
            $display("dut value: %b", dut_valid_l_o);
            $display("bench value: %b", bench_valid_l_o);
	 end
	 /* check output data*/
	 if ( !north_passed & verbose ) begin
	    $display("%t : error in north data \n", $realtime);
            $display("dut value: %b", dut_data_n_q[0]);
            $display("bench value: %b", bench_north_o);
	 end
	 if ( !south_passed & verbose ) begin
	    $display("%t : error in south data \n", $realtime);
            $display("dut value: %b", dut_south_o);
            $display("bench value: %b", bench_south_o);
	 end
	 if ( !east_passed & verbose ) begin
	    $display("%t : error in east data \n", $realtime);
            $display("dut value: %b", dut_east_o);
            $display("bench value: %b", bench_east_o);
	 end
	 if ( !west_passed & verbose ) begin
	    $display("%t : error in west data \n", $realtime);
            $display("dut value: %b", dut_west_o);
            $display("bench value: %b", bench_west_o);
	 end
	 if ( !local_passed & verbose ) begin
	    $display("%t : error in local data \n", $realtime);
            $display("dut value: %b", dut_local_o);
            $display("bench value: %b", bench_local_o);
	 end
	 /* check increment signals */
	 if ( !incr_n_passed & verbose ) begin
	    $display("%t : error in north increment signal \n", $realtime);
            $display("dut value: %b", dut_incr_n_q[0]);
            $display("bench value: %b", bench_incr_n_o);
	 end
	 if ( !incr_s_passed & verbose ) begin
	    $display("%t : error in south increment signal \n", $realtime);
            $display("dut value: %b", dut_incr_s_o);
            $display("bench value: %b", bench_incr_s_o);
	 end
	 if ( !incr_e_passed & verbose ) begin
	    $display("%t : error in east increment signal \n", $realtime);
            $display("dut value: %b", dut_incr_e_o);
            $display("bench value: %b", bench_incr_e_o);
	 end
	 if ( !incr_w_passed & verbose ) begin
	    $display("%t : error in west increment signal \n", $realtime);
            $display("dut value: %b", dut_incr_w_o);
            $display("bench value: %b", bench_incr_w_o);
	 end
	 if ( !incr_l_passed & verbose ) begin
	    $display("%t : error in local increment signal \n", $realtime);
            $display("dut value: %b", dut_incr_l_o);
            $display("bench value: %b", bench_incr_l_o);
	 end

	 //$exit();
      end
      return passed;
   endfunction
endclass
