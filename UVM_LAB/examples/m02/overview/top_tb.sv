module top_tb;

  import uvm_pkg::*;
  import tx_pkg::*;
  initial begin
    $timeformat(-9,0,"ns",3);
    run_test();
  end 

  initial #1000ns $fatal(0,"Timeout");
endmodule
