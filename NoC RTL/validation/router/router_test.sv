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
    * inputs: 5 5-bit signals indicating desired output
    * outputs: 5 3-bit signals indicating the input granted a specific direction
    * operates in round-robin fashion
    */
   function void arbiter(bit [4:0] enable, bit [4:0] mask);
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
		if (enable[ind]) begin
			if (n_dir[ind] > 1) begin
				start = last_dir[i] + 1'b1;			
			end
			bit found = 0;
			while ((found == 0) && (n_dir[ind] >= 1)) begin
				if (req_port_addr_o[start] == one_hot_addr[ind]) begin
					found = 1;
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
				grant_arb[ind] = 3'000;
			end	
			else if (last_dir[ind] == 5'b00010) begin
				grant_arb[ind] = 3'001;
			end
			else if (last_dir[ind] == 5'b00100) begin
				grant_arb[ind] = 3'010;
			end
			else if (last_dir[ind] == 5'b01000) begin
				grant_arb[ind] = 3'011;
			end
			else if (last_dir[ind] == 5'b10000) begin
				grant_arb[ind] = 3'100;
			end
			else begin
				grant_arb[ind] = '1;
			end
		end	
	end
   endfunction

   function void fcu(bit count_en[5]);	
	for (int ind = 0; ind < 5; ind++) begin
		if ((grant_arb[ind] != '1) && count_en[ind]) begin
			grant[ind] = 1;
		end
	end
   endfunction

   function void golden_result();
   endfunction

endclass
