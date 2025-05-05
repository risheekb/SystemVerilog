class tb_env extends uvm_env;

  `uvm_component_utils(tb_env)
  function new(string name,uvm_component parent);
    super.new(name,parent);
  endfunction

  env_config env_cfg;

  tx_agent agnt;
  tx_scoreboard scbd;
  virtual function void build_phase(uvm_phase phase);
    env_cfg = env_config::type_id::create("env_cfg");
    if(!uvm_config_db #(env_config)::get(this,"","env_cfg",env_cfg))
      `uvm_fatal(get_type_name(),"No evn_cfg entry found in db !!")
    uvm_config_db #(agent_config)::set(this,"*","agt_cfg",env_cfg.agt_cfg);

    agnt = tx_agent::type_id::create("agnt",this);
    scbd = tx_scoreboard::type_id::create("scbd",this);
  endfunction

  virtual function void connect_phase(uvm_phase phase);
    agnt.dut_in_port.connect(scbd.dut_in_export);
    agnt.dut_out_port.connect(scbd.dut_out_export);

  endfunction


endclass
