/**
 * @filename  		router_env.sv 
 *
 * @brief     		The file includes the environment class
 * @authors   		Ayushi Rajeev		<ar3110@columbia.edu>
 *			Ashwin Ramachandran	<ar2648@columbia.edu>
 *	     		
 *  	 
 */

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

   int n_incr_density = 20;
   int s_incr_density = 20;
   int e_incr_density = 20;
   int w_incr_density = 20;
   int l_incr_density = 20;

   /* 
    * local count of how many flits of a message have
    * been sent to the router node
    */
   int n_sent = 0;
   int s_sent = 0;
   int e_sent = 0;
   int w_sent = 0;
   int l_sent = 0;

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
	 else if("N_INCR_DENSITY" == param) begin
	    n_incr_density = value;
	 end
	 else if("S_INCR_DENSITY" == param) begin
	    s_incr_density = value;
	 end
	 else if("E_INCR_DENSITY" == param) begin
	    e_incr_density = value;
	 end
	 else if("W_INCR_DENSITY" == param) begin
	    w_incr_density = value;
	 end
	 else if("L_INCRA_DENSITY" == param) begin
	    l_incr_density = value;
	 end
	 else begin
	    $display ("Never heard of a: %s\n", param);
	    $exit();
	 end
      end
   endfunction
endclass
