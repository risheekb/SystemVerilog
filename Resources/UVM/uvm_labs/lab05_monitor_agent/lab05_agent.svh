/***********************************************************************
 * UVM Testbench to verify an Instruction Register array design.
 *
 * Class: lab_agent
 *
 * Contains an agent component class within the UVM testbench.
 * Bundles together a Sequencer, Driver, Monitor and Coverage
 * as a reusable Verification Component (referred to as a VC or UVC).
 ***********************************************************************
 * Copyright 2016-2023 Siemens
 * All Rights Reserved Worldwide
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *       http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or
 * implied.  See the License for the specific language governing
 * permissions and limitations under the License.
 **********************************************************************/

`ifndef lab_agent_exists
`define lab_agent_exists


// ====================================================================
// ====================================================================
// *** NOTE: This component will be modified by multiple labs:
// - LAB 5 (2 places) -- add and connect a monitor, driver and sequencer
// - LAB 6 (2 places) -- add and connect an agent-level coverage collector
// - LAB 9 (1 place)  -- set the agent's configuration controls
//
// The assignment comments specify what to do in each of these labs.
// ====================================================================
// ====================================================================

class lab_agent extends uvm_agent;

  `uvm_component_utils(lab_agent)  // Register this class in the factory
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  // The agent's analysis ports connected from monitor
  uvm_analysis_port #(lab_tx_in)  dut_in_tx_port;
  uvm_analysis_port #(lab_tx_out) dut_out_tx_port;

  uvm_sequencer#(lab_tx_in) sqr;
  lab_driver                drv;
  lab_monitor               mon;
  lab_coverage_collector    cov;
  lab_tx_agent_config       tx_cfg;

  virtual function void build_phase(uvm_phase phase);
    dut_in_tx_port  = new("dut_in_tx_port",  this);
    dut_out_tx_port = new("dut_out_tx_port", this);

    if (!uvm_config_db #(lab_tx_agent_config)::get(this, "", "tx_cfg", tx_cfg))
      `uvm_fatal(get_type_name(), "Unable to find tx_cfg in uvm_config_db")

    //
    // LAB 5 ASSIGNMENT, PART 1:
    // Construct the monitor, driver and sequencer by:
    // 1) Unconditionally creating an instance of a monitor. The handle mon
    //    is defined above.
    // 2) Conditionally creating instances of a driver and sequencer
    //    if the agent configuration property tx_cfg.active == UVM_ACTIVE
    //    The handles drv and sqr are defined above
    //
    //ADD YOUR LAB 5 CODE HERE...
    mon = lab_monitor::type_id::create("mon",this);
    if(tx_cfg.active == UVM_ACTIVE)begin
      drv = lab_driver::type_id::create("drv",this);
      sqr = new("seq",this);
    end

    //
    // LAB 9 ASSIGNMENT, PART 1:
    // 1. Copy the sqr handle into the tx_cfg.sqr handle
    //
    //ADD YOUR LAB 9 CODE HERE...


    //
    // LAB 6 ASSIGNMENT, PART 1:
    // Conditionally create an instance of a coverage collector if the
    // agent configuration property tx_cfg.enable_coverage is true.
    // The handle cov is defined above.
    //
    //ADD YOUR LAB 6 CODE HERE...
    if(tx_cfg.enable_coverage)
      cov = lab_coverage_collector::type_id::create("cov",this);


  endfunction: build_phase



  virtual function void connect_phase(uvm_phase phase);
    // Connect the agent's analysis ports to the monitor's ports
    mon.dut_in_tx_port.connect(dut_in_tx_port);
    mon.dut_out_tx_port.connect(dut_out_tx_port);

    //
    // LAB 5 ASSIGNMENT, PART 2:

    // Connect the driver and sequencer by conditionally connecting
    // the driver's port to the sequencer's export if the agent
    // configuration property: tx_cfg.active == UVM_ACTIVE
    // Driver is the initiator, sequencer is the target
    //
    //ADD YOUR LAB 5 CODE HERE...
    if(tx_cfg.active == UVM_ACTIVE)begin
      drv.seq_item_port.connect(sqr.seq_item_export);
    end


    //
    // LAB 6 ASSIGNMENT, PART 2:
    // If the agent configuration property tx_cfg.enable_coverage property is true,
    // connect the monitor's DUT input analysis port to the coverage collector's export
    // The monitor is the initiator, the coverage collector is the target
    //
    //ADD YOUR LAB 6 CODE HERE...
    if(tx_cfg.enable_coverage)
      mon.dut_in_tx_port.connect(cov.analysis_export);

  endfunction: connect_phase

endclass: lab_agent
`endif
