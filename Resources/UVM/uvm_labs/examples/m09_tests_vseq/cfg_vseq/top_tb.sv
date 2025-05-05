// Top of the testbench
module top_tb();
  timeunit 1ns; timeprecision 1ns;

  import uvm_pkg::*;
  import ahb_test_pkg::*;

  initial begin
    // Pass interface into testbench
    uvm_config_db#(virtual ahb_ifc)::set(null, "uvm_test_top", "ahb_vif", top_hdl.ahb_if);

    // Housekeeping
    $timeformat(-9,0,"ns",3);

    // Start UVM infrastructure
    run_test();
  end
endmodule
