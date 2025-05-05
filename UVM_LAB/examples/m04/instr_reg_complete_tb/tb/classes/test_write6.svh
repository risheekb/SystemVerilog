class test_write6 extends uvm_test;
  `uvm_component_utils(test_write6)

  function new(string name,uvm_component parent);
    super.new(name,parent);
  endfunction

  tb_env env;
  virtual function void build_phase(uvm_phase phase);
    env_config env_cfg;
    agent_config agt_cfg;

    env_cfg = env_config::type_id::create("env_cfg",this);
    agt_cfg = agent_config::type_id::create("agt_cfg",this);
    agt_cfg.active = UVM_ACTIVE;
    env_cfg.agt_cfg = agt_cfg;

    if(!uvm_config_db #(virtual driver_bfm)::get(this,"","d_vif",agt_cfg.d_vif))
      `uvm_fatal(get_type_name(),"No virtual interface found for driver")
    if(!uvm_config_db #(virtual monitor_bfm)::get(this,"","m_vif",agt_cfg.m_vif))
      `uvm_fatal(get_type_name(),"No virtual interface found for monitor")
    uvm_config_db #(env_config)::set(this,"env","env_cfg",env_cfg);

    env = tb_env::type_id::create("env",this);
  endfunction

  virtual function void end_of_elaboration_phase(uvm_phase phase);
    $display("\n");
    uvm_top.print_topology();
  endfunction

  virtual task run_phase(uvm_phase phase);
    seq_write6 write_sequence;
    `uvm_info("TEST","\n\n\n ***** TESTING WRITE ***** \n\n",UVM_NONE)
    phase.raise_objection(this,get_type_name());
    phase.phase_done.set_drain_time(this,10);
    write_sequence = seq_write6::type_id::create("write_sequence");
    write_sequence.start(env.agnt.sqr);
    phase.drop_objection(this,get_type_name());
  endtask
endclass
