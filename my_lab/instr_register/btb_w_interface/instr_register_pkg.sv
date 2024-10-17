package instr_register_pkg;
  timeunit 1ns/1ns;
  parameter DEPTH = 1024;
  parameter WIDTH = $clog2(DEPTH);

  typedef enum logic [2:0] { ZERO,PASSA,PASSB,ADD,SUB,DIV,MUL,MOD} opcode_t;
  typedef bit signed [31:0] operand_t;
  typedef logic [WIDTH-1:0] index_t;

  typedef struct{
    opcode_t opc;
    operand_t op_a;
    operand_t op_b;
  }instruction_t;

endpackage
