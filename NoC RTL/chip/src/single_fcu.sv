/**
* @filename  		single_fcu.sv 
*   		
* @author   		Dechhin Lama	<ddl2126@columbia.edu>
			Adil Sadik  	<ams2378@columbia.edu>
*	     		
*  	 
*/

module single_fcu(

	input clk,
	input rst,

	input granted,
	input [2:0] req_port_addr_i,
	input credit_en_i,

	output grant_access_o


);


//FSM
parameter s1 = 3'b000;
parameter s2 = 3'b001;
parameter s3 = 3'b010;
parameter s4 = 3'b011;
parameter s5 = 3'b100;
parameter s6 = 3'b101;

//reg[2:0] pstate;
reg[2:0] state;
reg grant_acc;


always_ff @(posedge clk) begin
	if (rst) begin
		state <= s1;
		grant_acc <= 0;
	end else case(state) 	
		s1:	begin if ((req_port_addr_i == 3'b111 && credit_en_i == 1) || credit_en_i == 0) begin
				state <= s1;
				grant_acc <= 0;
			end else if (req_port_addr_i != 3'b000 && credit_en_i == 1 && granted == 1) begin 
				state <= s2;
				grant_acc <= 1;
			end end
		
		s2:	begin if (credit_en_i == 0) begin
				state <= s2;
				grant_acc <= 0;
			end else if (credit_en_i == 1) begin 
				state <= s3;
				grant_acc <= 1;
			end end

		s3:	begin if (credit_en_i == 0) begin
				state <= s3;
				grant_acc <= 0;
			end else if (credit_en_i == 1) begin 
				state <= s4;
				grant_acc <= 1;
			end end


		s4:	begin if (credit_en_i == 0) begin
				state <= s4;
				grant_acc <= 0;
			end else if (credit_en_i == 1) begin 
				state <= s5;
				grant_acc <= 1;
			end end


		s5:	begin if (credit_en_i == 0) begin
				state <= s5;
				grant_acc <= 0;
			end else if (credit_en_i == 1) begin 
				state <= s6;
				grant_acc <= 1;
			end end

		s6:	begin if (credit_en_i == 0) begin
				state <= s6;
				grant_acc <= 0;
			end else if (credit_en_i == 1) begin 
				state <= s1;
				grant_acc <= 0;
			end end
	endcase
end

assign grant_access_o = grant_acc;

endmodule

