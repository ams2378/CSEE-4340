/**
* @filename  		arb_reg.sv 
*
* @brief     		Generates the direction to which data flits need to be sent, comparing current router address to destination address.

* @author   		Dechhin Lama	<ddl2126@columbia.edu>
			Adil Sadik  	<ams2378@columbia.edu>
*	     		
*  	 
*/

interface ifc_noc (input bit clk);
	logic rst;
	
	logic [15:0] local_1_1_i;
	logic valid_1_1_i;
	logic incr_1_1_i;
	logic [15:0] local_1_1_o;
	logic valid_1_1_o;
	logic incr_1_1_o;

	logic [15:0] local_1_2_i;
	logic valid_1_2_i;
	logic incr_1_2_i;
	logic [15:0] local_1_2_o;
	logic valid_1_2_o;
	logic incr_1_2_o;

	logic [15:0] local_1_3_i;
	logic valid_1_3_i;
	logic incr_1_3_i;
	logic [15:0] local_1_3_o;
	logic valid_1_3_o;
	logic incr_1_3_o;

	logic [15:0] local_1_4_i;
	logic valid_1_4_i;
	logic incr_1_4_i;
	logic [15:0] local_1_4_o;
	logic valid_1_4_o;
	logic incr_1_4_o;

	logic [15:0] local_2_1_i;
	logic valid_2_1_i;
	logic incr_2_1_i;
	logic [15:0] local_2_1_o;
	logic valid_2_1_o;
	logic incr_2_1_o;

	logic [15:0] local_2_2_i;
	logic valid_2_2_i;
	logic incr_2_2_i;
	logic [15:0] local_2_2_o;
	logic valid_2_2_o;
	logic incr_2_2_o;

	logic [15:0] local_2_3_i;
	logic valid_2_3_i;
	logic incr_2_3_i;
	logic [15:0] local_2_3_o;
	logic valid_2_3_o;
	logic incr_2_3_o;

	logic [15:0] local_2_4_i;
	logic valid_2_4_i;
	logic incr_2_4_i;
	logic [15:0] local_2_4_o;
	logic valid_2_4_o;
	logic incr_2_4_o;

	logic [15:0] local_3_1_i;
	logic valid_3_1_i;
	logic incr_3_1_i;
	logic [15:0] local_3_1_o;
	logic valid_3_1_o;
	logic incr_3_1_o;

	logic [15:0] local_3_2_i;
	logic valid_3_2_i;
	logic incr_3_2_i;
	logic [15:0] local_3_2_o;
	logic valid_3_2_o;
	logic incr_3_2_o;

	logic [15:0] local_3_3_i;
	logic valid_3_3_i;
	logic incr_3_3_i;
	logic [15:0] local_3_3_o;
	logic valid_3_3_o;
	logic incr_3_3_o;

	logic [15:0] local_3_4_i;
	logic valid_3_4_i;
	logic incr_3_4_i;
	logic [15:0] local_3_4_o;
	logic valid_3_4_o;
	logic incr_3_4_o;

	logic [15:0] local_4_1_i;
	logic valid_4_1_i;
	logic incr_4_1_i;
	logic [15:0] local_4_1_o;
	logic valid_4_1_o;
	logic incr_4_1_o;

	logic [15:0] local_4_2_i;
	logic valid_4_2_i;
	logic incr_4_2_i;
	logic [15:0] local_4_2_o;
	logic valid_4_2_o;
	logic incr_4_2_o;

	logic [15:0] local_4_3_i;
	logic valid_4_3_i;
	logic incr_4_3_i;
	logic [15:0] local_4_3_o;
	logic valid_4_3_o;
	logic incr_4_3_o;

	logic [15:0] local_4_4_i;
	logic valid_4_4_i;
	logic incr_4_4_i;
	logic [15:0] local_4_4_o;
	logic valid_4_4_o;
	logic incr_4_4_o;

	clocking cb @(posedge clk);
      		default output #1;
		output rst;
	
		output  local_1_1_i;
		output valid_1_1_i;
		output incr_1_1_i;
		input  local_1_1_o;
		input valid_1_1_o;
		input incr_1_1_o;

		output  local_1_2_i;
		output valid_1_2_i;
		output incr_1_2_i;
		input  local_1_2_o;
		input valid_1_2_o;
		input incr_1_2_o;

		output  local_1_3_i;
		output valid_1_3_i;
		output incr_1_3_i;
		input  local_1_3_o;
		input valid_1_3_o;
		input incr_1_3_o;

		output  local_1_4_i;
		output valid_1_4_i;
		output incr_1_4_i;
		input  local_1_4_o;
		input valid_1_4_o;
		input incr_1_4_o;

		output  local_2_1_i;
		output valid_2_1_i;
		output incr_2_1_i;
		input local_2_1_o;
		input valid_2_1_o;
		input incr_2_1_o;

		output  local_2_2_i;
		output valid_2_2_i;
		output incr_2_2_i;
		input  local_2_2_o;
		input valid_2_2_o;
		input incr_2_2_o;

		output local_2_3_i;
		output valid_2_3_i;
		output incr_2_3_i;
		input  local_2_3_o;
		input valid_2_3_o;
		input incr_2_3_o;

		output  local_2_4_i;
		output valid_2_4_i;
		output incr_2_4_i;
		input  local_2_4_o;
		input valid_2_4_o;
		input incr_2_4_o;

		output  local_3_1_i;
		output valid_3_1_i;
		output incr_3_1_i;
		input  local_3_1_o;
		input valid_3_1_o;
		input incr_3_1_o;

		output  local_3_2_i;
		output valid_3_2_i;
		output incr_3_2_i;
		input  local_3_2_o;
		input valid_3_2_o;
		input incr_3_2_o;

		output  local_3_3_i;
		output valid_3_3_i;
		output incr_3_3_i;
		input  local_3_3_o;
		input valid_3_3_o;
		input incr_3_3_o;

		output local_3_4_i;
		output valid_3_4_i;
		output incr_3_4_i;
		input  local_3_4_o;
		input valid_3_4_o;
		input incr_3_4_o;

		output local_4_1_i;
		output valid_4_1_i;
		output incr_4_1_i;
		input  local_4_1_o;
		input valid_4_1_o;
		input incr_4_1_o;

		output local_4_2_i;
		output valid_4_2_i;
		output incr_4_2_i;
		input  local_4_2_o;
		input valid_4_2_o;
		input incr_4_2_o;

		output local_4_3_i;
		output valid_4_3_i;
		output incr_4_3_i;
		input  local_4_3_o;
		input valid_4_3_o;
		input incr_4_3_o;

		output local_4_4_i;
		output valid_4_4_i;
		output incr_4_4_i;
		input local_4_4_o;
		input valid_4_4_o;
		input incr_4_4_o;

	
	endclocking

	modport dut (
		input clk,
		input rst,
	
		input  local_1_1_i,
		input valid_1_1_i,
		input incr_1_1_i,
		output  local_1_1_o,
		output valid_1_1_o,
		output incr_1_1_o,

		input  local_1_2_i,
		input valid_1_2_i,
		input incr_1_2_i,
		output  local_1_2_o,
		output valid_1_2_o,
		output incr_1_2_o,

		input  local_1_3_i,
		input valid_1_3_i,
		input incr_1_3_i,
		output  local_1_3_o,
		output valid_1_3_o,
		output incr_1_3_o,

		input  local_1_4_i,
		input valid_1_4_i,
		input incr_1_4_i,
		output  local_1_4_o,
		output valid_1_4_o,
		output incr_1_4_o,

		input  local_2_1_i,
		input valid_2_1_i,
		input incr_2_1_i,
		output  local_2_1_o,
		output valid_2_1_o,
		output incr_2_1_o,

		input  local_2_2_i,
		input valid_2_2_i,
		input incr_2_2_i,
		output  local_2_2_o,
		output valid_2_2_o,
		output incr_2_2_o,

		input local_2_3_i,
		input valid_2_3_i,
		input incr_2_3_i,
		output  local_2_3_o,
		output valid_2_3_o,
		output incr_2_3_o,

		input  local_2_4_i,
		input valid_2_4_i,
		input incr_2_4_i,
		output  local_2_4_o,
		output valid_2_4_o,
		output incr_2_4_o,

		input  local_3_1_i,
		input valid_3_1_i,
		input incr_3_1_i,
		output  local_3_1_o,
		output valid_3_1_o,
		output incr_3_1_o,

		input  local_3_2_i,
		input valid_3_2_i,
		input incr_3_2_i,
		output  local_3_2_o,
		output valid_3_2_o,
		output incr_3_2_o,

		input  local_3_3_i,
		input valid_3_3_i,
		input incr_3_3_i,
		output  local_3_3_o,
		output valid_3_3_o,
		output incr_3_3_o,

		input  local_3_4_i,
		input valid_3_4_i,
		input incr_3_4_i,
		output  local_3_4_o,
		output valid_3_4_o,
		output incr_3_4_o,

		input  local_4_1_i,
		input valid_4_1_i,
		input incr_4_1_i,
		output  local_4_1_o,
		output valid_4_1_o,
		output incr_4_1_o,

		input  local_4_2_i,
		input valid_4_2_i,
		input incr_4_2_i,
		output  local_4_2_o,
		output valid_4_2_o,
		output incr_4_2_o,

		input  local_4_3_i,
		input valid_4_3_i,
		input incr_4_3_i,
		output  local_4_3_o,
		output valid_4_3_o,
		output incr_4_3_o,

		input  local_4_4_i,
		input valid_4_4_i,
		input incr_4_4_i,
		output  local_4_4_o,
		output valid_4_4_o,
		output incr_4_4_o

	);
	
endinterface
