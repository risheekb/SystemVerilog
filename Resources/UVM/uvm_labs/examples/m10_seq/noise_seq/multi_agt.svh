class multi_agt extends uvm_agent;
  `uvm_component_utils(multi_agt)
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  uvm_sequencer sqr;

  agt_config agt_cfg;

  virtual function void set_config(agt_config agt_cfg);
    this.agt_cfg = agt_cfg;
  endfunction

  virtual function void build_phase(uvm_phase phase);
    sqr = new("sqr", this);
    agt_cfg.sqr = sqr;
  endfunction

endclass
