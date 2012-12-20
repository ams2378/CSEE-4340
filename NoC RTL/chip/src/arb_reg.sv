/**
* @filename  		arb_reg.sv 

* @author   		Dechhin Lama	<ddl2126@columbia.edu>
			Adil Sadik  	<ams2378@columbia.edu>
*	     		
*  	 
*/

module arb_reg (
	//input clk,
	input rst,

	input en_i,
	input [2:0] write_i,
	
	output [2:0] read_o
);

reg [2:0] data;


/*
 * the write block
 */
always_ff @(posedge en_i) begin
		data <= write_i;

end

assign read_o = data;

endmodule
