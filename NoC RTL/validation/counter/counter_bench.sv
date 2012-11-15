/**
 * @filename  		counter_bench.sv 
 *
 * @brief     		The file includes the software model of the router and the random verification tb
 * @authors   		Ayushi Rajeev <ar3110@columbia.edu>
 Ashwin Ramachandran <ar2648@columbia.edu>
 *	     		
 *  	 
 */

class counter_transaction;

   function new();
   endfunction

endclass

class counter_test;

   function void golden_result();
   endfunction

endclass

class counter_check;

   function bit check_results();
   endfunction

endclass

class counter_env;
   int cycle = 0;
   int max_transactions = 10000;
   int warmup_time = 10;
   bit verbose = 1;

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
	 else begin
	    $display ("Never heard of a: %s\n", param);
	    $exit();
	 end
      end
   endfunction
endclass

program tb (ifc_counter.bench ds);
   counter_transaction packet;
   counter_test test;
   counter_check checker;
   counter_env env;

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
