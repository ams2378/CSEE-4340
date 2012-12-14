/**
 * @filename  		router_test.sv 
 *
 * @brief     		The file includes the golden model of the router
 * @authors   		Ayushi Rajeev		<ar3110@columbia.edu>
 *			Ashwin Ramachandran	<ar2648@columbia.edu>
 *	     		
 *  	 
 */

class router_test;

   bit rst;

   bit valid_n_i;
   bit valid_s_i;
   bit valid_e_i;
   bit valid_w_i;
   bit valid_l_i;

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

   bit valid_n_o;
   bit valid_s_o;
   bit valid_e_o;
   bit valid_w_o;
   bit valid_l_o;

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

   logic [7:0] Myaddr_i = 8'b01001000;
   
   bit [4:0] req_port_addr_o [5];
   logic [15:0] dir_i [5];

   /*
    * input queues
    */
   bit [15:0] my_qn[$:5];
   bit [15:0] my_qs[$:5];
   bit [15:0] my_qe[$:5];  
   bit [15:0] my_qw[$:5];
   bit [15:0] my_ql[$:5];   

   /*
    * arbiter enable signals
    */
   bit en_n;
   bit en_s;
   bit en_e;
   bit en_w;
   bit en_l;

   /*
    * the enable signals and masks for the 5 arbiters
    */
   bit [4:0] enable;
   bit [4:0] mask;

   /*
    * the number of requests on each output
    */
   int n_north = 0;
   int n_south = 0;
   int n_east = 0;
   int n_west = 0;
   int n_local = 0;

   /*
    * one-hot grant decision of arbiter
    * where 00000 means nothing is selected
    */
   bit [4:0] last_dir [5] = '{0, 0, 0, 0, 0};

   /*
    * encoded grant decision of arbiter
    * where 111 means nothing is selected
    */
   bit [2:0] grant_arb [5] = '{1, 1, 1, 1, 1};

   /*
    * array of the different one-hot addresses
    */
   bit [4:0] one_hot_addr [5] = '{5'b00001, 5'b00010, 5'b00100, 5'b01000, 5'b10000};

   /*
    * grant for the xbar to output valid data
    */
   bit grant[5] = '{0, 0, 0, 0, 0};

   /*
    * count enable signal from FCC
    */
   bit count_en[5] = '{1, 1, 1, 1, 1};

   /*
    * the current counts for each neighboring queue
    */
   int count[5] = '{5, 5, 5, 5, 5};

   /*
    * queues for storing the address source
    */
   bit [2:0] n_addr[$:3];
   bit [2:0] s_addr[$:3];
   bit [2:0] e_addr[$:3];
   bit [2:0] w_addr[$:3];
   bit [2:0] l_addr[$:3];

   /*
    * count of how many flits of a message we've sent
    */
   int count_n = 0;
   int count_s = 0;
   int count_e = 0;
   int count_w = 0;
   int count_l = 0;

   /*
    * temporary variables to hold output data and valid
    * signals
    */
   logic [15:0] out_data[5];
   bit valid_data[5];

   /*
    * instantiate the variables to hold popped values
    */
   bit [15:0] north_q_o = '0;
   bit [15:0] south_q_o = '0;
   bit [15:0] east_q_o = '0;
   bit [15:0] west_q_o = '0;
   bit [15:0] local_q_o = '0;

   function void reset_router();
	req_port_addr_o [5] = '{0, 0, 0, 0, 0};
	dir_i [5] = '{0, 0, 0, 0, 0};

	my_qn = {};
	my_qs = {};
	my_qe = {};
	my_qw = {};
	my_ql = {};

	n_addr = {};
	n_addr.push_back('1);
	n_addr.push_back('1);

	s_addr = {};
	s_addr.push_back('1);
	s_addr.push_back('1);

	e_addr = {};
	e_addr.push_back('1);
	e_addr.push_back('1);

	w_addr = {};
	w_addr.push_back('1);
	w_addr.push_back('1);
	
	l_addr = {};
	l_addr.push_back('1);
	l_addr.push_back('1);

	enable = '1;
	mask = '0;

        n_north = 0;
        n_south = 0;
        n_east = 0;
        n_west = 0;
        n_local = 0;

	last_dir = '{0, 0, 0, 0, 0};

	grant_arb = '{1, 1, 1, 1, 1};

	grant = '{0, 0, 0, 0, 0};

	count_en = '{1, 1, 1, 1, 1};

	count = '{5, 5, 5, 5, 5};

	count_n = 0;
	count_s = 0;
	count_e = 0;
	count_w = 0;
	count_l = 0;

	out_data = '{0, 0, 0, 0, 0};
	valid_data = '{0, 0, 0, 0, 0};
   endfunction

   /*
    * this models pushing flits to the input buffers
    */
   function void input_buffer ();
	if (valid_n_i) begin
     		my_qn.push_back(north_i);
  	end	
	if (valid_s_i) begin
     		my_qs.push_back(south_i);
  	end		                  
 	if (valid_e_i) begin
     		my_qe.push_back(east_i);
  	end	
 	if (valid_w_i) begin
     		my_qw.push_back(west_i);
  	end
	if (valid_l_i) begin
    		my_ql.push_back(local_i);
  	end
   endfunction

   function void fsm ();
   	/*handling north queue*/
   	if (count_n == 0)begin
		if (grant[0] == 0) begin
      			count_n = 0;
      			en_n = 1;
    		end
    		else begin
      			north_q_o = my_qn.pop_front();
      			en_n = 0;
      			count_n++;
    		end
   	end
	else begin
		en_n = 0;
    		if (grant[0] == 1) begin
      			north_q_o = my_qn.pop_front();
      			count_n++;
      			if (count_n == 5) begin
         			en_n = 1;
				count_n = 0;
				north_reset();
      			end
    		end
	end

	/*handling south queue*/	                  
	if (count_s == 0) begin
    		if (grant[1] == 0) begin
      			count_s = 0;
      			en_s = 1;
    		end
    		else begin
      			south_q_o = my_qs.pop_front();
      			en_s = 0;
      			count_s++;
    		end
	end
	else begin
      		en_s = 0;
    		if (grant[1] == 1) begin
      			south_q_o = my_qs.pop_front();
     			count_s++;
      			if (count_s == 5) begin
         			en_s = 1;
				count_s = 0;
				south_reset();
      			end
    		end
	end

	/*handling east queue*/      
	if (count_e == 0) begin
    		if (grant[2] == 0) begin
      			count_e = 0;
      			en_e = 1;
    		end
    		else begin
      			east_q_o = my_qe.pop_front();
      			en_e = 0;
      			count_e++;
    		end
	end
	else begin
     		en_e = 0;
    		if (grant[2] == 1) begin
      			east_q_o = my_qe.pop_front();
      			count_e++;
      			if (count_e == 5) begin
         			en_e = 1;
				count_e = 0;
				east_reset();
      			end
    		end
	end

	/*handling west queue*/
	if (count_w == 0)begin
    		if (grant[3] == 0) begin
      			count_w = 0;
      			en_w = 1;
    		end
    		else begin
      			west_q_o = my_qw.pop_front();
      			en_w = 0;
      			count_w++;
    		end
	end
	else begin
      		en_w = 0;
    		if (grant[3] == 1) begin
      			west_q_o = my_qw.pop_front();
      			count_w++;
      			if (count_w == 5) begin
         			en_w = 1;
				count_w = 0;
				west_reset();
      			end
    		end
	end

	/*handling local queue*/	                  
	if (count_l == 0)begin
    		if (grant[4] == 0) begin
      			count_l = 0;
      			en_l = 1;
    		end
    		else begin
      			local_q_o = my_ql.pop_front();
      			en_l = 0;
      			count_l++;
   		end
	end
	else begin
      		en_l = 0;
    		if (grant[4] == 1) begin
      			local_q_o = my_ql.pop_front();
      			count_l++;
      			if (count_l == 5) begin
         			en_l = 1;
				count_l = 0;
				local_reset();
      			end
    		end
	end
   endfunction

   function void address_gen ();
	dir_i[0] = my_qn[0];
	dir_i[1] = my_qs[0];
	dir_i[2] = my_qe[0];
	dir_i[3] = my_qw[0];
	dir_i[4] = my_ql[0];

	for (int ind = 0; ind<5; ind++) begin
            if (dir_i[ind][7:4] != Myaddr_i[7:4]) begin
              	if (dir_i[ind][7:4] > Myaddr_i[7:4]) begin /* send north */
               		req_port_addr_o[ind] = 5'b00001;
                end
              	else begin
               		req_port_addr_o[ind] = 5'b00010;/* send south */
                end
            end 
            else begin
                if (dir_i[ind][3:0] > Myaddr_i[3:0]) begin /* send east */
               		req_port_addr_o[ind] = 5'b00100;
                end
                else if (dir_i[ind][3:0] < Myaddr_i[3:0]) begin /* send west */
               		req_port_addr_o[ind] = 5'b01000;
                end
                else if (dir_i[ind] == Myaddr_i) begin 
                	req_port_addr_o[ind] = 5'b10000; /* destination reached */
            	end
		else begin
			req_port_addr_o[ind] = 5'b00000;
		end
            end
	end
   endfunction

   function void arbiter_north();
	n_north = 0;

	/* mask the bits */
	req_port_addr_o[0] = req_port_addr_o[0] ^ mask;

	/* count the number of conflicts in the north output request */
	if (req_port_addr_o[0] == one_hot_addr[0]) begin
		n_north++;
	end
	if (req_port_addr_o[1] == one_hot_addr[0]) begin
		n_north++;
	end
	if (req_port_addr_o[2] == one_hot_addr[0]) begin
		n_north++;
	end
	if (req_port_addr_o[3] == one_hot_addr[0]) begin
		n_north++;
	end
	if (req_port_addr_o[4] == one_hot_addr[0]) begin
		n_north++;
	end


	if (n_north == 0) begin
		/* 
		 * if a certain output wasn't requested this cycle, set the
		 * input granted index to all zeros
		 * (00000 indicates that no one wants to use this output this cycle)
		 */
		last_dir[0] = '0;
	end
	else begin
		bit [4:0] start = '0;
		bit success = '0;
		if (n_north > 1) begin
			start = last_dir[0] + 1'b1;			
		end		
		while (success == 0) begin
			if (req_port_addr_o[start] == one_hot_addr[0]) begin
				success = 1;
				last_dir[0] = start;
			end
			start = start + 1'b1;	
		end
	end

	/*
	 * encode the one-hot values into 3-bit values
	 */
	if (last_dir[0] == 5'b00001) begin
		grant_arb[0] = 3'b000;
	end	
	else if (last_dir[0] == 5'b00010) begin
		grant_arb[0] = 3'b001;
	end
	else if (last_dir[0] == 5'b00100) begin
		grant_arb[0] = 3'b010;
	end
	else if (last_dir[0] == 5'b01000) begin
		grant_arb[0] = 3'b011;
	end
	else if (last_dir[0] == 5'b10000) begin
		grant_arb[0] = 3'b100;
	end
	else begin
		grant_arb[0] = '1;
	end
   endfunction

   function void arbiter_south();
	n_south = 0;

	/* mask the bits */
	req_port_addr_o[1] = req_port_addr_o[1] ^ mask;

	/* count the number of conflicts in the north output request */
	if (req_port_addr_o[0] == one_hot_addr[1]) begin
		n_south++;
	end
	if (req_port_addr_o[1] == one_hot_addr[1]) begin
		n_south++;
	end
	if (req_port_addr_o[2] == one_hot_addr[1]) begin
		n_south++;
	end
	if (req_port_addr_o[3] == one_hot_addr[1]) begin
		n_south++;
	end
	if (req_port_addr_o[4] == one_hot_addr[1]) begin
		n_south++;
	end


	if (n_south == 0) begin
		/* 
		 * if a certain output wasn't requested this cycle, set the
		 * input granted index to all zeros
		 * (00000 indicates that no one wants to use this output this cycle)
		 */
		last_dir[1] = '0;
	end
	else begin
		bit [4:0] start = '0;
		bit success = '0;
		if (n_south > 1) begin
			start = last_dir[1] + 1'b1;			
		end		
		while (success == 0) begin
			if (req_port_addr_o[start] == one_hot_addr[1]) begin
				success = 1;
				last_dir[1] = start;
			end
			start = start + 1'b1;	
		end
	end

	/*
	 * encode the one-hot values into 3-bit values
	 */
	if (last_dir[1] == 5'b00001) begin
		grant_arb[1] = 3'b000;
	end	
	else if (last_dir[1] == 5'b00010) begin
		grant_arb[1] = 3'b001;
	end
	else if (last_dir[1] == 5'b00100) begin
		grant_arb[1] = 3'b010;
	end
	else if (last_dir[1] == 5'b01000) begin
		grant_arb[1] = 3'b011;
	end
	else if (last_dir[1] == 5'b10000) begin
		grant_arb[1] = 3'b100;
	end
	else begin
		grant_arb[1] = '1;
	end
   endfunction

   function void arbiter_east();
	n_east = 0;

	/* mask the bits */
	req_port_addr_o[2] = req_port_addr_o[2] ^ mask;

	/* count the number of conflicts in the north output request */
	if (req_port_addr_o[0] == one_hot_addr[2]) begin
		n_east++;
	end
	if (req_port_addr_o[1] == one_hot_addr[2]) begin
		n_east++;
	end
	if (req_port_addr_o[2] == one_hot_addr[2]) begin
		n_east++;
	end
	if (req_port_addr_o[3] == one_hot_addr[2]) begin
		n_east++;
	end
	if (req_port_addr_o[4] == one_hot_addr[2]) begin
		n_east++;
	end

	if (n_east == 0) begin
		/* 
		 * if a certain output wasn't requested this cycle, set the
		 * input granted index to all zeros
		 * (00000 indicates that no one wants to use this output this cycle)
		 */
		last_dir[2] = '0;
	end
	else begin
		bit [4:0] start = '0;
		bit success = '0;
		if (n_east > 1) begin
			start = last_dir[2] + 1'b1;			
		end		
		while (success == 0) begin
			if (req_port_addr_o[start] == one_hot_addr[2]) begin
				success = 1;
				last_dir[2] = start;
			end
			start = start + 1'b1;	
		end
	end

	/*
	 * encode the one-hot values into 3-bit values
	 */
	if (last_dir[2] == 5'b00001) begin
		grant_arb[2] = 3'b000;
	end	
	else if (last_dir[2] == 5'b00010) begin
		grant_arb[2] = 3'b001;
	end
	else if (last_dir[2] == 5'b00100) begin
		grant_arb[2] = 3'b010;
	end
	else if (last_dir[2] == 5'b01000) begin
		grant_arb[2] = 3'b011;
	end
	else if (last_dir[2] == 5'b10000) begin
		grant_arb[2] = 3'b100;
	end
	else begin
		grant_arb[2] = '1;
	end
   endfunction

   function void arbiter_west();
	n_west = 0;

	/* mask the bits */
	req_port_addr_o[3] = req_port_addr_o[3] ^ mask;

	/* count the number of conflicts in the north output request */
	if (req_port_addr_o[0] == one_hot_addr[3]) begin
		n_west++;
	end
	if (req_port_addr_o[1] == one_hot_addr[3]) begin
		n_west++;
	end
	if (req_port_addr_o[2] == one_hot_addr[3]) begin
		n_west++;
	end
	if (req_port_addr_o[3] == one_hot_addr[3]) begin
		n_west++;
	end
	if (req_port_addr_o[4] == one_hot_addr[3]) begin
		n_west++;
	end


	if (n_west == 0) begin
		/* 
		 * if a certain output wasn't requested this cycle, set the
		 * input granted index to all zeros
		 * (00000 indicates that no one wants to use this output this cycle)
		 */
		last_dir[3] = '0;
	end
	else begin
		bit [4:0] start = '0;
		bit success = '0;
		if (n_west > 1) begin
			start = last_dir[3] + 1'b1;			
		end		
		while (success == 0) begin
			if (req_port_addr_o[start] == one_hot_addr[3]) begin
				success = 1;
				last_dir[3] = start;
			end
			start = start + 1'b1;	
		end
	end

	/*
	 * encode the one-hot values into 3-bit values
	 */
	if (last_dir[3] == 5'b00001) begin
		grant_arb[3] = 3'b000;
	end	
	else if (last_dir[3] == 5'b00010) begin
		grant_arb[3] = 3'b001;
	end
	else if (last_dir[3] == 5'b00100) begin
		grant_arb[3] = 3'b010;
	end
	else if (last_dir[3] == 5'b01000) begin
		grant_arb[3] = 3'b011;
	end
	else if (last_dir[3] == 5'b10000) begin
		grant_arb[3] = 3'b100;
	end
	else begin
		grant_arb[3] = '1;
	end
   endfunction

   function void arbiter_local();
	n_local = 0;

	/* mask the bits */
	req_port_addr_o[4] = req_port_addr_o[4] ^ mask;

	/* count the number of conflicts in the north output request */
	if (req_port_addr_o[0] == one_hot_addr[4]) begin
		n_local++;
	end
	if (req_port_addr_o[1] == one_hot_addr[4]) begin
		n_local++;
	end
	if (req_port_addr_o[2] == one_hot_addr[4]) begin
		n_local++;
	end
	if (req_port_addr_o[3] == one_hot_addr[4]) begin
		n_local++;
	end
	if (req_port_addr_o[4] == one_hot_addr[4]) begin
		n_local++;
	end


	if (n_local == 0) begin
		/* 
		 * if a certain output wasn't requested this cycle, set the
		 * input granted index to all zeros
		 * (00000 indicates that no one wants to use this output this cycle)
		 */
		last_dir[4] = '0;
	end
	else begin
		bit [4:0] start = '0;
		bit success = '0;
		if (n_local > 1) begin
			start = last_dir[4] + 1'b1;			
		end		
		while (success == 0) begin
			if (req_port_addr_o[start] == one_hot_addr[4]) begin
				success = 1;
				last_dir[4] = start;
			end
			start = start + 1'b1;	
		end
	end

	/*
	 * encode the one-hot values into 3-bit values
	 */
	if (last_dir[4] == 5'b00001) begin
		grant_arb[4] = 3'b000;
	end	
	else if (last_dir[4] == 5'b00010) begin
		grant_arb[4] = 3'b001;
	end
	else if (last_dir[4] == 5'b00100) begin
		grant_arb[4] = 3'b010;
	end
	else if (last_dir[4] == 5'b01000) begin
		grant_arb[4] = 3'b011;
	end
	else if (last_dir[4] == 5'b10000) begin
		grant_arb[4] = 3'b100;
	end
	else begin
		grant_arb[4] = '1;
	end
   endfunction

   function void north_reset();
	n_addr = {};
	n_addr.push_back('1);
	n_addr.push_back('1);
   endfunction

   function void south_reset();
	s_addr = {};
	s_addr.push_back('1);
	s_addr.push_back('1);
   endfunction

   function void east_reset();
	e_addr = {};
	e_addr.push_back('1);	
	e_addr.push_back('1);
   endfunction

   function void west_reset();
	w_addr = {};
	w_addr.push_back('1);	
	w_addr.push_back('1);
   endfunction

   function void local_reset();
	l_addr = {};
	l_addr.push_back('1);	
	l_addr.push_back('1);
   endfunction

   function void fcc();
	bit incr_i[5] = {n_incr_i, s_incr_i, e_incr_i, w_incr_i, l_incr_i};

	for (int ind = 0; ind < 5; ind++) begin
		/* control the enable signal */
		if (count[ind] == 0) begin
			count_en[ind] = 0;	
		end
		else begin
			count_en[ind] = 1;
		end

		/* control the increase input */
		if (incr_i[ind] && (count[ind] < 5)) begin
			count[ind]++;
		end

		/* control the decrease input */
		if (valid_data[ind] && (count[ind] > 0)) begin
			count[ind]--;
		end
	end
   endfunction

   function void fcu();	
	for (int ind = 0; ind < 5; ind++) begin
		if ((grant_arb[ind] != '1) && count_en[ind]) begin
			grant[ind] = 1;
		end
	end
   endfunction

   function void xbar();
	for (int ind = 0; ind < 5; ind++) begin
		if (grant_arb[ind] == 3'b000) begin
			valid_data[ind] = grant[ind];
			out_data[ind] = north_q_o;
		end
		else if (grant_arb[ind] == 3'b001) begin
			valid_data[ind] = grant[ind];
			out_data[ind] = south_q_o;
		end
		else if (grant_arb[ind] == 3'b010) begin
			valid_data[ind] = grant[ind];
			out_data[ind] = east_q_o;
		end
		else if (grant_arb[ind] == 3'b011) begin
			valid_data[ind] = grant[ind];
			out_data[ind] = west_q_o;
		end
		else if (grant_arb[ind] == 3'b100) begin
			valid_data[ind] = grant[ind];
			out_data[ind] = local_q_o;
		end
		else begin
			valid_data[ind] = 0;
			out_data[ind] = '0;
		end
	end

	north_o = out_data[0];
	south_o = out_data[1];
	east_o  = out_data[2];
	west_o  = out_data[3];
	local_o = out_data[4];

	valid_n_o = valid_data[0];
	valid_s_o = valid_data[1];
	valid_e_o = valid_data[2];
	valid_w_o = valid_data[3];
	valid_l_o = valid_data[4];
   endfunction

endclass
