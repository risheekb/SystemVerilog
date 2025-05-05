class tx_driver extends uvm_driver #(tx_item);

  `uvm_component_utils(tx_driver)
  function new(string name,uvm_component parent);
    super.new(name,parent);
  endfunction

  virtual task run_phase(uvm_phase phase);

    `uvm_info("HERE",$sformatf("In, %m"),UVM_FULL)
    forever begin
      tx_item tx;
      seq_item_port.get_next_item(tx);
      send(tx);
      seq_item_port.item_done();
    end
  endtask


  virtual task send(tx_item tx);
    `uvm_info(get_type_name,$sformatf("Driven data = %d",tx.pay.data),UVM_MEDIUM);
  endtask
endclass
