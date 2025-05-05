class tx_agent_config extends uvm_object;
  `uvm_object_utils(tx_agent_config)
  function new(string name="tx_agent_config");
    super.new(name);
  endfunction
  virtual tx_ifc vif;
endclass
