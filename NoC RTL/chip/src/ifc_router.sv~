interface ifc_router ();
	logic clk;
	logic rst;
	
	logic [15:0] north_i;
	logic [15:0] south_i;
	logic [15:0] east_i;
	logic [15:0] west_i;
	logic [15:0] local_i;

	logic valid_n_i;
	logic valid_s_i;
	logic valid_e_i;
	logic valid_w_i;
	logic valid_l_i;

	logic n_incr_i;
	logic s_incr_i;
	logic e_incr_i;
	logic w_incr_i;
	logic l_incr_i;

	logic [15:0] north_o;
        logic [15:0] south_o;
        logic [15:0] east_o;
        logic [15:0] west_o;
        logic [15:0] local_o;

	logic valid_n_o;
        logic valid_s_o;
        logic valid_e_o;
        logic valid_w_o;
        logic valid_l_o;

	logic n_incr_o;
        logic s_incr_o;
        logic e_incr_o;
        logic w_incr_o;
        logic l_incr_o;

	logic [7:0] location;

	
	
	modport dut (
			input clk,
        		input rst,

       			input north_i,
        		input south_i,
       			input east_i,
        		input west_i,
        		input local_i,

        		input valid_n_i,
        		input valid_s_i,
        		input valid_e_i,
        		input valid_w_i,
        		input valid_l_i,

        		input n_incr_i,
        		input s_incr_i,
        		input e_incr_i,
        		input w_incr_i,
        		input l_incr_i,
			input location,

                        output north_o,
                        output south_o,
                        output east_o,
                        output west_o,
                        output local_o,

                        output valid_n_o,
                        output valid_s_o,
                        output valid_e_o,
                        output valid_w_o,
                        output valid_l_o,

                        output n_incr_o,
                        output s_incr_o,
                        output e_incr_o,
                        output w_incr_o,
                        output l_incr_o
		);

endinterface

