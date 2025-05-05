interface monitor_bfm
  import instr_reg_pkg::*;
  (instr_reg_ifc ifc);

  timeunit 1ns; timeprecision 1ns;
  task automatic get_inputs(
    output bit reset_n,
    output bit load_en,
    output pointer2_t write_pointer,
    output pointer2_t read_pointer,
    output operand2_t operand_a,
    output operand2_t operand_b,
    output opcode_t opcode
  );
    @(posedge ifc.clk);
    reset_n = ifc.reset_n;
    load_en = ifc.load_en;
    write_pointer = ifc.write_pointer;
    read_pointer = ifc.read_pointer;
    operand_a = ifc.operand_a;
    operand_b = ifc.operand_b;
    opcode = ifc.opcode;
  
  endtask
  task automatic get_outputs(
    output bit reset_n,
    output pointer2_t read_pointer,
    output instruction_t instruction
  );
    do begin
      @(posedge ifc.clk);
      #2ns;
      reset_n = ifc.reset_n;
      read_pointer = ifc.read_pointer;
      instruction = ifc.instruction_word;
    end
    while(ifc.valid !== 1'b1);
  endtask
endinterface
