module seq_item;
  timeunit 1ns/1ps;
  `include "uvm_macros.svh"
  import uvm_pkg::*;
  import tx_pkg::*;

  initial begin

    $timeformat(-9,0,"ns",0);
    run_test("seq_item_test");
  end
endmodule
