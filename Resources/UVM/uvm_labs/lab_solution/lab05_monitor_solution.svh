/***********************************************************************
 * UVM Testbench to verify an Instruction Register array design.
 *
 * Class: lab_monitor
 *
 * Contains a monitor component class within the UVM testbench.
 * 1) Captures the DUT inputs, packages them as a transaction, and
 *    broadcasts the transaction to other verification components.
 * 2) Captures the DUT outputs, encapsulates them as a transaction,
 *    and broadcasts the transaction to other verification components.
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

`ifndef lab_monitor_exists
`define lab_monitor_exists


class lab_monitor extends uvm_monitor;

  `uvm_component_utils(lab_monitor)  // Register this class name in the factory
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  lab_tx_agent_config tx_cfg;
  virtual tx_ifc vif;  // virtual interface

  //
  // LAB 5 ASSIGNMENT, STEP 1:
  // Declare two analysis ports: dut_in_tx_port, specialized for lab_tx_in,
  // and dut_out_tx_port, specialized for lab_tx_out transaction types
  // NOTE: Use these analysis port names to be compatible with rest of the testbench
  //
  //ADD YOUR CODE HERE...
//BEGIN SOLUTION
  uvm_analysis_port #(lab_tx_in)  dut_in_tx_port;  // TLM analysis port for DUT inputs
  uvm_analysis_port #(lab_tx_out) dut_out_tx_port; // TLM analysis port for DUT outputs
//END SOLUTION



  virtual function void build_phase(uvm_phase phase);
  //
  // LAB 5 ASSIGNMENT, STEP 2:
  // Construct the two analysis ports declared above
  //
  //ADD YOUR CODE HERE...
//BEGIN SOLUTION
    dut_in_tx_port  = new("dut_in_tx_port",  this); // construct the DUT input analysis port
    dut_out_tx_port = new("dut_out_tx_port", this); // construct the DUT output analysis port
//END SOLUTION



    // Get the virtual interface from the agent configuration (set in Lab 8)
    if (!uvm_config_db #(lab_tx_agent_config)::get(this,"","tx_cfg",tx_cfg))
      `uvm_fatal(get_type_name(), "Failed to get tx_cfg from uvm_config_db")
    vif = tx_cfg.vif;
  endfunction: build_phase


  //
  // LAB 5 ASSIGNMENT, STEP 3:
  // 1) Add a run_phase() method that forks two methods, get_inputs() and get_outputs()
  //    Follow the code examples in the course slides
  // 2) The get_inputs() virtual method:
  //    a) Has a forever loop
  //    b) Declares a lab_tx_in handle called tx
  //    c) Creates a lab_tx_in object with the factory.
  //    d) Calls vif.get_an_input(tx) task to collect the DUT input values
  //       in a lab_tx_in transaction object.
  //    e) Prints an informational message, ID="TX_IN", the transaction values
  //       using sprint() method, and the UVM_FULL verbosity
  //    f) Broadcasts the transaction on the monitor analysis port for
  //       input transactions.
  //
  // 3) The get_outputs() virtual method:
  //    a) Has a forever loop
  //    b) Declares a lab_tx_out handle called tx
  //    c) Creates a lab_tx_out object with the factory.
  //    d) Calls vif.get_an_output(tx) task to collect the DUT output values
  //       in a lab_tx_out transaction object.
  //    e) Prints an informational message, ID="TX_OUT", the transaction values
  //       using sprint() method, and UVM_FULL verbosity
  //    f) Broadcasts the transaction on the monitor analysis port for
  //       output transactions.
  //
  //ADD YOUR CODE HERE...
//BEGIN SOLUTION
  virtual task run_phase(uvm_phase phase);
    fork
      get_inputs();
      get_outputs();
    join
  endtask

  virtual task get_inputs();
    // Monitor DUT inputs -- synchronous to posedge of DUT clock
    forever begin
      lab_tx_in tx;

      // Create a new tx_write object for this cycle
      tx = lab_tx_in::type_id::create("tx");
      // Capture DUT input values
       vif.get_an_input(tx);
      // Print the DUT output transaction at a debug level (only prints
      // when debugging the monitor)
      `uvm_info("TX_IN", tx.sprint(), UVM_FULL)
      // Broadcast input transaction on the dut_inputs analysis port
      dut_in_tx_port.write(tx);
    end
  endtask


  virtual task get_outputs();
    // Monitor DUT outputs
    forever begin
      lab_tx_out tx;

      // Create a new tx_read object for this cycle
      tx = lab_tx_out::type_id::create("tx");
      // Capture DUT outputs at this time
      vif.get_an_output(tx);
      // Print the DUT output transaction at a debug level (only prints
      // when debugging the monitor)
      `uvm_info("TX_OUT", tx.sprint(), UVM_FULL)
      // Broadcast the transaction on the dut_outputs analysis port
      dut_out_tx_port.write(tx);
    end
  endtask
//END SOLUTION


  virtual function void end_of_elaboration_phase(uvm_phase phase);
    //
    // LAB 5 ASSIGNMENT, STEP 4 - HOLD OFF ON THIS STEP UNTIL REQUESTED:
    // The labs always need debugging, so the agent configuration sets the
    // monitor to higher verbosity than the rest of the simulation.
    // Set the message verbosity level for this agent and all levels below
    //
    // 1) Call the set_report_verbosity_level() function. Pass in the
    // monitor_verbosity value from the agent config object, tx_cfg
    //
    //ADD YOUR LAB 5 CODE HERE...
//BEGIN SOLUTION
    set_report_verbosity_level(tx_cfg.monitor_verbosity);
//END SOLUTION


  endfunction


endclass: lab_monitor
`endif
