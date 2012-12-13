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
   integer my_qn[$:5];
   integer my_qs[$:5];
   integer my_qe[$:5];  
   integer my_qw[$:5];
   integer my_ql[$:5];   

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

   function void reset_router();
	req_port_addr_o [5] = '{0, 0, 0, 0, 0};
	dir_i [5] = '{0, 0, 0, 0, 0};

	my_qn = {};
	my_qs = {};
	my_qe = {};
	my_qw = {};
	my_ql = {};

	enable = '1;
	mask = '0;

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
      			north_q_o = my_qn.popfront();
      			en_n = 0;
      			count_n++;
    		end
   	end
	else begin
		en_n = 0;
    		if (grant[0] == 1) begin
      			north_q_o = my_qn.popfront();
      			count_n++;
      			if (count_n == 5) begin
         			en_n = 1;
				count_n = 0;
      			end
    		end
	end

	/*handling south queue*/	                  
	if (count_s == 0)begin
    		if (grant[1] == 0) begin
      			count_s = 0;
      			en_s = 1;
    		end
    		else begin
      			south_q_o = my_qs.popfront();
      			en_s = 0;
      			count_s++;
    		end
	end
	else begin
      		en_s = 0;
    		if (grant[1] == 1) begin
      			south_q_o = my_qs.popfront();
     			count_s++;
      			if (count == 5) begin
         			en_s = 1;
				count_s = 0;
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
      			east_q_o = my_qe.popfront();
      			en_e = 0;
      			count_e++;
    		end
	end
	else begin
     		en_e = 0;
    		if (grant[2] == 1) begin
      			east_q_o = my_qe.popfront();
      			count_e++;
      			if (count_e == 5) begin
         			en_e = 1;
				count_e = 0;
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
      			west_q_o = my_qw.popfront();
      			en_w = 0;
      			count_w++;
    		end
	end
	else begin
      		en_w = 0;
    		if (grant[3] == 1) begin
      			west_q_o = my_qw.popfront();
      			count_w++;
      			if (count_w == 5) begin
         			en_w = 1;
				count_w = 0;
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
      			local_q_o = my_ql.popfront();
      			en_l = 0;
      			count_l++;
   		end
	end
	else begin
      		en_l = 0;
    		if (grant[4] == 1) begin
      			local_q_o = my_ql.popfront();
      			count_l++;
      			if (count_l == 5) begin
         			en_l = 1;
				count_l = 0;
      			end
    		end
	end
   endfunction

   function void adress_gen ();
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

   /*
    * inputs: 5 5-bit signals indicating desired output
    * outputs: 5 3-bit signals indicating the input granted a specific direction
    * operates in round-robin fashion
    */
   function void arbiter();
	int n_dir[5] = '{0, 0, 0, 0, 0};

	/*
	 * mask the bits
	 */
	foreach (req_port_addr_o[i]) begin
		req_port_addr_o[i] = req_port_addr_o[i] ^ mask[i];
	end

	/* count the number of conflicts in the output request */
	for (int ind = 0; ind < 5; ind++) begin
		if (enable[ind] && (req_port_addr_o[ind] == 5'b00001)) begin
			n_dir[0]++;
		end
		else if (enable[ind] && (req_port_addr_o[ind] == 5'b00010)) begin
			n_dir[1]++;
		end
		else if (enable[ind] && (req_port_addr_o[ind] == 5'b00100)) begin
			n_dir[2]++;
		end
		else if (enable[ind] && (req_port_addr_o[ind] == 5'b01000)) begin
			n_dir[3]++;
		end
		else if (enable[ind] && (req_port_addr_o[ind] == 5'b10000)) begin
			n_dir[4]++;
		end
	end

	for (int ind = 0; ind < 5; ind++) begin
		bit [4:0] start = '0;
		bit success = '0;
		if (enable[ind]) begin
			if (n_dir[ind] > 1) begin
				start = last_dir[i] + 1'b1;			
			end
			success = 0;			
			while ((success == 0) && (n_dir[ind] >= 1)) begin
				if (req_port_addr_o[start] == one_hot_addr[ind]) begin
					success = 1;
					last_dir[ind] = start;
				end
				start = start + 1'b1;	
			end
		end	
	end

	/* 
	 * if a certain output wasn't requested this cycle, set the
	 * input granted index to all zeros
	 * (00000 indicates that no one wants to use this output this cycle)
	 */
	for (int ind = 0; ind < 5; ind++) begin
		if (enable[ind] && (n_dir[ind] == 0)) begin
			last_dir[ind] = '0;
		end
	end

	/*
	 * encode the one-hot values into 3-bit values
	 */
	for (int ind = 0; ind < 5; ind++) begin
		if (enable[ind]) begin
			if (last_dir[ind] == 5'b00001) begin
				grant_arb[ind] = 3'b000;
			end	
			else if (last_dir[ind] == 5'b00010) begin
				grant_arb[ind] = 3'b001;
			end
			else if (last_dir[ind] == 5'b00100) begin
				grant_arb[ind] = 3'b010;
			end
			else if (last_dir[ind] == 5'b01000) begin
				grant_arb[ind] = 3'b011;
			end
			else if (last_dir[ind] == 5'b10000) begin
				grant_arb[ind] = 3'b100;
			end
			else begin
				grant_arb[ind] = '1;
			end
		end	
	end
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
