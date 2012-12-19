/**
* @filename  		bench.sv 
*
* @brief     		The file includes the software model of CAM and the random verification tb
* @authors   		Adil Sadik <ams2378@columbia.edu>
*	     		Dechhin Lama <ddl2126@columbia.edu>
*  	 
*/


class CAM_transaction; 
	int reset_density;	
	int search_density;	
	int read_density;	
	int write_density;	

	function new(int rst_d, 
		     int s_d, 
	             int r_d,
		     int w_d);
		reset_density = rst_d;
		search_density = s_d;
		read_density = r_d;
		write_density = w_d;
	endfunction

	rand bit search_i;
	rand bit rst;
	rand bit write_i;
	rand bit read_i;

	constraint density_dist {
		search_i dist {0:/100-search_density, 1:/search_density};
		rst dist {0:/100-reset_density, 1:/reset_density};
		write_i dist {0:/100-write_density, 1:/write_density};
		read_i dist {0:/100-read_density, 1:/read_density};
	}

    	rand int read_index_i;
    	rand int write_index_i;

	/* This constraint lets us employ the bitmasking. Imposing a maximum on
	 * the read and write indices means that we are narrowing our read and write
	 * address space so that they must coincide during the test.
	 */
	constraint index_constraint {
		read_index_i < 4;
		read_index_i >= 0;
		write_index_i < 4;
		write_index_i >= 0;
	}

    	rand int write_data_i;
    	rand int search_data_i;
	
	constraint data_value_constraint {
		write_data_i < 4;
		write_data_i >= 0;
		search_data_i < 4;
		search_data_i >= 0;	
	}
endclass


class CAM_test;					//golden model

 	bit reset_i;
 	bit read_i;
 	int read_index_i;
 	bit write_i;
 	int write_index_i;
	int write_data_i;
 	bit search_i;
 	int search_data_i;

 	bit read_valid_o;
	int read_value_o;
	bit search_valid_o;
	int search_index_o;

 	bit read_valid_oo;
	int read_value_oo;
	bit search_valid_oo;
	int search_index_oo;

	int cam[32];
       	bit match;
	int match_address;

    function void golden_result;	//golden result

		if (reset_i == 1) begin
		 	for (int i=31; i >= 0; i--)
				 cam[i] = 0;
			read_value_o = 0;
			read_valid_o = 0;
			search_valid_o = 0;
			search_index_o = 31;
		end
		else	begin
			
			cam[write_index_i] = write_i  ? write_data_i : cam[write_index_i];
			read_value_o = read_i ? cam[read_index_i] : 0;
			read_valid_o = read_i ? 1 : 0;

			if (search_i == 1) begin				
			match = 0;
				for (int i=31; i >= 0; i--) begin
					if (cam[i] == search_data_i)  begin
						match = 1;
						match_address = i;
						break;	
					end
				end
			end
	
			search_valid_o = (match & search_i) ? 1 : 0;
			search_index_o = (match & search_i) ? match_address : 31;

			match = 0;
		end
    endfunction
endclass


class CAM_checker; //checker class
    
    bit pass; 
    function bit check_result (int dut_read_valid, int dut_read_value, 
			       int dut_search_valid, int dut_search_index, 
			       int bench_read_valid, int bench_read_value, 
			       int bench_search_valid, int bench_search_index, bit verbose);

        bit read_valid_passed 	  =   (dut_read_valid   == bench_read_valid);  
	bit read_value_passed	  =   (dut_read_value   == bench_read_value) ; 
        bit search_valid_passed	  =   (dut_search_valid == bench_search_valid); 
	bit search_index_passed	  =   (dut_search_index == bench_search_index);

	bit passed		  =   (read_valid_passed & read_value_passed &
				       search_valid_passed & search_index_passed);
	pass 			  =	passed;

	if (passed)	begin
	        if(verbose) $display("%t : pass \n", $realtime);
	end
	else begin
		if ( !read_valid_passed & verbose ) begin
		        $display("%t : error in read_valid \n", $realtime);
            		$display("dut value: %d", dut_read_valid);
            		$display("bench value: %d", bench_read_valid);
		end
		if ( !read_value_passed & verbose) begin
		        $display("%t : error in read_value \n", $realtime);
            		$display("dut value: %d", dut_read_value);
            		$display("bench value: %d", bench_read_value);
		end
		if ( !search_valid_passed & verbose) begin
		        $display("%t : error in search_valid \n", $realtime);
            		$display("dut value: %d", dut_search_valid);
            		$display("bench value: %d", bench_search_valid);
		end
		if ( !search_index_passed & verbose) begin
		        $display("%t : error in search_index \n", $realtime);
            		$display("dut value: %d", dut_search_index);
            		$display("bench value: %d", bench_search_index);
		end
		$exit();
	end
        return passed;
    endfunction

endclass


class CAM_env;
    int cycle = 0;
    int max_transactions = 1000;
    int warmup_time = 10;
    bit verbose = 1;

    int reset_density, search_density, read_density, write_density;

    function configure(string filename);
        int file, value, seed, chars_returned;
        string param;
        file = $fopen(filename, "r");
        while(!$feof(file)) begin
            chars_returned = $fscanf(file, "%s %d", param, value);
            if ("RANDOM_SEED" == param) begin
                seed = value;
                $srandom(seed);
            end
            else if("TRANSACTIONS" == param) begin
                max_transactions = value;
            end
	    else if("RESET_DENSITY" == param) begin
	    	reset_density = value;
	    end
	    else if("SEARCH_DENSITY" == param) begin
		search_density = value;
	    end
	    else if("READ_DENSITY" == param) begin
		read_density = value;
	    end
	    else if("WRITE_DENSITY" == param) begin
		write_density = value;
	    end
	    else if("VERBOSE" == param) begin
		verbose = value;
	    end
            else begin
                $display("Never heard of a: %s", param);
                $exit();
            end
        end
    endfunction
endclass


program tb (ifc.bench ds);
    CAM_test test;
    CAM_transaction packet; 
    CAM_checker checker;
    CAM_env env;
    int cycle; // For DVE

    task do_cycle;
        env.cycle++;
        cycle = env.cycle;      
	packet.randomize();
/*
	passing data to golden model
*/   
	test.reset_i 		<= 	packet.rst;
	test.read_i 		<= 	packet.read_i;
	test.read_index_i 	<= 	packet.read_index_i;
	test.write_i 		<= 	packet.write_i;
	test.write_index_i 	<= 	packet.write_index_i;
	test.write_data_i 	<= 	packet.write_data_i;
	test.search_i 		<= 	packet.search_i;
	test.search_data_i 	<= 	packet.search_data_i;
/*
	passing data to DUT 
*/ 
  	ds.cb_w.rst 			<= 	packet.rst;
	ds.cb_w.read_i 			<= 	packet.read_i;
	ds.cb_w.read_index_i 		<= 	packet.read_index_i;
	ds.cb_w.write_i 		<= 	packet.write_i;
	ds.cb_w.write_index_i 		<= 	packet.write_index_i;
	ds.cb_w.write_data_i 		<= 	packet.write_data_i;
	ds.cb_w.search_i 		<= 	packet.search_i;
	ds.cb_w.search_data_i	 	<= 	packet.search_data_i;  
 
	test.golden_result();

        @(ds.cb_w);
	@(ds.cb_r_s);
    endtask

    initial begin
        test = new();
        checker = new();
	env = new();
        env.configure("config.txt");
        packet = new(50, env.search_density, env.read_density, env.write_density);	
	
        // warm up
        repeat (env.warmup_time) begin
            do_cycle();
        end

        packet = new(env.reset_density, env.search_density, env.read_density, env.write_density);

        repeat (env.max_transactions) begin
            do_cycle();
	    checker.check_result (ds.cb_r_s.read_valid_o, ds.cb_r_s.read_value_o, 
				  ds.cb_r_s.search_valid_o, ds.cb_r_s.search_index_o, 
				  test.read_valid_o, test.read_value_o,
			          test.search_valid_o, test.search_index_o, env.verbose);
        end
	if (checker.pass  == 1)
		                $display("TEST PASSED !!! ");
    end
endprogram

