`uvm_analysis_imp_decl(_dut_in)
`uvm_analysis_imp_decl(_dut_out)

class tx_scoreboard extends uvm_scoreboard;

  `uvm_component_utils(tx_scoreboard)

  function new(string name,uvm_component parent);
    super.new(name,parent);
  endfunction

  uvm_analysis_imp_dut_in #(tx_in,tx_scoreboard) dut_in_export;
  uvm_analysis_imp_dut_out #(tx_out,tx_scoreboard) dut_out_export;

  int match,mismatch;

  tx_out expect_a [pointer2_t];//expected array for comparing values

  virtual function void build_phase(uvm_phase phase);
    dut_in_export = new("dut_in_export",this);
    dut_out_export = new("dut_out_export",this);
  endfunction

  virtual function void write_dut_in(tx_in t);
    tx_out exp_tx;
    if(t.reset_n === 0) begin
      expect_a.delete();
    end

    else if(t.load_en === 1) begin
      exp_tx = tx_out::type_id::create("exp");
      exp_tx.read_pointer = t.write_pointer;
      exp_tx.instruction.op_a = t.operand_a;
      exp_tx.instruction.op_b = t.operand_b;
      exp_tx.instruction.opc = t.opcode;
      expect_a[exp_tx.read_pointer] = exp_tx;
    end
  endfunction

  virtual function void write_dut_out(tx_out t);
    if(t.reset_n === 0)
      return;
    if(!expect_a.exists(t.read_pointer)) begin
      `uvm_error("SCOREBOARD", $sformatf("read_pointer value %x is an address that has not been written\n", t.read_pointer))
    end

    else if (t.compare(expect_a[t.read_pointer])) begin
      match++;
      expect_a.delete(t.read_pointer);
    end
    else begin
      `uvm_error("SCOREBOARD", $sformatf("Expected and actual did not match at address %h(hex)", t.read_pointer))
      `uvm_info("SCOREBOARD",  $sformatf("DUT out is:%s\nExpected %s",
                               t.sprint(), expect_a[t.read_pointer].sprint()), UVM_NONE)
      mismatch++;
    end

  endfunction

  virtual function void report_phase(uvm_phase phase);
    `uvm_info("SCOREBOARD", $sformatf("\n\n\t Test score: passed=%0d  failed=%0d\n", match, mismatch), UVM_NONE)

    // Look for any orphan transaction that never were sent out by the DUT
    if (expect_a.size() != 0) begin
      `uvm_error("SCOREBOARD", $sformatf("%0d. transactions left in scoreboard at the end of the test", expect_a.size()))
      foreach (expect_a[i]) begin
        $display("aa[%0d]=%s", i, expect_a[i].sprint());
      end
    end

  endfunction
endclass
