class tx_monitor extends uvm_monitor;
  `uvm_component_utils(tx_monitor)
  function new(string name,uvm_component parent);
    super.new(name,parent);
  endfunction 
  
  tx_agent_config agt_cfg;
  virtual tx_ifc vif;

  tx_item tr_last;

  virtual function void build_phase(uvm_phase phase);
    if (!uvm_config_db #(tx_agent_config)::get(this, "", "agt_cfg", agt_cfg))
      `uvm_fatal("NO_ENV_CFG", "No env_config passed into agent");
    vif = agt_cfg.vif;
  endfunction


  virtual task run_phase(uvm_phase phase);
    `uvm_info("RUN",$sformatf("In %m"),UVM_FULL)
    fork
      get_inputs();
      get_outputs();
    join
  endtask
  virtual task get_inputs();
    forever begin
      tx_item tr;

      vif.get_an_input(tr);
      `uvm_info("MON_IN", $sformatf("Drove %h", tr.data), UVM_MEDIUM)
      tr_last = tr;
    end
  endtask

  virtual task get_outputs();
    forever begin
      tx_item tx;
      vif.get_an_output(tx);
      `uvm_info("MON_OUT", $sformatf("Sampled %h", tx.data), UVM_MEDIUM);

      // Mini scoreboard
      if (tr_last == null) begin
        `uvm_error("NULL_LAST", "Tried to compare but last transacton handle is null")
      end
      else begin
	if (tr_last.data !== tx.data)
          `uvm_error("MISCOMP", $sformatf("Actual data (%h) != expected data (%h)",
	                                  tx.data, tr_last.data))
      end
    end
  endtask
endclass
