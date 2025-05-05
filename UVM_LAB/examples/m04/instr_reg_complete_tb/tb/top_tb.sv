module top_tb;
  timeunit 1ns;timeprecision 1ns;
  import uvm_pkg::*;
  import tb_pkg::*;

  initial begin
    $timeformat(-9,0,"ns",6);

    run_test();
  end
endmodule
