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

   bit [4:0] req_port_addr_o [5];
   logic [15:0] dir_i [5];

integer my_qn[$:5];
integer my_qs[$:5];
integer my_qe[$:5];  
integer my_qw[$:5];
integer my_ql[$:5];   

bit pop_req_n; 
bit pop_req_s; 
bit pop_req_e; 
bit pop_req_w; 
bit pop_req_l;
 
int count_n ;
int count_s ;
int count_e ;
int count_w ;
int count_l ;

bit en_n;
bit en_s;
bit en_e;
bit en_w;
bit en_l;

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



function void input_buffer ()

  if (valid_n_i) begin
     my_qn.push_back(north_i);
  end	
if (valid_s_i) begin
     my_qs.push_back(south_i);
  end		                  
 if (valid_e_i) begin
     my_qe.push_back(east_i);
  end	
 if (valid_w_i) begin
     my_qw.push_back(west_i);
  end
if (valid_l_i) begin
     my_ql.push_back(local_i);
  end

endfunction



function void fsm ()
/*handling north queue*/

if (count_n == 0)begin
    if (pop_req_n ==0) begin
      count_n =0;
      en_n = 1;
    end
    else begin
      northq_o = my_qn.popfront();
      en_n = 0;
      count_n++;
    end
end

else begin
   if (pop_req_n ==0) begin
      en_n = 0;
    end
    else begin
      north_q_o = my_qn.popfront();
      en_n =0;
      count_n++;
      if (count_n == 5) begin
         count_n =0;
      end
    end
end


/*handling south queue*/
  
	                  
if (count_s == 0)begin
    if (pop_req_s ==0) begin
      count_s =0;
      en_s = 1;
    end
    else begin
      south_q_o = my_qs.popfront();
      en_s = 0;
      count_s++;
    end
end

else begin
   if (pop_req_s ==0) begin
      en_s = 0;
    end
    else begin
      south_q_o = my_qs.popfront();
      en_s =0;
      count_s++;
      if (count == 5) begin
         count_s=0;
      end
    end
end

/*handling east queue*/
 
	                  
if (count_e == 0)begin
    if (pop_req_e ==0) begin
      count_e =0;
      en_e = 1;
    end
    else begin
      east_q_o = my_qe.popfront();
      en_e = 0;
      count_e++;
    end
end

else begin
   if (pop_req_e ==0) begin
      en_e = 0;
    end
    else begin
      east_q_o = my_qe.popfront();
      en_e =0;
      count_e++;
      if (count_e == 5) begin
         count_e =0;
      end
    end
end

/*handling west queue*/
  	
	                  
if (count_w == 0)begin
    if (pop_req_w ==0) begin
      count_w =0;
      en_w = 1;
    end
    else begin
      west_q_o = my_qw.popfront();
      en_w = 0;
      count_w++;
    end
end

else begin
   if (pop_req_w ==0) begin
      en_w = 0;
    end
    else begin
      west_q_o = my_qw.popfront();
      en_w =0;
      count_w++;
      if (count_w == 5) begin
         count_w=0;
      end
    end
end

/*handling local queue*/
 	
	                  
if (count_l == 0)begin
    if (pop_req_l ==0) begin
      count_l =0;
      en_l = 1;
    end
    else begin
      local_q_o = my_ql.popfront();
      en_l = 0;
      count_l++;
    end
end

else begin
   if (pop_req_l ==0) begin
      en_l = 0;
    end
    else begin
      local_q_o = my_ql.popfront();
      en_l = 0;
      count_l++;
      if (count_l == 5) begin
         count_l = 0;
      end
    end
end
end function


endclass
