class tx_test extends uvm_test;
  `uvm_component_utils(tx_test)
  function new(string name,uvm_component parent);
    super.new(name,parent);
  endfunction

  tx_env env;
  tx_agent_config agt_cfg;
  tx_env_config env_cfg;

  virtual function void build_phase(uvm_phase phase);
    env = tx_env::type_id::create("env",this);
    agt_cfg = tx_agent_config::type_id::create("agt_cfg");
    if (! uvm_config_db#(virtual tx_ifc)::get(this, "", "vif", agt_cfg.vif))
      `uvm_fatal("NO_VIF", "No virtual interface found");
    env_cfg = tx_env_config::type_id::create("env_cfg");
    env_cfg.agt_cfg = agt_cfg;
    uvm_config_db#(tx_env_config)::set(this,"env","env_config",env_cfg);
  endfunction

  virtual function void end_of_elaboration_phase(uvm_phase phase);
    `uvm_info("TEST_TOPO", "Printing topology from end_of_elaboration_phase", UVM_NONE);
    uvm_top.print_topology();
  endfunction
  virtual task run_phase(uvm_phase phase);
    tx_sequence seq;
    `uvm_info("RUN",$sformatf("In %m"),UVM_FULL)
    phase.phase_done.set_drain_time(this, 100); // delay objection drop 100ns

    phase.raise_objection(this, get_full_name());
    seq = tx_sequence::type_id::create("seq");
    seq.start(env.agt.sqr);
    phase.drop_objection(this, get_full_name());
  endtask


endclass
