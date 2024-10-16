module top;
  import ram_test_pkg::*;
  timeunit 1ns/1ns;
  logic clk;
  ram_interface inf(.*);
  //tb_basic TEST(.inf(inf));
  initial run_test(inf);
  DualPortRam DUT(.inf(inf));
  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end
endmodule
