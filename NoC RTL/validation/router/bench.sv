/**
 * @filename  		bench.sv 
 *
 * @brief     		The file includes the software model of the router and the random verification TB
 * @authors   		Ayushi Rajeev		<ar3110@columbia.edu>
 *			Ashwin Ramachandran	<ar2648@columbia.edu>
 *	     		
 *  	 
 */

class router_transaction;
   int reset_density;

   int north_density;
   int south_density;
   int east_density;
   int west_density;
   int local_density;

   function new(int rst_d,
		int north_d,
		int south_d,
		int east_d,
		int west_d,
		int loc_d);

	reset_density = rst_d;
	north_density = north_d;
	south_density = south_d;
	east_density = east_d;
	west_density = west_d;
	local_density = loc_d;
   endfunction

   /*
    * randomly generated values to determine if we have
    * a transaction on any of the 5 input ports
    */
   rand bit reset_req;
   rand bit north_req;
   rand bit south_req;
   rand bit east_req;
   rand bit west_req;
   rand bit local_req;

   /*
    * constrain the values so that they are 0 or 1 based on
    * the randomly generated value
    */
   constraint density_dist {
	reset_req dist {0:/100-reset_density, 1:/reset_density};
   }

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
   int cycle = 0;
   int max_transactions = 10000;
   int warmup_time = 10;
   bit verbose = 1;

   int reset_density = 10;

   int north_density = 20;
   int south_density = 20;
   int east_density = 20;
   int west_density = 20;
   int local_density = 20;

   function configure(string filename);
      int file, value, chars_returned;
      int seed = 3;
      string param;
      file = $fopen (filename, "r");
      while (!$feof(file)) begin
	 chars_returned = $fscanf(file, "%s %d", param, value);
	 if ("RANDOM_SEED" == param) begin
	    seed = value;
	    $srandom(seed);
	 end
	 else if("TRANSACTIONS" == param) begin
	    max_transactions = value;
	 end
	 else if("VERBOSE" == param) begin
	    verbose = value;
	 end
	 else if("RESET_DENSITY" == param) begin
	    reset_density = value;
	 end
	 else if("NORTH_DENSITY" == param) begin
	    north_density = value;
	 end
	 else if("SOUTH_DENSITY" == param) begin
	    south_density = value;
	 end
	 else if("EAST_DENSITY" == param) begin
	    east_density = value;
	 end
	 else if("WEST_DENSITY" == param) begin
	    west_density = value;
	 end
	 else if("LOCAL_DENSITY" == param) begin
	    local_density = value;
	 end
	 else if
	 else begin
	    $display ("Never heard of a: %s\n", param);
	    $exit();
	 end
      end
   endfunction
endclass

program tb (ifc.bench ds);
   router_transaction packet;
   router_test test;
   router_check checker;
   router_env env;

   int cycle;

   task do_cycle;
      env.cycle++;
      cycle = env.cycle;
      packet.randomize();

      /*
       *  pass data to golden model
       */

      /*
       *  pass data to DUT
       */

      @(ds.cb);

      test.golden_result();
   endtask

   initial begin
      packet = new();
      test = new();
      checker = new();
      env = new();
      env.configure("config.txt");

      repeat (env.warmup_time) begin
	 do_cycle();
      end

      repeat (env.max_transactions) begin
	 do_cycle();
	 checker.check_results();
	 $display("Cycle number: %d\n", cycle);
	 /* code for if the test was a success */
      end
   end
endprogram
