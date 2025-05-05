/***********************************************************************
 * UVM Testbench to verify an Instruction Register array design.
 *
 * Class: lab_driver
 *
 * Defines a driver component within the UVM testbench.
 * Requests transactions from a sequence and drives the DUT ports
 * with those transaction values via a virtual interface to the DUT.
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

`ifndef lab_driver_exists
`define lab_driver_exists


class lab_driver extends uvm_driver #(lab_tx_in);

  //
  // LAB 4 ASSIGNMENT, PART 1:
  // 1) Register this class in the factory with the UVM component utils macro
  // 2) Define the class constructor method new()
  //
//ADD YOUR CODE HERE...
  `uvm_component_utils(lab_driver)
  function new(string name,uvm_component parent);
    super.new(name,parent);
  endfunction


  lab_tx_agent_config tx_cfg;
  virtual tx_ifc vif;  // virtual interface pointer


  virtual function void build_phase(uvm_phase phase);
    // Fetch the agent configuration
    // You will learn about the uvm_config_db in Lab 8
    if (!uvm_config_db #(lab_tx_agent_config)::get(this, "", "tx_cfg", tx_cfg))
      `uvm_fatal(get_type_name(), "Failed to get tx_cfg from uvm_config_db")
    vif = tx_cfg.vif;
  endfunction


  //
  // LAB 4 ASSIGNMENT, PART 2:
  // Write the virtual task run_phase(uvm_phase phase) that:
  // 1) Contains a forever loop that:
  //    - Declares a lab_tx_in sequence_item handle called tx
  //    - Request a sequence_item by calling get_next_item(tx) with the seq_item_port handle
  //    - Calls vif.send(tx) to drive the sequence_item values
  //    - Release the sequence item by calling item_done() with the seq_item_port handle
  //
//ADD YOUR CODE HERE...

  virtual task run_phase(uvm_phase phase);
    forever begin
      lab_tx_in tx;

      seq_item_port.get_next_item(tx);
      vif.send(tx);
      seq_item_port.item_done();
    end
  endtask: run_phase

endclass: lab_driver
`endif
