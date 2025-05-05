class multi_test extends uvm_test;
  `uvm_component_utils(multi_test)
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  multi_env env;
  agt_config agt_cfg;

  virtual function void build_phase(uvm_phase phase);
    env = multi_env::type_id::create("env", this);
    agt_cfg = agt_config::type_id::create("agt_cfg");
    env.set_config(agt_cfg);
  endfunction

  virtual task run_phase(uvm_phase phase);
    two_vseq vseq;
    vseq = two_vseq::type_id::create("vseq");
    phase.raise_objection(this, get_type_name());
    vseq.start(env.agt.sqr);
    phase.drop_objection(this, get_type_name());
  endtask

endclass
