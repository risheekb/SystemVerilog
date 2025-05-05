`timescale 1ns/1ns
module top_hvl;
  import uvm_pkg::*;
  import noise_pkg::*;

  initial begin
    $timeformat(-9,0,"ns",4);
    run_test("multi_test");
  end

  initial #1000ns $fatal(0, "Timeout");

endmodule
