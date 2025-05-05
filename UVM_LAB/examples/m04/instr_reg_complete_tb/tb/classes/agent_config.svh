class agent_config extends uvm_object;
  `uvm_object_utils(agent_config)

  function new(string name="agent_config");
    super.new(name);
  endfunction

  uvm_active_passive_enum active = UVM_PASSIVE; 
  int nitems = 100;
  virtual driver_bfm d_vif;
  virtual monitor_bfm m_vif;
endclass
