/*-----------------------------------------------------
Design Name : CAM
File Name   : FF.sv
Function    : Flip flop- modified from basic definition to support matching functionality
*///-----------------------------------------------------

module out_reg (
	input clk,
	input rst,

	input [15:0] north_in,
	input [15:0] south_in,
	input [15:0] east_in,
	input [15:0] west_in,
	input [15:0] local_in,

	input  n_incr_i,
	input  s_incr_i,
	input  e_incr_i,
	input  w_incr_i,
	input  l_incr_i,

	input  valid_n_i,
	input  valid_s_i,
	input  valid_e_i,
	input  valid_w_i,
	input  valid_l_i,


	output [15:0] north_out,
	output [15:0] south_out,
	output [15:0] east_out,
	output [15:0] west_out,
	output [15:0] local_out,

	output  n_incr_o,
	output  s_incr_o,
	output  e_incr_o,
	output  w_incr_o,
	output  l_incr_o,

	output  valid_n_o,
	output  valid_s_o,
	output  valid_e_o,
	output  valid_w_o,
	output  valid_l_o



);

	reg [15:0] north_out_t;
	reg [15:0] south_out_t;
	reg [15:0] east_out_t;
	reg [15:0] west_out_t;
	reg [15:0] local_out_t;

	reg  n_incr_o_t;
	reg  s_incr_o_t;
	reg  e_incr_o_t;
	reg  w_incr_o_t;
	reg  l_incr_o_t;

	reg  valid_n_o_t;
	reg  valid_s_o_t;
	reg  valid_e_o_t;
	reg  valid_w_o_t;
	reg  valid_l_o_t;

/*
 * the write block
 */
always_ff @(posedge clk) begin
	if (rst) begin
	
	  north_out_t = '0;
	  south_out_t = '0;
	  east_out_t = '0;
	  west_out_t = '0;
	  local_out_t = '0;

	  n_incr_o_t = '0;
	  s_incr_o_t = '0;
	  e_incr_o_t = '0;
	  w_incr_o_t = '0;
	  l_incr_o_t = '0;

	  valid_n_o_t = '0;
	  valid_s_o_t = '0;
	  valid_e_o_t = '0;
	  valid_w_o_t = '0;
	  valid_l_o_t = '0;

	end else  begin

	  north_out_t = north_in;
	  south_out_t = south_in;
	  east_out_t = east_in;
	  west_out_t = west_in;
	  local_out_t = local_in;

	  n_incr_o_t = n_incr_i;
	  s_incr_o_t = s_incr_i;
	  e_incr_o_t = e_incr_i;
	  w_incr_o_t = w_incr_i;
	  l_incr_o_t = l_incr_i;

	  valid_n_o_t = valid_n_i;
	  valid_s_o_t = valid_s_i;
	  valid_e_o_t = valid_e_i;
	  valid_w_o_t = valid_w_i;
	  valid_l_o_t = valid_l_i;
	end


/*	end else begin

	  north_out_t = north_out_t;
	  south_out_t = south_out_t;
	  east_out_t = east_out_t;
	  west_out_t = west_out_t;
	  local_out_t = local_out_t;

	  n_incr_o_t = n_incr_o_t;
	  s_incr_o_t = s_incr_o_t;
	  e_incr_o_t = e_incr_o_t;
	  w_incr_o_t = w_incr_o_t;
	  l_incr_o_t = l_incr_o_t;

	  valid_n_o_t = valid_n_o_t;
	  valid_s_o_t = valid_s_o_t;
	  valid_e_o_t = valid_e_o_t;
	  valid_w_o_t = valid_w_o_t;
	  valid_l_o_t = valid_l_o_t;


	end
*/
end

/*
 * the read block
 */

assign	  north_out = north_out_t;
assign	  south_out = south_out_t;
assign	  east_out = east_out_t;
assign	  west_out = west_out_t;
assign	  local_out = local_out_t;

assign	  n_incr_o = n_incr_o_t;
assign	  s_incr_o = s_incr_o_t;
assign	  e_incr_o = e_incr_o_t;
assign	  w_incr_o = w_incr_o_t;
assign	  l_incr_o = l_incr_o_t;

assign	  valid_n_o = valid_n_o_t;
assign	  valid_s_o = valid_s_o_t;
assign	  valid_e_o = valid_e_o_t;
assign	  valid_w_o = valid_w_o_t;
assign	  valid_l_o = valid_l_o_t;



endmodule

