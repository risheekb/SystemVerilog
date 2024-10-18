module top;
  import alu_pkg::*;

  operand_t A;
  operand_t B;
  logic clk;
  logic reset_n;
  logic start;
  opcode_t opcode;
  result_t result;
  logic done; 
  
  alu_interface inf(.*);
  initial begin 
    clk = 1'b0;
    forever #5 clk = ~clk;
  end

  tinyalu DUT(.*);
  tb_basic TEST(.*);

endmodule
