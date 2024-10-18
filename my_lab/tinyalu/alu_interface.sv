interface alu_interface
  import alu_pkg::*;
  (input logic clk);
  
  operand_t A;
  operand_t B;
  logic reset_n;
  logic start;
  opcode_t opcode;
  result_t result;
  logic done;

endinterface
