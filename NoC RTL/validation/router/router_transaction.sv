/**
 * @filename  		router_transaction.sv 
 *
 * @brief     		The file includes the software model of the router_transaction class
 * @authors   		Ayushi Rajeev		<ar3110@columbia.edu>
 *			Ashwin Ramachandran	<ar2648@columbia.edu>
 *	     		
 *  	 
 */

class router_transaction;
   /*
    * incoming packet transaction densities
    */

   int reset_density;
   
   /* probability of a flit being sent */
   int north_density;
   int south_density;
   int east_density;
   int west_density;
   int local_density;

   /* the flit itself */
   rand bit [15:0] north_flit;
   rand bit [15:0] south_flit;
   rand bit [15:0] east_flit;
   rand bit [15:0] west_flit;
   rand bit [15:0] local_flit;

   /* 
    * random position of the hot bit in
    * the header flit's x coordinate
    */
   rand int onepos_x_north;
   rand int onepos_x_south;
   rand int onepos_x_east;
   rand int onepos_x_west;
   rand int onepos_x_local;

   /* 
    * random position of the hot bit in
    * the header flit's y coordinate
    */
   rand int onepos_y_north;
   rand int onepos_y_south;
   rand int onepos_y_east;
   rand int onepos_y_west;
   rand int onepos_y_local;

   constraint hotBits {
      onepos_x_north >= 4;
      onepos_x_north <= 7;

      onepos_x_south >= 4;
      onepos_x_south <= 7;

      onepos_x_east >= 4;
      onepos_x_east <= 7;

      onepos_x_west >= 4;
      onepos_x_west <= 7;

      onepos_x_local >= 4;
      onepos_x_local <= 7;

      onepos_y_north >= 0;
      onepos_y_north <= 3;

      onepos_y_south >= 0;
      onepos_y_south <= 3;

      onepos_y_east >= 0;
      onepos_y_east <= 3;

      onepos_y_west >= 0;
      onepos_y_west <= 3;

      onepos_y_local >= 0;
      onepos_y_local <= 3;
   }

   /* counter increment requests */
   int n_incr_density;
   int s_incr_density;
   int e_incr_density;
   int w_incr_density;
   int l_incr_density;

   function new(int rst_d,
		int north_d,
		int south_d,
		int east_d,
		int west_d,
		int loc_d,

		int n_incr_d,
		int s_incr_d,
		int e_incr_d,
		int w_incr_d,
		int l_incr_d);

      reset_density = rst_d;

      north_density = north_d;
      south_density = south_d;
      east_density = east_d;
      west_density = west_d;
      local_density = loc_d;

      n_incr_density = n_incr_d;
      s_incr_density = s_incr_d;
      e_incr_density = e_incr_d;
      w_incr_density = w_incr_d;
      l_incr_density = l_incr_d;
   endfunction

   /*
    * randomly generated values to determine if we have
    * a flit transaction on any of the 5 input ports
    */
   rand bit reset_req;

   rand bit north_req;
   rand bit south_req;
   rand bit east_req;
   rand bit west_req;
   rand bit local_req;

   /*
    * randomly generated values to determine if we have
    * a increment request for any of the 5 neighbors
    */
   rand bit n_incr_req;
   rand bit s_incr_req;
   rand bit e_incr_req;
   rand bit w_incr_req;
   rand bit l_incr_req;

   /*
    * constrain the values so that they are 0 or 1 based on
    * the randomly generated value
    */
   constraint density_dist {
      reset_req dist {0:/100-reset_density, 1:/reset_density};

      north_req dist {0:/100-north_density, 1:/north_density};
      south_req dist {0:/100-south_density, 1:/south_density};
      east_req dist {0:/100-east_density, 1:/east_density};
      west_req dist {0:/100-west_density, 1:/west_density};
      local_req dist {0:/100-local_density, 1:/local_density};

      n_incr_req dist {0:/100-n_incr_density, 1:/n_incr_density};
      s_incr_req dist {0:/100-s_incr_density, 1:/s_incr_density};
      e_incr_req dist {0:/100-e_incr_density, 1:/e_incr_density};
      w_incr_req dist {0:/100-w_incr_density, 1:/w_incr_density};
      l_incr_req dist {0:/100-l_incr_density, 1:/l_incr_density};
   }
endclass
