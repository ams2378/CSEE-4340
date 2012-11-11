

module xbar (

	input grant_access_north_i,
	input grant_access_south_i,
	input grant_access_east_i,
	input grant_access_west_i,
	input grant_access_local_i,

	input [15:0] pop_northq_i,
	input [15:0] pop_southq_i,
	input [15:0] pop_eastq_i,
	input [15:0] pop_westq_i,
	input [15:0] pop_localq_i,

	output [15:0] north_o;
	output [15:0] south_o;
	output [15:0] east_o;
	output [15:0] west_o;
	output [15:0] local_o;

)
