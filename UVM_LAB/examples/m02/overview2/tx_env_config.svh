class tx_env_config extends uvm_object;
  `uvm_object_utils(tx_env_config)
  function new(string name="tx_env_config");
    super.new(name);
  endfunction
  tx_agent_config agt_cfg;
endclass
