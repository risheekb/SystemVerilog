class env_config extends uvm_object;

  `uvm_object_utils(env_config)
  function new(string name = "env_config");
    super.new(name);
  endfunction

  agent_config agt_cfg;
  bit enable_scoreboard=1;
endclass
