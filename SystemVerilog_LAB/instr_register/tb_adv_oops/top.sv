module top;
  timeunit 1ns/1ns;
  import instr_register_test::*;
  timeunit 1ns/1ns;
  logic clk;
  instr_register_inf io(clk); 
  //instr_register_test TEST(.*);
  initial begin
    clk <= 0;
    forever #5 clk = ~clk;
  end

  initial run_test(io);
  instr_register DUT(.clk(clk),.io(io));

 initial begin
    $timeformat(-9, 0, "ns", 5);
    #10_000ns $fatal(0, "Timeout - probably a testbench bug?");
  end 

endmodule

