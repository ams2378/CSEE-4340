/*-----------------------------------------------------
Design Name : CAM
File Name   : cam_test.sv
Function    : test file to validate the design

Description: The following types of tests are performed:

0. Default cases provided with this test file
1. Read - Write test:
	Whole memory module is populated with distinct data items for each location. Afterwards data is read from each 
	index and compared with the expected data values which were supplied earlier. If all matches then it'll confirm 
	that CAM performed write and read operation successfuly for ALL location. 
2. Simultaneous Read-Search
	Checked if CAM can handle simultaneous read and search at the same memory location (checked for all rows). Both 
	read and search occurs in negative clock cycle.
3. Search
	Search for previously saved data (in step 1). In this case, each row contains distinct data. 
4. Search when more than one row contains same data value
	In this case data is replicated in the CAM. CAM should return the index of first matching row or memory location. 
5. Search when searched data is not present in CAM
6. Check if enables are working correctly. If enables are LOW (read/write/search) then data shouldn't be read, written or searched
   even if other wires are driven with valid memory index, write data or search data.
*/

module cam_test();

    parameter DATA_WIDTH = 5;
    parameter DATA_SIZE = (1 << DATA_WIDTH);

    reg clk;
    reg rst;
    reg read_i;
    reg write_i;
    reg search_i;
    reg [DATA_WIDTH - 1 : 0] write_index_i;
    reg [DATA_SIZE - 1 : 0] write_data_i;
    reg [DATA_SIZE - 1 : 0] search_data_i;
    reg [DATA_WIDTH - 1 : 0] read_index_i;

    wire [DATA_WIDTH - 1 : 0] search_index_o;
    wire [DATA_SIZE - 1 : 0] read_value_o;
    wire search_valid_o;
    wire read_valid_o;

    bit error;

    cam cam_dut (.clk, .rst, .write_i, .write_index_i, .write_data_i,
                 .search_data_i, .search_index_o, .read_index_i, .read_i,
                 .search_i, .read_value_o, .search_valid_o, .read_valid_o);	
	
    initial begin
        // Beginning of time.  Reset is on.
	$vcdpluson;
        clk = 0;
        rst = 1;
        search_data_i = 0;
        search_i = 0;
        write_data_i = 7;
        write_index_i = 9;
        write_i = 0;
        read_index_i = 9;
        read_i = 0;
 
        // Wait a clock cycle.
        #1 clk = 1;
        #1 clk = 0;
        rst = 0;

        // Done with reset.  Wait a cycle.
        #1 clk = 1;       
        #1 clk = 0;       
        #1 $display("search_index should be 31.  It is: %d", search_index_o);
        $display("search valid should be 0.  It is: %d", search_valid_o);

        // Write the value 7 to address 9.  Search for 7.
        // Read from address 9.
        write_i = 1;
        #1 clk = 1;
        read_i = 1;
        search_i = 1;
        search_data_i = 7;
        #1 clk = 0;
        #1$display("search_index should 9.  It is: %d", search_index_o);
        $display("search_valid should be 1.  It is: %d", search_valid_o);
        $display("read_value should be 7.  It is: %d", read_value_o);
        $display("read_valid should be 1.  It is: %d", read_valid_o);

	//Search for 10 (which is not in memory)
	write_i= 0;
	read_i = 1;
	#1 clk = 1;
	search_i = 1;
	search_data_i = 10;
	#1 clk = 0; 
	#1 $display("search_index should 31.  It is: %d", search_index_o);
        $display("search_valid should be 0.  It is: %d", search_valid_o);
 	$display("read_value should be 7.  It is: %d", read_value_o);
        $display("read_valid should be 1.  It is: %d", read_valid_o);

	read_i = 1;
	read_index_i = 0;
	#1 clk = 1;
	search_i = 1;
	search_data_i = 10;
	#1 clk = 0; 
	#1 $display("search_index should 31.  It is: %d", search_index_o);
        $display("search_valid should be 0.  It is: %d", search_valid_o);
 	$display("read_value should be 0.  It is: %d", read_value_o);
        $display("read_valid should be 1.  It is: %d", read_valid_o);

	/*
	Testing if write and read operation for entire CAM is good.
	write random data to every row
	*/	
	for (int i = 0; i<32; i++) begin
	write_i = 1;
        write_data_i = i*i;
        write_index_i = i;
	
	#1 clk = 1;
	#1 clk = 0;		
		
	end

	/*
	reading data from each row and comparing with expected value	
	*/

	for (int i = 0; i<32; i++) begin
	write_i = 0;	
	#1 clk = 1;
        read_index_i = i;
	read_i = 1;
	#1 clk = 0;		
	#1	
		if ((read_value_o != i*i) || (read_valid_o != 1)) begin
			error = 1;
 			$display("ERROR: read_value should be %d.  It is: %d", i*i, read_value_o);
        		$display("ERROR: read_valid should be 1.  It is: %d", read_valid_o);
		end       				
	end	

	if (error == 1)
		$display("***************** 1. TEST FAILED FOR READ-WRITE- CAM doesn't return the correct data or read from correct address");
	else
		$display("***************** 1. TEST PASSED FOR READ-WRITE- CAM returns the correct data from correct index");


	/**
	Testing if CAM can handle simultaneous read and search at the same memory location	
	*/
	error = 0;
	for (int i = 0; i<32; i++) begin	
	#1 clk = 1;
	search_i = 1;
        search_data_i = i*i;
	read_index_i = i;
	#1 clk = 0;		
	#1	
		if ((search_index_o != i) || (search_valid_o != 1) || (read_value_o != i*i) || (read_valid_o != 1)) begin
			error = 1;
 			$display("ERROR: Search index should be %d.  It is: %d", i, search_index_o);
        		$display("ERROR: search_valid should be 1.  It is: %d", search_valid_o);
 			$display("ERROR: read_value should be %d.  It is: %d", i*i, read_value_o);
        		$display("ERROR: read_valid should be 1.  It is: %d", read_valid_o);
		end      				
	end	

	if (error == 1)
		$display("***************** 2. TEST FAILED FOR SIMULTANEOUS READ-SEARCH ");
	else
		$display("***************** 2. TEST PASSED FOR SIMULTANEOUS READ-SEARCH ");


	/*
	Testing if search operation is good for entire CAM
	searching for the data written in previous cycles	
	*/
	error = 0;
	for (int i = 0; i<32; i++) begin	
	#1 clk = 1;
        search_data_i = i*i;
	#1 clk = 0;		
	#1	
		if ((search_index_o != i) || (search_valid_o != 1)) begin
			error = 1;
 			$display("ERROR: Search index should be %d.  It is: %d", i, search_index_o);
        		$display("ERROR: search_valid should be 1.  It is: %d", search_valid_o);
		end      				
	end	

	if (error == 1)
		$display("***************** 3. TEST FAILED FOR SEARCH- CAM doesn't return the correct index ");
	else
		$display("***************** 3. TEST PASSED FOR SEARCH- CAM returns the correct index");



	/*
	Testing if search work properly when more than one row contains same data. Search index will reflect the first matching row.
	writing data: row0..row15 and row16..row31 contains same data in same order (data[row0] = data[row16] and so on).
	Rows with higher indexes have higher priority. Hence first matching data will be one with largest index (in this example for 		row0 and row16 (both are fed with same data), row16 will be the first matching row). 
	*/	
	for (int i = 0; i<16; i++) begin
        		write_index_i = i+16;
			write_i = 1;
        		write_data_i = i*i;			
	#1 clk = 1;
	#1 clk = 0;		
		
	end

	/*
	Testing if search returns the first matching row (this case row with higher index)
	*/
	error = 0;
	for (int i = 0; i<16; i++) begin	
	#1 clk = 1;
	search_i = 1;
        search_data_i = i*i;
	#1 clk = 0;		
	#1	
		if ((search_index_o != (16+i)) || (search_valid_o != 1)) begin
			error = 1;
 			$display("ERROR: Search index should be %d.  It is: %d", (16+i), search_index_o);
        		$display("ERROR: search_valid should be 1.  It is: %d", search_valid_o);
		end      				
	end	

	if (error == 1)
		$display("***************** 4. TEST FAILED FOR SEARCH- doesn't return first matching index ");
	else
		$display("***************** 4. TEST PASSED FOR SEARCH- returns first matching index ");


	/*
	Testing if search operation is good if data is not present in the CAM	
	*/
	error = 0;
	for (int i = 0; i<32; i++) begin
	#1 clk = 1;
        search_data_i = (i+32)*(i+32);	
	#1 clk = 0;		
	#1	
		if ((search_index_o != 31) || (search_valid_o != 0)) begin
			error = 1;
 			$display("ERROR: Search index should be %d.  It is: %d", i, search_index_o);
        		$display("ERROR: search_valid should be 1.  It is: %d", search_valid_o);
		end      				
	end	

	if (error == 1)
		$display("***************** 5. TEST FAILED FOR SEARCH- CAM doesn't have searched data ");
	else
		$display("***************** 5. TEST PASSED FOR SEARCH- CAM doesn't have searched data ");

	/*
	checking if enables are performing correctly
	*/
	error = 0;
	write_i=0;
	write_index_i = 31;
	write_data_i = 4;

	#1 clk = 1;
	read_i=0;
	read_index_i = 1;
	search_i=0;
	search_data_i = 1;
	#1 clk = 0;		
	#1 
		if (read_valid_o != 0) begin
			error = 1;
			$display(" ERROR: data shouldn't be read if read enable is LOW");
		end
		if (search_valid_o !=0) begin
			error = 1;
			$display(" ERROR: CAM shouldn't do search if search enable is LOW");
		end

	#1 clk = 1;	
	read_i = 1;
	read_index_i = 31;
	#1 clk = 0;
	#1
		if (read_value_o != 15*15) begin		
			error = 1;
			$display(" ERROR: data is written in memory though write valid was LOW");	
		end

				
	$display("***************** 6. TEST PASSED WHILE CHECKING ENABLES' (READ, WRITE, SEARCH) FUNCTIONALITY");

    end
endmodule



