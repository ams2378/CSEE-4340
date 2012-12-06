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

   logic [4:0] req_port_addr_o [5];
   logic [15:0] dir_i [5];

   function void adress_gen (logic [7:0] Myaddr_i);
     for (int ind =0; ind<5; ind++) begin
            if ([7:4] dir_i[ind] != [7:4] Myaddr_i) begin

              		if ([7:4] dir_i[ind] > [7:4] Myaddr_i) begin /* send north */
               		req_port_addr_0[ind] = 5'b00001;
                        end

              		else begin
               		req_port_addr_0[ind] = 5'b00010;/* send south */
                        end
             end 
            else begin
                	if ([3:0] dir_i[ind] > [3:0] Myaddr_i) begin /* send east */
               		req_port_addr_0[ind] = 5'b00100;
                        end

              		else if ([3:0] dir_i[ind] < [3:0] Myaddr_i) begin /* send west */
               		req_port_addr_0[ind] = 5'b01000;
                        end

                	else begin 
                	req_port_addr_0[ind] = 5'b10000; /* destination reached */
            	        end
             end
           end
   endfunction

endclass
