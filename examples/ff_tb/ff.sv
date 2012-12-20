module ff (ifc.dut d);

    reg [31:0] data;

    always_ff @(posedge d.clk) begin
        if (d.rst) data <= 32'b0;
        else data <= d.data_i;
    end

    assign d.data_o = data;
endmodule
