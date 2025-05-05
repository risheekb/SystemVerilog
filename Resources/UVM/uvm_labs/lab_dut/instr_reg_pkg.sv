/***********************************************************************
 * A SystemVerilog RTL model of an instruction register:
 * Declarations shared by multiple modules
 **********************************************************************/
package instr_reg_pkg;
  timeunit 1ns; timeprecision 1ns;

  typedef enum logic [3:0] {ZERO,
                            PASSA,
                            PASSB,
                            ADD,
                            SUB,
                            MULT,
                            DIV,
                            MOD,
                            AND,
                            OR,
                            XOR,
                            SL,
                            SR,
                            ASL,
                            ASR,
                            U_ADD} opcode_t;

  typedef bit   [23:0] operand2_t;
  typedef logic [23:0] operand4_t;

  typedef struct packed {
    opcode_t   opc;
    operand4_t op_a, op_b;
  } instruction_t;

  parameter int MEMORY_SIZE = 256;
  typedef bit   [$clog2(MEMORY_SIZE)-1:0] pointer2_t;
  typedef logic [$clog2(MEMORY_SIZE)-1:0] pointer4_t;

endpackage : instr_reg_pkg
