/***********************************************************************
 * Example of advanced UVM messaging handling, from Supp. Information
 * Even disabling UVM_EXIT for fatal, they still exit
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

module report_action;
  import uvm_pkg::*;
`include "uvm_macros.svh"

class tx_driver extends uvm_driver;
  `uvm_component_utils(tx_driver);
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  virtual task run_phase(uvm_phase phase);
    `uvm_info("DHERE", $sformatf("In %m"), UVM_NONE);
    `uvm_info("DHI", "Info World!", UVM_LOW);
    `uvm_warning("DHW", "Warning World!");
    `uvm_error("DHE", "Error World!");
    //      `uvm_fatal("AHF", "Fatal World!");
  endtask
endclass


class tx_agent extends uvm_agent;
  `uvm_component_utils(tx_agent);
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  tx_driver drv;
  virtual function void build_phase(uvm_phase phase);
    drv = tx_driver::type_id::create("drv", this);
  endfunction

  virtual task run_phase(uvm_phase phase);
    `uvm_info("AHERE", $sformatf("In %m"), UVM_NONE);
    `uvm_info("AHI", "Info World!", UVM_LOW);
    `uvm_warning("AHW", "Warning World!");
    `uvm_error("AHE", "Error World!");
    //      `uvm_fatal("AHF", "Fatal World!");
  endtask
endclass


class tx_env extends uvm_env;
  `uvm_component_utils(tx_env);
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction


  UVM_FILE log_file;

  virtual function void build_phase(uvm_phase phase);
    tx_agent agent = tx_agent::type_id::create("agent", this);
    `uvm_info("HERE", $sformatf("In %m"), UVM_NONE);
  endfunction // build_phase

  virtual function void end_of_elaboration_phase(uvm_phase phase);
    log_file = $fopen("test.log");
    set_report_default_file_hier(log_file);
    set_report_severity_action_hier(UVM_FATAL,   UVM_LOG | UVM_DISPLAY | UVM_EXIT);
    set_report_severity_action_hier(UVM_ERROR,   UVM_LOG | UVM_DISPLAY | UVM_COUNT);
    set_report_severity_action_hier(UVM_WARNING, UVM_LOG | UVM_DISPLAY);
    set_report_severity_action_hier(UVM_INFO,    UVM_LOG | UVM_DISPLAY);

    `uvm_info("HERE", $sformatf("In %m"), UVM_NONE);
  endfunction // end_of_elaboration_phase

  virtual function void start_of_simulation_phase(uvm_phase phase);
    `uvm_info("HERE", $sformatf("In %m"), UVM_NONE);
  endfunction

  virtual task run_phase(uvm_phase phase);
    `uvm_info("EHERE", $sformatf("In %m"), UVM_NONE);
    `uvm_info("EHI", "Info World!", UVM_LOW);
    `uvm_warning("EHW", "Warning World!");
    `uvm_error("EHE", "Error World!");
    //      `uvm_fatal("EHF", "Fatal World!");
  endtask

  virtual function void report_phase(uvm_phase phase);
    uvm_report_server srv = uvm_report_server::get_server();
    srv.summarize(log_file);
    $fclose(log_file);
  endfunction : report_phase
endclass : tx_env


class report_action_test extends uvm_test;
  `uvm_component_utils(report_action_test);
  function new(string name, uvm_component parent);
    super.new(name, parent);
    $display("In %m");
  endfunction

  tx_env env;

  virtual function void build_phase(uvm_phase phase);
    `uvm_info("HERE", $sformatf("In %m"), UVM_NONE);
    env = tx_env::type_id::create("env", this);
  endfunction // build_phase
endclass

  initial run_test();

endmodule : report_action
