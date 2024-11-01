module top;
  import alu_test_pkg::*;

  //operand_t A;
  //operand_t B;
  logic clk;
  //logic reset_n;
  //logic start;
  //opcode_t opcode;
  //result_t result;
  //logic done; 
  
  alu_interface inf(clk);
  initial begin 
    clk = 1'b0;
    forever #5 clk = ~clk;
  end
  
  initial run_test(inf);
  tinyalu DUT(.*);
  //tb_basic TEST(.*);
  //tb_basic_2 TEST(.inf(inf));

endmodule
