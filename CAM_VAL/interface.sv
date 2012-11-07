/**
* @filename  		interface.sv 
*
* @brief     		The file defines the interfaces for test becnh and dut
* @authors   		Dechhin Lama <ddl2126@columbia.edu>
*			
* @modified by		Adil Sadik <ams2378@columbia.edu>
*  	 
*/

interface ifc (input bit clk);
    logic read_i;
    logic [4:0] read_index_i;
	 
    logic write_i;
    logic [4:0] write_index_i;
    logic [31:0] write_data_i;

    logic search_i;
    logic [31:0] search_data_i;
 
    logic read_valid_o;
    logic [31:0] read_value_o;
	
    logic search_valid_o;
    logic [4:0] search_index_o;

    logic rst;

    clocking cb_w @(posedge clk);
        default output #1;
       
	output rst;
	
	output read_i;
	output read_index_i;

	output write_i;
	output write_index_i;
	output write_data_i;

	output search_i;
	output search_data_i;

    endclocking

   clocking cb_r_s @(posedge clk);
       default input #2;

	input negedge read_valid_o;
	input negedge read_value_o;

	input negedge search_valid_o;
	input negedge search_index_o;
    endclocking

    modport dut (
	input clk,
	input rst,
	
	input read_i,
	input read_index_i,

	input write_i,
	input write_index_i,
	input write_data_i,

	input search_i,
	input search_data_i,

	output read_valid_o,
	output read_value_o,
	
	output search_valid_o,
	output search_index_o
	);

    modport bench (clocking cb_w, clocking cb_r_s);
endinterface
