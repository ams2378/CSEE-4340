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

   bit [4:0] last_north = '0;
   bit [4:0] last_south = '0;
   bit [4:0] last_east = '0;
   bit [4:0] last_west = '0;
   bit [4:0] last_local = '0;

   /*
    * inputs: 5 5-bit signals indicating desired output
    * outputs: 5 3-bit signals indicating the input granted a specific direction
    * operates in round-robin fashion
    */
   function void arbiter(bit enable);
	int n_north = 0;
	int n_south = 0;
	int n_east = 0;
	int n_west = 0;
	int n_local = 0;	
	
	if (enable == 1) begin
		return;
	end

	/* count the number of conflicts in the output request */
	for (int ind = 0; ind < 5; ind++) begin
		if (req_port_addr_o[ind] == 5'b00001) begin
			n_north++;
		end
		else if (req_port_addr_o[ind] == 5'b00010) begin
			n_south++;
		end
		else if (req_port_addr_o[ind] == 5'b00100) begin
			n_east++;
		end
		else if (req_port_addr_o[ind] == 5'b01000) begin
			n_west++;
		end
		else if (req_port_addr_o[ind] == 5'b10000) begin
			n_local++;
		end
	end

	/* do arbitration for each output */
	bit [4:0] start = '0;
	if (n_north > 1) begin
		start = last_north + 1'b1;
	end
	int found = 0;
	while ((found == 0) && (n_north >= 1)) begin
		if (req_port_addr_o[start] == 5'b00001) begin
			found = 1;
			last_north = start;
		end
		start = start + 1'b1;
	end

	start = '0;
	if (n_south > 1) begin
		start = last_south + 1'b1;
	end
	found = 0;
	while ((found == 0) && (n_south >= 1)) begin
		if (req_port_addr_o[start] == 5'b00010) begin
			found = 1;
			last_south = start;
		end
		start = start + 1'b1;
	end

	start = '0;
	if (n_east > 1) begin
		start = last_east + 1'b1;
	end
	found = 0;
	while ((found == 0) && (n_east >= 1)) begin
		if (req_port_addr_o[start] == 5'b00100) begin
			found = 1;
			last_east = start;
		end
		start = start + 1'b1;
	end

	start = '0;
	if (n_west > 1) begin
		start = last_west + 1'b1;
	end
	found = 0;
	while ((found == 0) && (n_west >= 1)) begin
		if (req_port_addr_o[start] == 5'b01000) begin
			found = 1;
			last_west = start;
		end
		start = start + 1'b1;
	end

	start = '0;
	if (n_local > 1) begin
		start = last_local + 1'b1;
	end
	found = 0;
	while ((found == 0) && (n_local >= 1)) begin
		if (req_port_addr_o[start] == 5'b10000) begin
			found = 1;
			last_local = start;
		end
		start = start + 1'b1;
	end

	/* 
	 * if a certain output wasn't requested this cycle, set the
	 * input granted index to all ones
	 */
	if (n_north == 0) begin
		last_north = '1;
	end
	if (n_south == 0) begin
		last_south = '1;
	end
	if (n_east == 0) begin
		last_east = '1;
	end
	if (n_west == 0) begin
		last_west = '1;
	end
	if (n_local == 0) begin
		last_local = '1;
	end
   endfunction

   function void golden_result();
   endfunction

endclass
