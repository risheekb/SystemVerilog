interface driver_bfm
  import instr_reg_pkg::*;
  (instr_reg_ifc ifc);

  timeunit 1ns; timeprecision 1ns;

  task automatic send(
    input bit reset_n,
    input bit load_en,
    input pointer2_t write_pointer,
    input pointer2_t read_pointer,
    input operand2_t operand_a,
    input operand2_t operand_b,
    input opcode_t opcode
  );

    @(posedge ifc.clk);
    #1ns;
    ifc.reset_n         <= reset_n;
    ifc.load_en         <= load_en;
    ifc.write_pointer   <= write_pointer;
    ifc.read_pointer    <= read_pointer;
    ifc.operand_a       <= operand_a;
    ifc.operand_b       <= operand_b;
    ifc.opcode          <= opcode;
  endtask

endinterface
