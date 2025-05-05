class tx_driver extends uvm_driver #(tx_item);
  
  `uvm_component_utils(tx_driver)

  function new(string name,uvm_component parent);
    super.new(name,parent);
  endfunction

  tx_agent_config agt_cfg;
  virtual tx_ifc vif;

  virtual function void build_phase(uvm_phase phase);
    if (!uvm_config_db #(tx_agent_config)::get(this, "", "agt_cfg", agt_cfg))
      `uvm_fatal("NO_ENV_CFG", "No env_config passed into agent");
    vif = agt_cfg.vif;
  endfunction


  virtual task run_phase(uvm_phase phase);
    `uvm_info("RUN",$sformatf("In %m"),UVM_FULL)
    forever begin
      tx_item tx;
      seq_item_port.get_next_item(tx);
      send(tx);
      seq_item_port.item_done();
    end
  endtask

    virtual task send(tx_item tx);
    `uvm_info("SEND", $sformatf("data=%3d", tx.data), UVM_LOW)

    vif.send(tx);
    endtask
endclass
