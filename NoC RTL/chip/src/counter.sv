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
	parameter s1 = 2'b00;
	parameter s2 = 2'b01;
	parameter s3 = 2'b10;
	parameter s4 = 2'b11;

	reg[2:0] C;
	reg[1:0] state;
	


	always_ff @(posedge clk) begin
		if (rst)
			state <= s1;
		else case(state)
			s1:	if (decr_i ==1) begin
					//credit_en_o <= 1;
					state <= s2;
			    	end
	
			s2: 	if (incr_i==1 && C==4) begin
					//credit_en_o <= 1;
					state <= s1;
		    	    	end else if (decr_i == 1 && C>1) begin
					//credit_en_o <= 1;
					state <= s2;
				end else if (decr_i == 1 && C == 1) begin
					//credit_en_o <= 0;
					state <= s3;
				end else if(incr_i ==1 && C<4) begin
					//credit_en_o <= 1;
					state <= s4;
				end
				
			s3:	if (incr_i==1) begin 
					//credit_en_o <= 1;
					state <= s2;
				end


			s4: 	if (incr_i == 1 && C==4) begin
					//credit_en_o <= 1;
					state <= s1;
				end //else if (incr_i == 1 && C<4) begin
					//credit_en_o = 1;
														
		endcase
	
	end


	always_comb begin
		case (state)
			s1: C = 5;
			s2: C = C-1;
			s3: C = 0;
			s4: C = C+1;
		endcase
	end

	assign credit_en_o = (C == 0) ? 0:1;

endmodule
