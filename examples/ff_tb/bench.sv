//adam's test bench

class ff_transaction;
    rand bit rst;
    rand int data_i;
endclass

					//golden model
class ff_test;
    bit rst;
    int data_i;
    int data_o;
    int stored_data;

    function void golden_result;	//golden result
        data_o = stored_data;
        if(rst) stored_data = 0;
        else stored_data = data_i;
    endfunction
endclass

class ff_checker;								//checker class
    function bit check_result (int dut_value, int bench_value, bit verbose); 
        bit passed = (dut_value == bench_value);
        if(verbose) $display("dut_value: %d", dut_value);
        if(passed) begin
            if(verbose) $display("%t : pass \n", $realtime);
        end
        else begin
            $display("%t : fail \n", $realtime);
            $display("dut value: %d", dut_value);
            $display("bench value: %d", bench_value);
            $exit();
        end
        return passed;
    endfunction  
endclass

class ff_env;
    int cycle = 0;
    int max_transactions = 1000;
    int warmup_time = 2;
    bit verbose = 1;

    function configure(string filename);
        int file, value, seed, chars_returned;
        string param;
        file = $fopen(filename, "r");
        while(!$feof(file)) begin
            chars_returned = $fscanf(file, "%s %d", param, value);
            if ("RANDOM_SEED" == param) begin
                seed = value;
                $srandom(seed);
            end
            else if("TRANSACTIONS" == param) begin
                max_transactions = value;
            end
            else begin
                $display("Never heard of a: %s", param);
                $exit();
            end
        end
    endfunction
endclass

program tb (ifc.bench ds);
    ff_test test;
    ff_transaction packet; 
    ff_checker checker;
    ff_env env;
    int cycle; // For DVE

    task do_cycle;
        env.cycle++;
        cycle = env.cycle;
        packet = new();
        packet.randomize();
        test.data_i <= packet.data_i;				//passing data to test bench and golden model happens here
        test.rst <= packet.rst;
        ds.cb.data_i <= packet.data_i;
        ds.cb.rst <= packet.rst;
        @(ds.cb);
        test.golden_result();
    endtask

    initial begin
        test = new();
        checker = new();
        packet = new();
        env = new();
        env.configure("config.txt");

        // warm up
        repeat (env.warmup_time) begin
            do_cycle();
        end

        // testing
        repeat (env.max_transactions) begin
            do_cycle();
            checker.check_result(ds.cb.data_o, test.data_o, env.verbose);
        end
    end
endprogram
