interface instr_reg_ifc();
  import instr_reg_pkg::*;
  logic clk,load_en,reset_n;
  operand4_t operand_a,operand_b;
  opcode_t opcode;
  pointer4_t write_pointer,read_pointer;
  instruction_t instruction_word;
  logic valid;
endinterface


