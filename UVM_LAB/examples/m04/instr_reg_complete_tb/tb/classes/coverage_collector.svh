class coverage_collector extends uvm_subscriber #(tx_in);
  tx_in tx;
  covergroup cg_dut_inputs;

    ADDR: coverpoint tx.write_pointer{
      bins quad1 = {[0:7]} ;
      bins quad2 = {[8:15]};
      bins quad3 = {[16:23]};
      bins quad4 = {[24:31]};
    }

    OPCODE: coverpoint tx.opcode{
      bins div_op = {DIV};
      bins other_ops = default;
    }


    OPA: coverpoint tx.operand_a{
      bins zero = {0};
      bins low = {[1:10]};
      bins high = {[11:$]};
    }

    OPB: coverpoint tx.operand_b{
      bins zero = {0};
      bins low = {[1:10]};
      bins high = {[11:$]};
    }
    DIV_BY_0: cross OPCODE,OPB{
      bins div_0_b = binsof(OPCODE.div_op) && binsof(OPB.zero);
    }
  endgroup
  `uvm_component_utils(coverage_collector)

  function new(string name,uvm_component parent);
    super.new(name,parent);
    cg_dut_inputs = new();

  endfunction

  virtual function void write(tx_in t);
    tx = t;
    cg_dut_inputs.sample();

  endfunction

  virtual function void report_phase(uvm_phase phase);

    `uvm_info("COVERAGE",$sformatf("\n\n\t Functional Coverage = %2.2f%%\n",cg_dut_inputs.get_coverage()),UVM_NONE)
  endfunction

endclass
