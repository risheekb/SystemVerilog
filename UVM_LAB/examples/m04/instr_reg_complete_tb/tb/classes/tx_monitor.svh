class tx_monitor extends uvm_monitor;
  `uvm_component_utils(tx_monitor)

  function new(string name,uvm_component parent);
    super.new(name,parent);
  endfunction

  uvm_analysis_port #(tx_in) dut_in_port;
  uvm_analysis_port #(tx_out) dut_out_port;

  agent_config agt_cfg;
  virtual monitor_bfm vif;

  virtual function void build_phase(uvm_phase phase);
    dut_in_port = new("dut_in_tx_port",this);
    dut_out_port = new("dut_out_tx_port",this);

    if(!uvm_config_db #(agent_config)::get(this,"","agt_cfg",agt_cfg))
      `uvm_fatal(get_type_name(),"agent config not found")

    vif = agt_cfg.m_vif;
  endfunction

  virtual task run_phase(uvm_phase phase);
    fork
      get_input();
      get_output();
    join
  endtask

  virtual task get_input();
    forever begin
      tx_in tx;

      tx= tx_in::type_id::create("TX_IN");
      vif.get_inputs(.reset_n(tx.reset_n),
        .load_en(tx.load_en),
        .write_pointer(tx.write_pointer),
        .read_pointer(tx.read_pointer),
        .operand_a(tx.operand_a),
        .operand_b(tx.operand_b),
        .opcode(tx.opcode)
      );

      `uvm_info("TX_IN",tx.sprint(),UVM_MEDIUM)
      dut_in_port.write(tx);

    end
  endtask

  virtual task get_output();
    forever begin
      tx_out tx;
      tx = tx_out::type_id::create("TX_OUT");
      vif.get_outputs(
        .reset_n(tx.reset_n),
        .read_pointer(tx.read_pointer),
        .instruction(tx.instruction)
      );
      `uvm_info("TX_OUT",tx.sprint(),UVM_MEDIUM)
      dut_out_port.write(tx);
    end
  endtask

  
endclass
