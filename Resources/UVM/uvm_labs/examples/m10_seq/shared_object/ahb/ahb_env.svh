// USB environment for scoreboard plus predictor and evaluator

class ahb_env extends uvm_env;
  `uvm_component_utils(ahb_env);
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  ahb_predictor predict;
  ahb_scoreboard scb;
  ahb_agent agt;
//  ahb_config ahb_cfg; // Not needed here

  virtual function void build_phase(uvm_phase phase);
    // if (! uvm_config_db#(ahb_config)::get(this, "", "ahb_cfg", ahb_cfg))
    //   `uvm_fatal("NO", "AHB_CFG")

    predict = ahb_predictor::type_id::create("predict", this);
    scb = ahb_scoreboard::type_id::create("scb", this);
    agt = ahb_agent::type_id::create("agt", this);
  endfunction

  virtual function void connect_phase(uvm_phase phase);
    agt.dut_in_port.connect(predict.analysis_export);
    predict.expected_port.connect(scb.dut_in_export);
    agt.dut_out_port.connect(scb.dut_out_export);
  endfunction
endclass : ahb_env
