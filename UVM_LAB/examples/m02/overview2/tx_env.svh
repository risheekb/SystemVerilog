class tx_env extends uvm_env;
 `uvm_component_utils(tx_env)

  tx_agent agt;
  tx_env_config env_cfg;

  function new(string name,uvm_component parent);
    super.new(name,parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    if(!uvm_config_db #(tx_env_config)::get(this,"","env_cfg",env_cfg))
      `uvm_fatal("NO_ENV_CFG","No Environment Configuration was found")
    uvm_config_db #(tx_agent_config)::set(this,"*","agt_cfg",env_cfg.agt_cfg);
    agt = tx_agent::type_id::create("agt",this);
  endfunction
endclass
