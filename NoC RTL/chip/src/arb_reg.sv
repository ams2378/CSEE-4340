/**
* @filename  		arb_reg.sv 
*
* @brief     		Generates the direction to which data flits need to be sent, comparing current router address to destination address.

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
//	if (rst)
//		data <= '0;
//	else if (en_i)
		data <= write_i;
//	else
//		data <=data;		// keep writing the data back
end

/*
 * the read block
 */

assign read_o = data;

endmodule
