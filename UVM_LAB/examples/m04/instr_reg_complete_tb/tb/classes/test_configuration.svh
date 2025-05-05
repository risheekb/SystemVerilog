class test_configuration extends uvm_test;
  `uvm_component_utils(test_configuration)

  function new(string name,uvm_component parent);
    super.new(name,parent);
  endfunction
  env_config env_cfg;
  agent_config agt_cfg;
  tb_env env;

  virtual function void build_phase(uvm_phase phase);
    env_cfg = env_config::type_id::create("env_cfg");
    agt_cfg = agent_config::type_id::create("agt_cfg");
    env_cfg.agt_cfg = agt_cfg;

    if(!uvm_config_db #(virtual driver_bfm)::get(this,"","d_vif",agt_cfg.d_vif))
      `uvm_fatal(get_type_name(),"Virtual interface not found for driver")
    if(!uvm_config_db #(virtual monitor_bfm)::get(this,"","m_vif",agt_cfg.m_vif))
      `uvm_fatal(get_type_name(),"Virtual interface not found for monitor")
    if(!uvm_config_db #(uvm_bitstream_t)::get(this,"","nitems",agt_cfg.nitems))
      `uvm_fatal(get_type_name(),"nitmes parameter not found in the database")

    uvm_config_db #(env_config)::set(this,"env","env_cfg",env_cfg);

    env = tb_env::type_id::create("env",this);

  endfunction

  virtual function void end_of_elaboration_phase(uvm_phase phase);
    uvm_factory factory;
    factory = uvm_factory::get();

    `uvm_info("PRINT","factory print (1)",UVM_LOW)
    factory.print(1);
    `uvm_info("PRINT","uvm_top.print_topology()",UVM_LOW)
    uvm_top.print_topology();
  endfunction

  virtual task run_phase(uvm_phase phase);
    seq_writeN sequence_writeN;
    phase.raise_objection(this,get_type_name());
    phase.phase_done.set_drain_time(this,10);
    sequence_writeN = seq_writeN::type_id::create("sequence_writeN");
    sequence_writeN.init_start(env.agnt.sqr,agt_cfg);
    phase.drop_objection(this,get_type_name());
  endtask

endclass
