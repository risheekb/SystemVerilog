module top_hdl;

  timeunit 1ns;timeprecision 1ns;
  import instr_reg_pkg::*;
  import uvm_pkg::*;
  
  instr_reg_ifc ifc();
  driver_bfm d_ifc(ifc);
  monitor_bfm m_ifc(ifc);

  instr_reg dut (
    .clk(ifc.clk),
    .load_en(ifc.load_en),
    .reset_n(ifc.reset_n),
    .opcode(ifc.opcode),
    .write_pointer(ifc.write_pointer),
    .read_pointer(ifc.read_pointer),
    .instruction_word(ifc.instruction_word),
    .valid(ifc.valid),
    .operand_a(ifc.operand_a),
    .operand_b(ifc.operand_b)
  );

  initial begin

    uvm_config_db #(virtual driver_bfm)::set(null, "uvm_test_top", "d_vif", d_ifc);
    uvm_config_db #(virtual monitor_bfm)::set(null, "uvm_test_top", "m_vif", m_ifc);
  end
  //clock generator
  
  initial begin
    ifc.clk <= 0;
    forever #5ns ifc.clk = ~ifc.clk;
  end
endmodule
