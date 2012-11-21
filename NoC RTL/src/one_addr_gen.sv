/**
* @filename  		one_addr_gen.sv 
*
* @brief     		Generates the direction to which data flits need to be sent, comparing current router address to destination address for one of the queues

* @author   		Dechhin Lama	<ddl2126@columbia.edu>
*	     		
*  	 
*/

module one_addr_gen(
		input [15:0] q_i;
		input [7:0] myaddr_i;
		output [2:0] req_port_addr_o;
	);

	logic gt_y;
	logic lt_y;
	logic eq_y;
	
	logic gt_x;
	logic lt_x;
	logic eq_x;

	logic [7:0] q_addr_i;
	logic [7:0] q_header_i;
	
	assign q_addr_i = q_i[7:0];

	

	
	//comparator	
	DW_cmp_dx #(.width(8), .p1_width(4)) comparator (
		.A (q_addr_i),
		.B (myaddr_i),
		.tc ('0'),
		.dplx ('1'),
		.lt1 (lt_y),
		.gt1 (gt_y),
		.eq1 (eq_y),
		.lt2 (lt_x),
		.gt2 (gt_x),
		.eq2 (eq_x)
	);

	always_comb begin
	
		// QUEUE ADDRESS GENERATION
		// if destination y_address is less than my y address
		if (lt_y)
			//pass to south
			req_port_addr_o = 3'b010;
		
		// if destination y_address is greater than my y address
		else if (gt_y)
			//pass to north			
			req_port_addr_o = 3'b000;
		
		// if matching y-address, check x address
		else if (eq_y) begin
			
			// if destination x_address is less than my x address	
			if (lt_x)
			//pass to east
			req_port_addr_o = 3'b011;

			// if destination x_address is greater than my x address
			else if (gt_x)
			//pass to west			
			req_port_addr_o = 3'b001;

			// matching address- destination reached!!
			else if (eq_x)
			//pass to local
			req_port_addr_o = 3'b100;
		end
	end

endmodule
