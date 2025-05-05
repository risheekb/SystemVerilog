class tx_monitor extends uvm_monitor;

  `uvm_component_utils(tx_monitor)
  function new(string name,uvm_component parent);
    super.new(name,parent);
  endfunction

  virtual tx_ifc vif;
  tx_agent_config agt_cfg;

  tx_item tx_last;

  virtual function void build_phase(uvm_phase phase);
   if(!uvm_config_db #(tx_agent_config)::get(this,"","agt_cfg",agt_cfg))
     `uvm_fatal("NOCONFIG","No config found in monitor")
    vif = agt_cfg.vif;
  endfunction

  virtual task run_phase(uvm_phase phase);
    fork
      get_inputs();
      get_outputs();
    join
  endtask
  
  virtual task get_inputs();
    forever begin
      tx_item tx;
      vif.get_an_input(tx);
      `uvm_info("MON_IN",$sformatf("drove %h",tx.data),UVM_MEDIUM)
      tx_last = tx;
    end
  endtask

  virtual task get_outputs();
    forever begin
      tx_item tx;
      vif.get_an_output(tx);
      `uvm_info("MON_OUT",$sformatf("sampled %h",tx.data),UVM_MEDIUM)

      if(tx_last == null)
        `uvm_error("TXNULL","Tried to compare but last handle was null")
      else  begin
        if (tx_last.data !== tx.data) begin
          `uvm_error("MISCOMP",$sformatf("actual data = %h , expected data = %h",tx.data,tx_last.data))
        end
      end
      end
  endtask
endclass
