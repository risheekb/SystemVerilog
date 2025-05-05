class tx_agent extends uvm_agent;
  `uvm_component_utils(tx_agent)
  function new(string name,uvm_component parent);
    super.new(name,parent);
  endfunction 
  tx_driver drv;
  uvm_sequencer #(tx_item) sqr;

  virtual function void build_phase(uvm_phase phase);
    drv = tx_driver::type_id::create("drv",this);
    sqr = new("sqr",this);
  endfunction

  virtual function void connect_phase(uvm_phase phase);
    drv.seq_item_port.connect(sqr.seq_item_export);
  endfunction 

endclass
