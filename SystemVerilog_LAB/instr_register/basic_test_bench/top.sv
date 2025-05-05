module top;
  import instr_register_pkg::*;
  logic clk;
  logic reset_en;
  logic load_en;
  index_t read_index;
  index_t write_index;
  operand_t operand_a;
  operand_t operand_b;
  opcode_t opcode;
  instruction_t instruction;
  instr_register DUT(.*);
  instr_register_test TEST(.*);
  initial begin
    clk = 1'b0;
    forever #5 clk = ~clk;
  end

endmodule

