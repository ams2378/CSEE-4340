/*-----------------------------------------------------
Design Name : router
File Name   : router.sv
Function    : Top level file 

author	    : Dechhin Lama <ddl2126@columbia.edu>
*///-----------------------------------------------------


module router (
	ifc.dut d
	);

/*
 * instantiate the queue buffers
 
queue inputbuffers(
	.north_i(d.north_i),
	.south_i(d.south_i),
	.east_i(d.east_i),
 	.west_i(d.west_i),
	.local_i(d.local_i)
	);
*/	

endmodule

