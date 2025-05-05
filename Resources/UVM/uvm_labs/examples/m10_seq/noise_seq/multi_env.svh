class multi_env extends uvm_env;
  `uvm_component_utils(multi_env)
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  multi_agt agt;
  agt_config agt_cfg;

  virtual function void set_config(agt_config agt_cfg);
    this.agt_cfg = agt_cfg;
  endfunction

  virtual function void build_phase(uvm_phase phase);
    agt = multi_agt::type_id::create("agt", this);
    agt.set_config(agt_cfg);
  endfunction

endclass
