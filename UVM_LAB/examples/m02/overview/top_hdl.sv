module top_hdl;
  import uvm_pkg::*;
  logic clk,reset_n;

  tx_ifc ifc(clk,reset_n);
  dut d1(.clk(ifc.clk),.reset_n(ifc.reset_n),.d(ifc.d),.q(ifc.q));
  initial
    uvm_config_db #(virtual tx_ifc)::set(null,  "uvm_test_top",  "vif",  ifc );
  initial begin
    #5 reset_n = 0;
    clk = 1;
    #15 reset_n = 1;

    forever #10 clk = !clk;
  end

endmodule
