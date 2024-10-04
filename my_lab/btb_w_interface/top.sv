module top;
  import instr_register_pkg::*;
  logic clk;
  instr_register_inf io(clk); 
  instr_register DUT(.*);
  instr_register_test TEST(.*);
  initial begin
    clk = 1'b0;
    forever #5 clk = ~clk;
  end

endmodule

