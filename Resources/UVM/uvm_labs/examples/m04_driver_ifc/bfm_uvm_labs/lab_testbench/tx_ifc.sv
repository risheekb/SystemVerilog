/***********************************************************************
 * A SystemVerilog testbench for an instruction register.
 * These are the interface signals to connect the testbench & design.
 * This follows the Verification Academy / UVM Framework styles.
 **********************************************************************/

interface tx_ifc();
  import instr_reg_pkg::*;
  logic clk;                      // DUT input
  logic reset_n;                  // DUT input
  logic         load_en;          // DUT input  - To be written into array
  operand2_t    operand_a;        // DUT input  - To be written into array
  operand2_t    operand_b;        // DUT input  - To be written into array
  opcode_t      opcode;           // DUT input  - To be written into array
  instruction_t instruction_word; // DUT output - Output word read from array
  pointer2_t    write_pointer;    // DUT input  - Index to write to
  pointer2_t    read_pointer;     // DUT output - Index to read from
  logic         valid;            // DUT output - is the output of a valid entry

endinterface: tx_ifc
