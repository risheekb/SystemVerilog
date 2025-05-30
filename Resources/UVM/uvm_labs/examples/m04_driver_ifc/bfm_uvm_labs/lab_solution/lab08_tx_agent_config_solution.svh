/***********************************************************************
 * Example UVM Testbench to verify a simple Instruction Register Design.
 *
 * Class: lab_tx_agent_config
 *
 * Defines a agent-level configuration object within the UVM testbench.
 * The class encapsulates various settings affecting other components
 * in the testbench.
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
 *
 * CBS 191212 - Switched to drv_bfm, mon_bfm
 **********************************************************************/

`ifndef lab_tx_agent_config_exists
`define lab_tx_agent_config_exists


class lab_tx_agent_config extends uvm_object;

  // Register this class name in the factory
  `uvm_object_utils(lab_tx_agent_config)
  function new(string name="lab_tx_agent_config");
    super.new(name);
  endfunction: new

  //
  // LAB 8 ASSIGNMENT:  Add the following variables that tests can use to
  // configure an agent
  // 1) A variable of type uvm_active_passive_enum called active
  //    to control whether this agent is active or passive.  Set the
  //    default value to UVM_PASSIVE).
  // 2) An int variable called monitor_verbosity to set the
  //    message verbosity of the monitor.
  //    Set the default verbosity to UVM_FULL.
  // 3) A bit variable enable_coverage to enable functional coverage, default 1
  // 4) An int variable nitems to hold the number of transactions, default 1
  // 5) A handle called sqr for a uvm_sequencer #(lab_tx_in) (for Lab 9)
  // 6) A virtual interface called drv_bfm for the tx_driver_bfm interface
  //    and mon_bfm for the tx_monitor_bfm
  //
  //ADD YOUR CODE HERE...
//BEGIN SOLUTION
  uvm_active_passive_enum    active            = UVM_PASSIVE;
  int                        monitor_verbosity = UVM_FULL;
  bit                        enable_coverage   = 1;
  int                        nitems            = 1;
  uvm_sequencer #(lab_tx_in) sqr;
  virtual tx_driver_bfm      drv_bfm;
  virtual tx_monitor_bfm     mon_bfm;
//END SOLUTION

endclass: lab_tx_agent_config
`endif
