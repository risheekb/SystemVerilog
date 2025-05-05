/***********************************************************************
 * UVM monitor class
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

class ahb_monitor extends uvm_monitor;
  `uvm_component_utils(ahb_monitor)
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  ahb_config ahb_cfg;
  uvm_analysis_port #(ahb_txn) dut_in_tx_port;
  uvm_analysis_port #(ahb_txn) dut_out_tx_port;

  virtual function void build_phase(uvm_phase phase);
    if (!uvm_config_db#(ahb_config)::get(this, "", "ahb_cfg", ahb_cfg))
      `uvm_fatal("GET", "FAILED")
    dut_in_tx_port  = new("dut_in_tx_port", this);
    dut_out_tx_port = new("dut_out_tx_port", this);
  endfunction

  virtual task run_phase(uvm_phase phase);
    fork
      get_inputs();
      get_outputs();
    join
  endtask

  virtual task get_inputs();
    forever begin
      ahb_txn tin;

      tin = ahb_txn::type_id::create("tin");
      ahb_cfg.vif.get_an_input(tin);
      if (tin == null)  `uvm_fatal("NULL", "HANDLE")
      `uvm_info("TIN", $sformatf("Received input %s", tin.sprint()), UVM_FULL)
      dut_in_tx_port.write(tin);
    end
  endtask

  virtual task get_outputs();
    forever begin
      ahb_txn tout;

      tout = ahb_txn::type_id::create("tout");
      ahb_cfg.vif.get_an_output(tout);
      if (tout == null)  `uvm_fatal("NULL", "HANDLE")
      `uvm_info("TOUT", $sformatf("Received output %s", tout.sprint()), UVM_FULL)
      dut_out_tx_port.write(tout);
    end
  endtask
endclass : ahb_monitor
