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
   /*
    * incoming packet transaction densities
    */

   int reset_density;
   
   /* whether or not a flit is send */
   int north_density;
   int south_density;
   int east_density;
   int west_density;
   int local_density;

   /* the flit itself */
   rand bit [15:0] north_flit;
   rand bit [15:0] south_flit;
   rand bit [15:0] east_flit;
   rand bit [15:0] west_flit;
   rand bit [15:0] local_flit;

   /* 
    * random position of the hot bit in
    * the header flit's x coordinate
    */
   rand int onepos_x_north;
   rand int onepos_x_south;
   rand int onepos_x_east;
   rand int onepos_x_west;
   rand int onepos_x_local;

   /* 
    * random position of the hot bit in
    * the header flit's y coordinate
    */
   rand int onepos_y_north;
   rand int onepos_y_south;
   rand int onepos_y_east;
   rand int onepos_y_west;
   rand int onepos_y_local;

   constraint hotBits {
	onepos_x_north >= 4;
        onepos_x_north <= 7;

	onepos_x_south >= 4;
        onepos_x_south <= 7;

	onepos_x_east >= 4;
        onepos_x_east <= 7;

	onepos_x_west >= 4;
        onepos_x_west <= 7;

	onepos_x_local >= 4;
        onepos_x_local <= 7;

	onepos_y_north >= 0;
        onepos_y_north <= 3;

	onepos_y_south >= 0;
        onepos_y_south <= 3;

	onepos_y_east >= 0;
        onepos_y_east <= 3;

	onepos_y_west >= 0;
        onepos_y_west <= 3;

	onepos_y_local >= 0;
        onepos_y_local <= 3;
   }

   /* counter increment requests */
   int n_incr_density;
   int s_incr_density;
   int e_incr_density;
   int w_incr_density;
   int l_incr_density;

   function new(int rst_d,
		int north_d,
		int south_d,
		int east_d,
		int west_d,
		int loc_d,

		int n_incr_d,
		int s_incr_d,
		int e_incr_d,
		int w_incr_d,
		int l_incr_d);

	reset_density = rst_d;

	north_density = north_d;
	south_density = south_d;
	east_density = east_d;
	west_density = west_d;
	local_density = loc_d;

	n_incr_density = n_incr_d;
	s_incr_density = s_incr_d;
	e_incr_density = e_incr_d;
	w_incr_density = w_incr_d;
	l_incr_density = l_incr_d;
   endfunction

   /*
    * randomly generated values to determine if we have
    * a flit transaction on any of the 5 input ports
    */
   rand bit reset_req;

   rand bit north_req;
   rand bit south_req;
   rand bit east_req;
   rand bit west_req;
   rand bit local_req;

   /*
    * randomly generated values to determine if we have
    * a increment request for any of the 5 neighbors
    */
   rand bit n_incr_req;
   rand bit s_incr_req;
   rand bit e_incr_req;
   rand bit w_incr_req;
   rand bit l_incr_req;

   /*
    * constrain the values so that they are 0 or 1 based on
    * the randomly generated value
    */
   constraint density_dist {
	reset_req dist {0:/100-reset_density, 1:/reset_density};

	north_req dist {0:/100-north_density, 1:/north_density};
	south_req dist {0:/100-south_density, 1:/south_density};
	east_req dist {0:/100-east_density, 1:/east_density};
	west_req dist {0:/100-west_density, 1:/west_density};
	local_req dist {0:/100-local_density, 1:/local_density};

	n_incr_req dist {0:/100-n_incr_density, 1:/n_incr_density};
	s_incr_req dist {0:/100-s_incr_density, 1:/s_incr_density};
	e_incr_req dist {0:/100-e_incr_density, 1:/e_incr_density};
	w_incr_req dist {0:/100-w_incr_density, 1:/w_incr_density};
	l_incr_req dist {0:/100-l_incr_density, 1:/l_incr_density};
   }

   int flit_cnt_n = 0;
   int flit_cnt_s = 0;
   int flit_cnt_e = 0;
   int flit_cnt_w = 0;
   int flit_cnt_l = 0;
endclass

class router_test;

   bit rst;

   logic [15:0] north_i;
   logic [15:0] south_i;
   logic [15:0] east_i;
   logic [15:0] west_i;
   logic [15:0] local_i;

   bit 	n_incr_i;
   bit 	s_incr_i;
   bit 	e_incr_i;
   bit 	w_incr_i;
   bit 	l_incr_i;

   logic [15:0] north_o;
   logic [15:0] south_o;
   logic [15:0] east_o;
   logic [15:0] west_o;
   logic [15:0] local_o;

   bit 	n_incr_o;
   bit 	s_incr_o;
   bit 	e_incr_o;
   bit 	w_incr_o;
   bit 	l_incr_o;

   /* local count of free spaces in our input queues */
   int n_q_free = 5;
   int s_q_free = 5;
   int e_q_free = 5;
   int w_q_free = 5;
   int l_q_free = 5;

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

      if (test.n_q_free > 0) begin // there is space in our input queue
	if (env.n_sent == 0) begin // need a header flit
		if (packet.north_req == 1) begin
			// make a header packet
			packet.north_flit = '0;
			packet.north_flit[onepos_x_north] = 1;
			packet.north_flit[onepos_y_north] = 1;
			env.n_sent++;
		end
	end
	else if (env.n_sent == 4) begin // sending the last body flit
		env.n_sent = 0;
	end
	else begin // sending a middle body flit
		env.n_sent++;	
	end
      end
      /*
       *  pass data to golden model
       */

      test.rst		<=	packet.reset_req;

      test.north_i	<=	packet.north_flit;
      test.south_i	<=	packet.south_flit;
      test.east_i	<=	packet.east_flit;
      test.west_i	<=	packet.west_flit;
      test.local_i	<=	packet.local_flit;

      test.n_incr_i	<=	packet.n_incr_req;
      test.s_incr_i	<=	packet.s_incr_req;
      test.e_incr_i	<=	packet.e_incr_req;
      test.w_incr_i	<=	packet.w_incr_req;
      test.l_incr_i	<=	packet.l_incr_req;

      /*
       *  pass data to DUT
       */

      ds.cb.rst		<=	packet.reset_req;

      ds.cb.north_i	<=	packet.north_flit;
      ds.cb.south_i	<=	packet.south_flit;
      ds.cb.east_i	<=	packet.east_flit;
      ds.cb.west_i	<=	packet.west_flit;
      ds.cb.local_i	<=	packet.local_flit;

      ds.cb.n_incr_i	<=	packet.n_incr_req;
      ds.cb.s_incr_i	<=	packet.s_incr_req;
      ds.cb.e_incr_i	<=	packet.e_incr_req;
      ds.cb.w_incr_i	<=	packet.w_incr_req;
      ds.cb.l_incr_i	<=	packet.l_incr_req;

      @(ds.cb);

      test.golden_result();
   endtask

   initial begin
      test = new();
      
      checker = new();
      
      env = new();
      env.configure("config.txt");
      
      packet = new(env.reset_density, env.north_density, env.south_density, env.east_density,
		   env.west_density, env.local_density, env.n_incr_density, env.s_incr_density,
		   env.e_incr_density, env.w_incr_density, env.l_incr_density);
      
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
