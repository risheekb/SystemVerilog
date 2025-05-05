package alu_pkg;

  typedef enum logic [2:0] {NOP=3'b000,ADD=3'b001,SUB=3'b010,NOT=3'b011,XOR=3'b100,AND=3'b101,MUL=3'b110,INC=3'b111} opcode_t;
  typedef logic [7:0] operand_t;
  typedef logic [15:0] result_t;
endpackage
