class tx_agent extends uvm_agent;

`uvm_component_utils(tx_agent)
  function new(string name,uvm_component parent);
    super.new(name,parent);
  endfunction

  tx_driver drv;
  uvm_sequencer#(tx_item) sqr;
  tx_monitor mon;
  tx_agent_config agt_cfg;

  virtual function void build_phase(uvm_phase phase);
    `uvm_info("BUILD",$sformatf("In %m"),UVM_FULL);
    if (!uvm_config_db #(tx_agent_config)::get(this, "", "agt_cfg", agt_cfg))
      `uvm_fatal("NO_ENV_CFG", "No env_config passed into agent");


    drv = tx_driver::type_id::create("drv",this);
    sqr = uvm_sequencer#(tx_item)::type_id::create("sqr",this);
    mon = tx_monitor::type_id::create("mon",this);
  endfunction

  virtual function void connect_phase(uvm_phase phase);
    drv.seq_item_port.connect(sqr.seq_item_export);
  endfunction

endclass
