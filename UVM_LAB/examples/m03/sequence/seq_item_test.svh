class seq_item_test extends uvm_test;
  `uvm_component_utils(seq_item_test)

  function new(string name,uvm_component parent);
    super.new(name,parent);
  endfunction

  tx_agent agt;

  virtual function void build_phase(uvm_phase phase);
    agt = tx_agent::type_id::create("agt",this);
  endfunction

  virtual task run_phase(uvm_phase phase);
    tx_sequence seq;

    seq = tx_sequence::type_id::create("seq");
    phase.raise_objection(this);
    seq.start(agt.sqr);
    phase.drop_objection(this);
  endtask
endclass
