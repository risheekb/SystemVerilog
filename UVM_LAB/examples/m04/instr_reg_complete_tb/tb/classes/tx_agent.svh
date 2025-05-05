class tx_agent extends uvm_agent;
  `uvm_component_utils(tx_agent)

  function new(string name,uvm_component parent);
    super.new(name,parent);
  endfunction

  tx_driver drv;
  tx_monitor mon;
  uvm_sequencer #(tx_in) sqr;
  coverage_collector cov;
  agent_config agt_cfg;

  uvm_analysis_port #(tx_in) dut_in_port;
  uvm_analysis_port #(tx_out) dut_out_port;


  virtual function void build_phase(uvm_phase phase);
    agt_cfg = agent_config::type_id::create("agt_cfg");
    

    //create the analysis ports 
    dut_in_port = new("dut_in_port",this);
    dut_out_port = new("dut_out_port",this);

    if(!uvm_config_db #(agent_config)::get(this,"","agt_cfg",agt_cfg))
      `uvm_fatal(get_type_name(),"agent config is not found!!")
    drv = tx_driver::type_id::create("drv",this);
    mon = tx_monitor::type_id::create("mon",this);
    sqr = uvm_sequencer #(tx_in)::type_id::create("sqr",this);
    cov = coverage_collector::type_id::create("cov",this);
  endfunction

  virtual function void connect_phase(uvm_phase phase);
    drv.seq_item_port.connect(sqr.seq_item_export);
    mon.dut_in_port.connect(dut_in_port);
    mon.dut_out_port.connect(dut_out_port);



    //connecting the coverage from the monitor
    mon.dut_in_port.connect(cov.analysis_export); 
  endfunction
endclass
