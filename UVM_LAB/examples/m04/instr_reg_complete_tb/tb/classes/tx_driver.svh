class tx_driver extends uvm_driver #(tx_in);
  `uvm_component_utils(tx_driver)

  function new(string name,uvm_component parent);
    super.new(name,parent);
  endfunction

  virtual driver_bfm vif;
  agent_config agt_cfg;

  virtual function void build_phase(uvm_phase phase);
    if(!uvm_config_db #(agent_config)::get(this,"","agt_cfg",agt_cfg))
      `uvm_fatal(get_type_name(), "No virtual interface 'drv_bfm' found in uvm_config_db")
    vif = agt_cfg.d_vif;
  endfunction

  virtual task run_phase(uvm_phase phase);

    forever begin
      tx_in tx;
      seq_item_port.get_next_item(tx);
      vif.send(.reset_n(tx.reset_n),
        .load_en(tx.load_en),
        .write_pointer(tx.write_pointer),
        .read_pointer(tx.read_pointer),
        .operand_a(tx.operand_a),
        .operand_b(tx.operand_b),
        .opcode(tx.opcode));
      seq_item_port.item_done();
    end
  endtask
endclass
