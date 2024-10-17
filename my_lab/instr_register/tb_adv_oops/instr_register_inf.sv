interface instr_register_inf
  import instr_register_pkg::*;
  (input logic clk);
  logic reset_en;
  logic load_en;
  index_t read_index;
  index_t write_index;
  operand_t operand_a;
  operand_t operand_b;
  opcode_t opcode;
  instruction_t instruction;
endinterface

