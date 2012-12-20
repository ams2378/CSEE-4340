interface ifc (input bit clk);
    logic [31:0] data_i;
    logic [31:0] data_o;
    logic rst;

    clocking cb @(posedge clk);
        default input #2 output #3;
        output data_i;
        output rst;
        input data_o;
    endclocking

    modport dut (input data_i, input rst, input clk, output data_o);
    modport bench (clocking cb);
endinterface
