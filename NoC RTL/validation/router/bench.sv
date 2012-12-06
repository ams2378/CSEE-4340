/**
 * @filename  		bench.sv 
 *
 * @brief     		The file includes the software model of the router and the random verification TB
 * @authors   		Ayushi Rajeev		<ar3110@columbia.edu>
 *			Ashwin Ramachandran	<ar2648@columbia.edu>
 *	     		
 *  	 
 */

/*
 * these 5 functions assemble a either a header or a body
 * flit based on how many flits were sent before it and whether
 * or not we randomly choose to send a flit to the router this
 * cycle
 */
function make_north(router_transaction packet, router_env env);
	if (env.n_sent == 0) begin // need a header flit
		if (packet.north_req == 1) begin
			packet.north_flit = '0;
			packet.north_flit[packet.onepos_x_north] = 1;
			packet.north_flit[packet.onepos_y_north] = 1;
			env.n_sent++;
		end
	end
	else if (env.n_sent == 4) begin // sending the last body flit
		env.n_sent = 0;
	end
	else begin // sending a middle body flit
		env.n_sent++;	
	end
endfunction

function make_south(router_transaction packet, router_env env);
	if (env.s_sent == 0) begin // need a header flit
		if (packet.south_req == 1) begin
			packet.south_flit = '0;
			packet.south_flit[packet.onepos_x_south] = 1;
			packet.south_flit[packet.onepos_y_south] = 1;
			env.s_sent++;
		end
	end
	else if (env.s_sent == 4) begin // sending the last body flit
		env.s_sent = 0;
	end
	else begin // sending a middle body flit
		env.s_sent++;	
	end
endfunction

function make_east(router_transaction packet, router_env env);
	if (env.e_sent == 0) begin // need a header flit
		if (packet.east_req == 1) begin
			packet.east_flit = '0;
			packet.east_flit[packet.onepos_x_east] = 1;
			packet.east_flit[packet.onepos_y_east] = 1;
			env.e_sent++;
		end
	end
	else if (env.e_sent == 4) begin // sending the last body flit
		env.e_sent = 0;
	end
	else begin // sending a middle body flit
		env.e_sent++;	
	end
endfunction

function make_west(router_transaction packet, router_env env);
	if (env.w_sent == 0) begin // need a header flit
		if (packet.west_req == 1) begin
			packet.west_flit = '0;
			packet.west_flit[packet.onepos_x_west] = 1;
			packet.west_flit[packet.onepos_y_west] = 1;
			env.w_sent++;
		end
	end
	else if (env.w_sent == 4) begin // sending the last body flit
		env.w_sent = 0;
	end
	else begin // sending a middle body flit
		env.w_sent++;	
	end
endfunction

function make_local(router_transaction packet, router_env env);
	if (env.l_sent == 0) begin // need a header flit
		if (packet.local_req == 1) begin
			packet.local_flit = '0;
			packet.local_flit[packet.onepos_x_local] = 1;
			packet.local_flit[packet.onepos_y_local] = 1;
			env.l_sent++;
		end
	end
	else if (env.l_sent == 4) begin // sending the last body flit
		env.l_sent = 0;
	end
	else begin // sending a middle body flit
		env.l_sent++;	
	end
endfunction

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
       * determine whether or not we have to send a flit to
       * the router based on if it has space in its input buffer
       */
      if (env.n_q_free > 0) begin
	make_north(packet, env);
      end
      if (env.s_q_free > 0) begin
	make_south(packet, env);
      end
      if (env.e_q_free > 0) begin
	make_east(packet, env);
      end
      if (env.w_q_free > 0) begin
	make_west(packet, env);
      end
      if (env.l_q_free > 0) begin
	make_local(packet, env);
      end

      /*
       *  pass data to golden model
       */

      test.rst		<=	packet.reset_req;

      test.valid_n_i	<=	packet.north_req;
      test.valid_s_i	<=	packet.south_req;
      test.valid_e_i	<=	packet.east_req;
      test.valid_w_i	<=	packet.west_req;
      test.valid_l_i	<=	packet.local_req;

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

      ds.cb.valid_n_i	<=	packet.north_req;
      ds.cb.valid_s_i	<=	packet.south_req;
      ds.cb.valid_e_i	<=	packet.east_req;
      ds.cb.valid_w_i	<=	packet.west_req;
      ds.cb.valid_l_i	<=	packet.local_req;

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
	 //checker.check_results();
	 $display("Cycle number: %d\n", cycle);
	 /* code for if the test was a success */
      end
   end
endprogram
