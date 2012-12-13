/**
 * @filename  		router_test.sv 
 *
 * @brief     		The file includes the golden model of the router
 * @authors   		Ayushi Rajeev		<ar3110@columbia.edu>
 *			Ashwin Ramachandran	<ar2648@columbia.edu>
 *	     		
 *  	 
 */

class router_test;

   bit rst;

   logic [15:0] north_i;
   logic [15:0] south_i;
   logic [15:0] east_i;
   logic [15:0] west_i;
   logic [15:0] local_i;

   bit 	n_incr_i;
   bit 	s_incr_i;
   bit 	e_incr_i;
   bit 	w_incr_i;
   bit 	l_incr_i;

   logic [15:0] north_o;
   logic [15:0] south_o;
   logic [15:0] east_o;
   logic [15:0] west_o;
   logic [15:0] local_o;

   bit 	n_incr_o;
   bit 	s_incr_o;
   bit 	e_incr_o;
   bit 	w_incr_o;
   bit 	l_incr_o;

   /* local count of free spaces in our input queues */
   int n_q_free = 5;
   int s_q_free = 5;
   int e_q_free = 5;
   int w_q_free = 5;
   int l_q_free = 5;

   function void golden_result();
   endfunction

endclass
