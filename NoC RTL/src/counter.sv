/**
* @filename  		counter.sv 
*
* @brief     		Counter for credits avaible for neighboring router buffers
* @author   		Dechhin Lama	<ddl2126@columbia.edu>
*	     		
*  	 
*/

module counter(
	input clk,
	input rst,

	input  incr_i,
	input  decr_i, 

	output credit_en_o	
);

	reg[2:0] count;

	always_ff @(posedge clk) begin
		if (rst)
			count <= 5;
		else begin
			if (incr_i && decr_i)
				count <= count;
			else if (incr_i)
				count <= count+1;
			else if (decr_i)
				count <= count-1;
			else 
				count <= count;
		end
	
	end

	assign credit_en_o = (count == 0) ? 0:1;

endmodule
