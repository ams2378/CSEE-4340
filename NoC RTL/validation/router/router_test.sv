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

   bit 		n_incr_i;
   bit 		s_incr_i;
   bit 		e_incr_i;
   bit 		w_incr_i;
   bit 		l_incr_i;

   bit 		valid_n_o;
   bit 		valid_s_o;
   bit 		valid_e_o;
   bit 		valid_w_o;
   bit 		valid_l_o;

   logic [15:0] north_o;
   logic [15:0] south_o;
   logic [15:0] east_o;
   logic [15:0] west_o;
   logic [15:0] local_o;

   bit 		n_incr_o;
   bit 		s_incr_o;
   bit 		e_incr_o;
   bit 		w_incr_o;
   bit 		l_incr_o;

   logic [7:0] 	Myaddr_i = 8'b00100010;
   
   bit [4:0] 	req_port_addr_o [5];
   logic [15:0] dir_i [5];

   /*
    * input queues
    */
   bit [15:0] 	my_qn[$:4];
   bit [15:0] 	my_qs[$:4];
   bit [15:0] 	my_qe[$:4];  
   bit [15:0] 	my_qw[$:4];
   bit [15:0] 	my_ql[$:4];   

   /*
    * arbiter enable signals
    */
   bit 		en_n;
   bit 		en_s;
   bit 		en_e;
   bit 		en_w;
   bit 		en_l;

   /*
    * arbiter enable queues
    */
   bit		en_q_n[$:1];
   bit		en_q_s[$:1];
   bit		en_q_e[$:1];
   bit		en_q_w[$:1];
   bit		en_q_l[$:1];

   /*
    * the masks for the 5 arbiters
    */
   bit [4:0] 	mask;

   /*
    * the number of requests on each output
    */
   int 		n_north = 0;
   int 		n_south = 0;
   int 		n_east = 0;
   int 		n_west = 0;
   int 		n_local = 0;

   /*
    * one-hot grant decision of arbiter
    * where 00000 means nothing is selected
    */
   bit [3:0] 	last_dir [5] = '{'1, '1, '1, '1, '1};

   /*
    * encoded grant decision of arbiter
    * where 111 means nothing is selected
    */
   bit [2:0] 	grant_arb [5] = '{'1, '1, '1, '1, '1};

   /*
    * array of the different one-hot addresses
    */
   bit [4:0] 	one_hot_addr [5] = '{5'b00001, 5'b00010, 5'b00100, 5'b01000, 5'b10000};

   /*
    * grant for the xbar to output valid data
    */
   bit 		grant[5] = '{'0, '0, '0, '0, '0};

   /*
    * count enable signal from FCC
    */
   bit 		count_en[5] = '{'1, '1, '1, '1, '1};

   /*
    * the current counts for each neighboring queue
    */
   int 		count[5] = '{5, 5, 5, 5, 5};

   /*
    * queues for storing the address source
    */
   bit [2:0] 	n_addr[$:1] = '{3'b111, 3'b111};
   bit [2:0] 	s_addr[$:1] = '{3'b111, 3'b111};
   bit [2:0] 	e_addr[$:1] = '{3'b111, 3'b111};
   bit [2:0] 	w_addr[$:1] = '{3'b111, 3'b111};
   bit [2:0] 	l_addr[$:1] = '{3'b111, 3'b111};

   /*
    * queues for storing the AGU output/Arbiter input
    */
   bit [4:0] 	n_agu[$:1] = '{5'b00000, 5'b00000};
   bit [4:0] 	s_agu[$:1] = '{5'b00000, 5'b00000};
   bit [4:0] 	e_agu[$:1] = '{5'b00000, 5'b00000};
   bit [4:0] 	w_agu[$:1] = '{5'b00000, 5'b00000};
   bit [4:0] 	l_agu[$:1] = '{5'b00000, 5'b00000};

   /*
    * count of how many flits of a message we've sent
    */
   int 		count_n = 0;
   int 		count_s = 0;
   int 		count_e = 0;
   int 		count_w = 0;
   int 		count_l = 0;

   /*
    * count for the mask bits
    */
   int 		count_mask_n = 0;
   int 		count_mask_s = 0;
   int 		count_mask_e = 0;
   int 		count_mask_w = 0;
   int 		count_mask_l = 0;

   /*
    * temporary variables to hold output data and incr
    * signals
    */
   logic [15:0] out_data[5];
   bit 	valid_data[5];

   /*
    * instantiate the variables to hold popped values
    */
   bit [15:0] 	north_q_o = '0;
   bit [15:0] 	south_q_o = '0;
   bit [15:0] 	east_q_o = '0;
   bit [15:0] 	west_q_o = '0;
   bit [15:0] 	local_q_o = '0;

   function void reset_router();
      dir_i = '{'0, '0, '0, '0, '0};

      my_qn = {};
      my_qs = {};
      my_qe = {};
      my_qw = {};
      my_ql = {};

      n_en_reset();
      s_en_reset();
      e_en_reset();
      w_en_reset();
      l_en_reset();

      n_agu_reset();
      s_agu_reset();
      e_agu_reset();
      w_agu_reset();
      l_agu_reset();

      north_reset();
      south_reset();
      east_reset();
      west_reset();
      local_reset();

      en_n = 1;
      en_s = 1;
      en_e = 1;
      en_w = 1;
      en_l = 1;

      mask = '0;

      n_north = 0;
      n_south = 0;
      n_east = 0;
      n_west = 0;
      n_local = 0;

      last_dir = '{'1, '1, '1, '1, '1};

      grant_arb = '{'1, '1, '1, '1, '1};

      grant = '{'0, '0, '0, '0, '0};

      count_en = '{'1, '1, '1, '1, '1};

      count = '{5, 5, 5, 5, 5};

      count_n = 0;
      count_s = 0;
      count_e = 0;
      count_w = 0;
      count_l = 0;

      count_mask_n = 0;
      count_mask_s = 0;
      count_mask_e = 0;
      count_mask_w = 0;
      count_mask_l = 0;

      out_data = '{'0, '0, '0, '0, '0};
      valid_data = '{'0, '0, '0, '0, '0};

      valid_n_o = '0;
      valid_s_o = '0;
      valid_e_o = '0;
      valid_w_o = '0;
      valid_l_o = '0;

      north_o = '0;
      south_o = '0;
      east_o = '0;
      west_o = '0;
      local_o = '0;

      n_incr_o = 1'b0;
      s_incr_o = 1'b0;
      e_incr_o = 1'b0;
      w_incr_o = 1'b0;
      l_incr_o = 1'b0;
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
      /* north masking/popping */
      if (count_mask_n == 0) begin
	 if (grant[0] == 1) begin
	    north_q_o = my_qn.pop_front();
	    mask[0] = 1;
	    count_mask_n++;		
	 end
	 else begin
	    mask[0] = 0;
	 end	
      end
      else begin
	 mask[0] = 1;
	 if (grant[0] == 1) begin
	    north_q_o = my_qn.pop_front();			
	    count_mask_n++;
	    if (count_mask_n == 5) begin
	       mask[0] = 0;
	       count_mask_n = 0;			
	    end	
	 end	
      end

      /* south masking/popping */
      if (count_mask_s == 0) begin
	 if (grant[1] == 1) begin
	    south_q_o = my_qs.pop_front();
	    mask[1] = 1;
	    count_mask_s++;		
	 end
	 else begin
	    mask[1] = 0;
	 end	
      end
      else begin
	 mask[1] = 1;
	 if (grant[1] == 1) begin
	    south_q_o = my_qs.pop_front();			
	    count_mask_s++;
	    if (count_mask_s == 5) begin
	       mask[1] = 0;
	       count_mask_s = 0;			
	    end	
	 end	
      end

      /* east masking/popping */
      if (count_mask_e == 0) begin
	 if (grant[2] == 1) begin
	    east_q_o = my_qe.pop_front();
	    mask[2] = 1;
	    count_mask_e++;		
	 end
	 else begin
	    mask[2] = 0;
	 end	
      end
      else begin
	 mask[2] = 1;
	 if (grant[2] == 1) begin
	    east_q_o = my_qe.pop_front();			
	    count_mask_e++;
	    if (count_mask_e == 5) begin
	       mask[2] = 0;
	       count_mask_e = 0;			
	    end	
	 end	
      end

      /* west masking/popping */
      if (count_mask_w == 0) begin
	 if (grant[3] == 1) begin
	    west_q_o = my_qw.pop_front();
	    mask[3] = 1;
	    count_mask_w++;		
	 end
	 else begin
	    mask[3] = 0;
	 end	
      end
      else begin
	 mask[3] = 1;
	 if (grant[3] == 1) begin
	    west_q_o = my_qw.pop_front();			
	    count_mask_w++;
	    if (count_mask_w == 5) begin
	       mask[3] = 0;
	       count_mask_w = 0;			
	    end	
	 end	
      end

      /* local masking/popping */
      if (count_mask_l == 0) begin
	 if (grant[4] == 1) begin
	    local_q_o = my_ql.pop_front();
	    mask[4] = 1;
	    count_mask_l++;		
	 end
	 else begin
	    mask[4] = 0;
	 end	
      end
      else begin
	 mask[4] = 1;
	 if (grant[4] == 1) begin
	    local_q_o = my_ql.pop_front();			
	    count_mask_l++;
	    if (count_mask_l == 5) begin
	       mask[4] = 0;
	       count_mask_l = 0;			
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
	 if (((dir_i[ind][3:0] == 4'b0001) || (dir_i[ind][3:0] == 4'b0010) ||
	      (dir_i[ind][3:0] == 4'b0100) || (dir_i[ind][3:0] == 4'b1000)) &&
	     ((dir_i[ind][7:4] == 4'b0001) || (dir_i[ind][7:4] == 4'b0010) ||
	      (dir_i[ind][7:4] == 4'b0100) || (dir_i[ind][7:4] == 4'b1000))) begin // valid address
	    if (dir_i[ind][3:0] != Myaddr_i[3:0]) begin
	       if (dir_i[ind][3:0] > Myaddr_i[3:0]) begin /* send north */
		  if (ind == 0) begin
		     n_agu.push_back(5'b00001);
		  end
		  else if (ind == 1) begin
		     s_agu.push_back(5'b00001);
		  end
		  else if (ind == 2) begin
		     e_agu.push_back(5'b00001);
		  end
		  else if (ind == 3) begin
		     w_agu.push_back(5'b00001);
		  end
		  else if (ind == 4) begin
		     l_agu.push_back(5'b00001);
		  end
	       end
	       else begin
		  if (ind == 0) begin
		     n_agu.push_back(5'b00010);
		  end
		  else if (ind == 1) begin
		     s_agu.push_back(5'b00010);
		  end
		  else if (ind == 2) begin
		     e_agu.push_back(5'b00010);
		  end
		  else if (ind == 3) begin
		     w_agu.push_back(5'b00010);
		  end
		  else if (ind == 4) begin
		     l_agu.push_back(5'b00010);
		  end
	       end
	    end 
	    else begin
	       if (dir_i[ind][7:4] < Myaddr_i[7:4]) begin /* send east */
		  if (ind == 0) begin
		     n_agu.push_back(5'b00100);
		  end
		  else if (ind == 1) begin
		     s_agu.push_back(5'b00100);
		  end
		  else if (ind == 2) begin
		     e_agu.push_back(5'b00100);
		  end
		  else if (ind == 3) begin
		     w_agu.push_back(5'b00100);
		  end
		  else if (ind == 4) begin
		     l_agu.push_back(5'b00100);
		  end
	       end
	       else if (dir_i[ind][3:0] > Myaddr_i[3:0]) begin /* send west */
		  if (ind == 0) begin
		     n_agu.push_back(5'b01000);
		  end
		  else if (ind == 1) begin
		     s_agu.push_back(5'b01000);
		  end
		  else if (ind == 2) begin
		     e_agu.push_back(5'b01000);
		  end
		  else if (ind == 3) begin
		     w_agu.push_back(5'b01000);
		  end
		  else if (ind == 4) begin
		     l_agu.push_back(5'b01000);
		  end
	       end
	       else if (dir_i[ind] == Myaddr_i) begin
		  /* destination reached */
		  if (ind == 0) begin
		     n_agu.push_back(5'b10000);
		  end
		  else if (ind == 1) begin
		     s_agu.push_back(5'b10000);
		  end
		  else if (ind == 2) begin
		     e_agu.push_back(5'b10000);
		  end
		  else if (ind == 3) begin
		     w_agu.push_back(5'b10000);
		  end
		  else if (ind == 4) begin
		     l_agu.push_back(5'b10000);
		  end
	       end
	    end
	 end
	 else begin
	    if (ind == 0) begin
	       n_agu.push_back(5'b00000);
	    end
	    else if (ind == 1) begin
	       s_agu.push_back(5'b00000);
	    end
	    else if (ind == 2) begin
	       e_agu.push_back(5'b00000);
	    end
	    else if (ind == 3) begin
	       w_agu.push_back(5'b00000);
	    end
	    else if (ind == 4) begin
	       l_agu.push_back(5'b00000);
	    end
         end
      end
   endfunction

   function void make_enables();
      bit [4:0] req_n;
      bit [4:0] req_s;
      bit [4:0] req_e;
      bit [4:0] req_w;
      bit [4:0] req_l;

      req_n = {l_agu[$][0], w_agu[$][0], e_agu[$][0], s_agu[$][0], n_agu[$][0]};
      if (count_n == 0) begin
	 if (req_n == 5'b00000) begin
	    en_q_n.push_back(1'b0);
	 end
	 else begin
	    count_n++;
	    en_q_n.push_back(1'b1);
	 end
      end
      else begin
	 en_q_n.push_back(1'b0);
	 if (valid_n_o) begin
	    count_n++;
	    if (count_n == 6) begin
	       count_n = 0;
	       n_en_reset();
	       n_agu_reset();
	       north_reset();
	    end
	 end
      end

      req_s = {l_agu[$][1], w_agu[$][1], e_agu[$][1], s_agu[$][1], n_agu[$][1]};
      //$display("req_s = %b%b%b%b%b\n", req_s[4], req_s[3], req_s[2], req_s[1], req_s[0]);
      if (count_s == 0) begin
	 if (req_s == 5'b00000) begin
	    en_q_s.push_back(1'b0);
	 end
	 else begin
	    count_s++;
	    en_q_s.push_back(1'b1);
	 end
      end
      else begin
	 en_q_s.push_back(1'b0);
	 if (valid_s_o) begin
	    count_s++;
	    if (count_s == 6) begin
	       count_s = 0;
	       s_en_reset();
	       s_agu_reset();
	       south_reset();
	    end
	 end
      end

      req_e = {l_agu[$][2], w_agu[$][2], e_agu[$][2], s_agu[$][2], n_agu[$][2]};
      if (count_e == 0) begin
	 if (req_e == 5'b00000) begin
	    en_q_e.push_back(1'b0);
	 end
	 else begin
	    count_e++;
	    en_q_e.push_back(1'b1);
	 end
      end
      else begin
	 en_q_e.push_back(1'b0);
	 if (valid_e_o) begin
	    count_e++;
	    if (count_e == 6) begin
	       count_e = 0;
	       e_en_reset();
	       e_agu_reset();
	       east_reset();
	    end
	 end
      end

      req_w = {l_agu[$][3], w_agu[$][3], e_agu[$][3], s_agu[$][3], n_agu[$][3]};
      if (count_w == 0) begin
	 if (req_w == 5'b00000) begin
	    en_q_w.push_back(1'b0);
	 end
	 else begin
	    count_w++;
	    en_q_w.push_back(1'b1);
	 end
      end
      else begin
	 en_q_w.push_back(1'b0);
	 if (valid_w_o) begin
	    count_w++;
	    if (count_w == 6) begin
	       count_w = 0;
	       w_en_reset();
	       w_agu_reset();
	       west_reset();
	    end
	 end
      end

      req_l = {l_agu[$][4], w_agu[$][4], e_agu[$][4], s_agu[$][4], n_agu[$][4]};
      if (count_l == 0) begin
	 if (req_l == 5'b00000) begin
	    en_q_l.push_back(1'b0);
	 end
	 else begin
	    count_l++;
	    en_q_l.push_back(1'b1);
	 end
      end
      else begin
	 en_q_l.push_back(1'b0);
	 if (valid_l_o) begin
	    count_l++;
	    if (count_l == 6) begin
	       count_l = 0;
	       l_en_reset();
	       l_agu_reset();
	       local_reset();
	    end
	 end
      end
   endfunction

   function void arbiter_north();
      bit [4:0] request_vec = {l_agu[0][0], w_agu[0][0], e_agu[0][0], s_agu[0][0], n_agu[0][0]};

      /* mask the bits */
      request_vec = request_vec ^ mask;

      n_north = 0;
      /* count the number of conflicts in the north output request */
      if (request_vec[0] == 1'b1) begin
	 n_north++;
      end
      if (request_vec[1] == 1'b1) begin
	 n_north++;
      end
      if (request_vec[2] == 1'b1) begin
	 n_north++;
      end
      if (request_vec[3] == 1'b1) begin
	 n_north++;
      end
      if (request_vec[4] == 1'b1) begin
	 n_north++;
      end


      if (n_north == 0) begin
	 /* 
	  * if a certain output wasn't requested this cycle, set the
	  * input granted index to all ones
	  * (111 indicates that no one wants to use this output this cycle)
	  */
	 n_addr.push_back(3'b111);
      end
      else begin
	 bit [2:0] start = '0;
	 bit 	   success = '0;
	 if (n_north > 1) begin
	    if ((last_dir[0] == 3'b111) || (last_dir[0] == 3'b100)) begin
	       start = '0;
	    end
	    else begin
	       start = last_dir[0] + 1'b1;
	    end
	 end		
	 while (success == 0) begin
	    if (request_vec[start] == 1) begin
	       success = 1;
	       last_dir[0] = start;
	       n_addr.push_back(start);
	    end

	    /* cover the rollover properly */
	    if (start == 3'b100) begin
	       start = '0;
	    end
	    else begin
	       start = start + 1'b1;
	    end
	 end
      end
   endfunction

   function void arbiter_south();
      bit [4:0] request_vec = {l_agu[0][1], w_agu[0][1], e_agu[0][1], s_agu[0][1], n_agu[0][1]};
      //$display("request_vec = %b%b%b%b%b\n", request_vec[4], request_vec[3], request_vec[2], request_vec[1], request_vec[0]);
      //$display("mask = %b%b%b%b%b\n", mask[4], mask[3], mask[2], mask[1], mask[0]);

      /* mask the bits */
      request_vec = request_vec ^ mask;

      n_south = 0;
      /* count the number of conflicts in the north output request */
      if (request_vec[0] == 1'b1) begin
	 n_south++;
      end
      if (request_vec[1] == 1'b1) begin
	 n_south++;
      end
      if (request_vec[2] == 1'b1) begin
	 n_south++;
      end
      if (request_vec[3] == 1'b1) begin
	 n_south++;
      end
      if (request_vec[4] == 1'b1) begin
	 n_south++;
      end

      if (n_south == 0) begin
	 /* 
	  * if a certain output wasn't requested this cycle, set the
	  * input granted index to all ones
	  * (111 indicates that no one wants to use this output this cycle)
	  */
	 s_addr.push_back(3'b111);
      end
      else begin
	 bit [2:0] start = '0;
	 bit 	   success = '0;
	 if (n_south > 1) begin
	    if ((last_dir[1] == 3'b111) || (last_dir[1] == 3'b100)) begin
	       start = '0;
	    end
	    else begin
	       start = last_dir[1] + 1'b1;
	    end
	 end		
	 while (success == 0) begin
	    if (request_vec[start] == 1) begin
	       success = 1;
	       last_dir[1] = start;
	       s_addr.push_back(start);
	       $display("Client %b granted south output!\n", start);
	    end

	    /* cover the rollover properly */
	    if (start == 3'b100) begin
	       start = '0;
	    end
	    else begin
	       start = start + 1'b1;
	    end
	 end
      end
   endfunction

   function void arbiter_east();
      bit [4:0] request_vec = {l_agu[0][2], w_agu[0][2], e_agu[0][2], s_agu[0][2], n_agu[0][2]};

      /* mask the bits */
      request_vec = request_vec ^ mask;

      n_east = 0;
      /* count the number of conflicts in the north output request */
      if (request_vec[0] == 1'b1) begin
	 n_east++;
      end
      if (request_vec[1] == 1'b1) begin
	 n_east++;
      end
      if (request_vec[2] == 1'b1) begin
	 n_east++;
      end
      if (request_vec[3] == 1'b1) begin
	 n_east++;
      end
      if (request_vec[4] == 1'b1) begin
	 n_east++;
      end

      if (n_east == 0) begin
	 /* 
	  * if a certain output wasn't requested this cycle, set the
	  * input granted index to all ones
	  * (111 indicates that no one wants to use this output this cycle)
	  */
	 e_addr.push_back(3'b111);
      end
      else begin
	 bit [2:0] start = '0;
	 bit 	   success = '0;
	 if (n_east > 1) begin
	    if ((last_dir[2] == 3'b111) || (last_dir[2] == 3'b100)) begin
	       start = '0;
	    end
	    else begin
	       start = last_dir[2] + 1'b1;
	    end
	 end		
	 while (success == 0) begin
	    if (request_vec[start] == 1) begin
	       success = 1;
	       last_dir[2] = start;
	       e_addr.push_back(start);
	    end

	    /* cover the rollover properly */
	    if (start == 3'b100) begin
	       start = '0;
	    end
	    else begin
	       start = start + 1'b1;
	    end
	 end
      end
   endfunction

   function void arbiter_west();
      bit [4:0] request_vec = {l_agu[0][3], w_agu[0][3], e_agu[0][3], s_agu[0][3], n_agu[0][3]};

      /* mask the bits */
      request_vec = request_vec ^ mask;

      n_west = 0;
      /* count the number of conflicts in the north output request */
      if (request_vec[0] == 1'b1) begin
	 n_west++;
      end
      if (request_vec[1] == 1'b1) begin
	 n_west++;
      end
      if (request_vec[2] == 1'b1) begin
	 n_west++;
      end
      if (request_vec[3] == 1'b1) begin
	 n_west++;
      end
      if (request_vec[4] == 1'b1) begin
	 n_west++;
      end


      if (n_west == 0) begin
	 /* 
	  * if a certain output wasn't requested this cycle, set the
	  * input granted indenorth_w_o' has not beenx to all ones
	  * (111 indicates that no one wants to use this output this cycle)
	  */
	 w_addr.push_back(3'b111);
      end
      else begin
	 bit [2:0] start = '0;
	 bit 	   success = '0;
	 if (n_west > 1) begin
	    if ((last_dir[3] == 3'b111) || (last_dir[3] == 3'b100)) begin
	       start = '0;
	    end
	    else begin
	       start = last_dir[3] + 1'b1;
	    end
	 end		
	 while (success == 0) begin
	    if (request_vec[start] == 1) begin
	       success = 1;
	       last_dir[3] = start;
	       w_addr.push_back(start);
	    end

	    /* cover the rollover properly */
	    if (start == 3'b100) begin
	       start = '0;
	    end
	    else begin
	       start = start + 1'b1;
	    end
	 end
      end
   endfunction

   function void arbiter_local();
      bit [4:0] request_vec = {l_agu[0][4], w_agu[0][4], e_agu[0][4], s_agu[0][4], n_agu[0][4]};

      /* mask the bits */
      request_vec = request_vec ^ mask;

      n_local = 0;
      /* count the number of conflicts in the north output request */
      if (request_vec[0] == 1'b1) begin
	 n_local++;
      end
      if (request_vec[1] == 1'b1) begin
	 n_local++;
      end
      if (request_vec[2] == 1'b1) begin
	 n_local++;
      end
      if (request_vec[3] == 1'b1) begin
	 n_local++;
      end
      if (request_vec[4] == 1'b1) begin
	 n_local++;
      end

      if (n_local == 0) begin
	 /* 
	  * if a certain output wasn't requested this cycle, set the
	  * input granted index to all ones
	  * (111 indicates that no one wants to use this output this cycle)
	  */
	 l_addr.push_back(3'b111);
      end
      else begin
	 bit [2:0] start = '0;
	 bit 	   success = '0;
	 if (n_local > 1) begin
	    if ((last_dir[4] == 3'b111) || (last_dir[4] == 3'b100)) begin
	       start = '0;
	    end
	    else begin
	       start = last_dir[4] + 1'b1;
	    end
	 end		
	 while (success == 0) begin
	    if (request_vec[start] == 1) begin
	       success = 1;
	       last_dir[4] = start;
	       l_addr.push_back(start);
	    end

	    /* cover the rollover properly */
	    if (start == 3'b100) begin
	       start = '0;
	    end
	    else begin
	       start = start + 1'b1;
	    end
	 end
      end
   endfunction

   function void n_en_reset();
	en_q_n = {};
	en_q_n.push_back(1'b0);
	en_q_n.push_back(1'b0);
   endfunction;

   function void s_en_reset();
	en_q_s = {};
	en_q_s.push_back(1'b0);
	en_q_s.push_back(1'b0);
   endfunction;

   function void e_en_reset();
	en_q_e = {};
	en_q_e.push_back(1'b0);
	en_q_e.push_back(1'b0);
   endfunction;

   function void w_en_reset();
	en_q_w = {};
	en_q_w.push_back(1'b0);
	en_q_w.push_back(1'b0);
   endfunction;

   function void l_en_reset();
	en_q_l = {};
	en_q_l.push_back(1'b0);
	en_q_l.push_back(1'b0);
   endfunction;

   function void n_agu_reset();
      n_agu = {};
      n_agu.push_back(3'b000);
      n_agu.push_back(3'b000);
   endfunction

   function void s_agu_reset();
      s_agu = {};
      s_agu.push_back(3'b000);
      s_agu.push_back(3'b000);
   endfunction

   function void e_agu_reset();
      e_agu = {};
      e_agu.push_back(3'b000);
      e_agu.push_back(3'b000);
   endfunction

   function void w_agu_reset();
      w_agu = {};
      w_agu.push_back(3'b000);
      w_agu.push_back(3'b000);
   endfunction

   function void l_agu_reset();
      l_agu = {};
      l_agu.push_back(3'b000);
      l_agu.push_back(3'b000);
   endfunction

   function void north_reset();
      n_addr = {};
      n_addr.push_back(3'b111);
      n_addr.push_back(3'b111);
   endfunction

   function void south_reset();
      s_addr = {};
      s_addr.push_back(3'b111);
      s_addr.push_back(3'b111);
   endfunction

   function void east_reset();
      e_addr = {};
      e_addr.push_back(3'b111);
      e_addr.push_back(3'b111);
   endfunction

   function void west_reset();
      w_addr = {};
      w_addr.push_back(3'b111);
      w_addr.push_back(3'b111);
   endfunction

   function void local_reset();
      l_addr = {};
      l_addr.push_back(3'b111);
      l_addr.push_back(3'b111);
   endfunction

   function void pop_queues();
      en_q_n.pop_front();
      en_q_s.pop_front();
      en_q_e.pop_front();
      en_q_w.pop_front();
      en_q_l.pop_front();

      n_agu.pop_front();
      s_agu.pop_front();
      e_agu.pop_front();
      w_agu.pop_front();
      l_agu.pop_front();

      n_addr.pop_front();
      s_addr.pop_front();
      e_addr.pop_front();
      w_addr.pop_front();
      l_addr.pop_front();
   endfunction

   function void fcc();
      bit incr_i[5] = {n_incr_i, s_incr_i, e_incr_i, w_incr_i, l_incr_i};

      for (int ind = 0; ind < 5; ind++) begin
	 /* control the increase input */
	 if (incr_i[ind] && (count[ind] < 5)) begin
	    count[ind]++;
	 end

	 /* control the decrease input */
	 if (valid_data[ind] && (count[ind] > 0)) begin
	    count[ind]--;
	 end

	 /* control the enable signal */
	 if (count[ind] == 0) begin
	    count_en[ind] = 0;	
	 end
	 else begin
	    count_en[ind] = 1;
	 end
      end
   endfunction

   function void fcu();
      grant_arb[0] = n_addr[0];
      grant_arb[1] = s_addr[0];
      grant_arb[2] = e_addr[0];
      grant_arb[3] = w_addr[0];
      grant_arb[4] = l_addr[0];

      grant = '{'0, '0, '0, '0, '0};
      n_incr_o = '0;
      s_incr_o = '0;
      e_incr_o = '0;
      w_incr_o = '0;
      l_incr_o = '0;

      for (int ind = 0; ind < 5; ind++) begin
	 if ((grant_arb[ind] != 3'b111) && count_en[ind]) begin
	    valid_data[ind] = '1;
	    if (grant_arb[ind] == 3'b000) begin
	       grant[0] = '1;
	       n_incr_o = '1;
	    end
	    else if (grant_arb[ind] == 3'b001) begin
	       grant[1] = '1;
	       s_incr_o = '1;
	    end
	    else if (grant_arb[ind] == 3'b010) begin
	       grant[2] = '1;
	       e_incr_o = '1;
	    end
	    else if (grant_arb[ind] == 3'b011) begin
	       grant[3] = '1;
	       w_incr_o = '1;
	    end
	    else if (grant_arb[ind] == 3'b100) begin
	       grant[4] = '1;
	       l_incr_o = '1;
	    end
	 end
      end

      valid_n_o = valid_data[0];
      valid_s_o = valid_data[1];
      valid_e_o = valid_data[2];
      valid_w_o = valid_data[3];
      valid_l_o = valid_data[4];
      //$display("valid_data = %b%b%b%b%b\n", valid_data[4], valid_data[3], valid_data[2], valid_data[1], valid_data[0]);
   endfunction

   function void xbar();
      for (int ind = 0; ind < 5; ind++) begin
	 if (grant_arb[ind] == 3'b000) begin
	    out_data[ind] = north_q_o;
	 end
	 else if (grant_arb[ind] == 3'b001) begin
	    out_data[ind] = south_q_o;
	 end
	 else if (grant_arb[ind] == 3'b010) begin
	    out_data[ind] = east_q_o;
	 end
	 else if (grant_arb[ind] == 3'b011) begin
	    out_data[ind] = west_q_o;
	 end
	 else if (grant_arb[ind] == 3'b100) begin
	    out_data[ind] = local_q_o;
	 end
	 else begin
	    out_data[ind] = '0;
	 end
      end

      north_o = out_data[0];
      south_o = out_data[1];
      east_o  = out_data[2];
      west_o  = out_data[3];
      local_o = out_data[4];
   endfunction

   function golden_model();
      if (rst) begin
	 reset_router();
      end
      else begin
	 pop_queues();
	 fsm();
	 input_buffer();
	 address_gen();
	 make_enables();

	 if (en_n) begin
	    arbiter_north();
	 end
	 else begin
	    n_addr.push_back(n_addr[0]);
	 end
	 if (en_q_s[0]) begin
	    arbiter_south();
	 end
	 else begin
	    s_addr.push_back(s_addr[0]);
	 end
	 if (en_e) begin
	    arbiter_east();
	 end
	 else begin
	    e_addr.push_back(e_addr[0]);
	 end
	 if (en_w) begin
	    arbiter_west();
	 end
	 else begin
	    w_addr.push_back(w_addr[0]);
	 end
	 if (en_l) begin
	    arbiter_local();
	 end
	 else begin
	    l_addr.push_back(l_addr[0]);
	 end
	
	 //$display("AGU Ouput Enables = %b%b%b%b%b\n", en_q_l[$], en_q_w[$], en_q_e[$], en_q_s[$], en_q_n[$]);
	 //$display("Arbiter Input Enables = %b%b%b%b%b\n", en_q_l[0], en_q_w[0], en_q_e[0], en_q_s[0], en_q_n[0]);
	 
	 fcc();
	 fcu();
	 xbar();

	 //$display("End of Cycle\n");
	 //$display("n_agu[%d] = %b\n", 0, n_agu[0]);
	 //$display("n_agu[%d] = %b\n", 1, n_agu[$]);
	 //$display("s_addr[%d] = %b\n", 0, s_addr[0]);
	 //$display("s_addr[%d] = %b\n", 1, s_addr[$]);
      end
   endfunction
endclass
