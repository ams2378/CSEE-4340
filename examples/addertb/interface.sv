interface ifc (input bit clk);
  logic [31:0] a;
  logic [31:0] b;
  logic [31:0] sum;

  // note that the outputs and inputs are reversed from the dut
  clocking cb @(posedge clk);
    output a, b;
    input sum;
  endclocking

  modport dut (input a, b, output sum);
  modport bench (clocking cb);

endinterface
