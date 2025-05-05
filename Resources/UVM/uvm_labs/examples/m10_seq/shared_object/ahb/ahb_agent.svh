/***********************************************************************
 * Agent class
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

class ahb_agent extends uvm_agent;
  `uvm_component_utils(ahb_agent)
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  ahb_driver drv;
  ahb_monitor mon;
  ahb_config ahb_cfg;
  uvm_sequencer #(ahb_txn) sqr;
  uvm_analysis_port #(ahb_txn) dut_in_port;
  uvm_analysis_port #(ahb_txn) dut_out_port;

  virtual function void build_phase(uvm_phase phase);
    if (! uvm_config_db#(ahb_config)::get(this, "", "ahb_cfg", ahb_cfg))
      `uvm_fatal("NO", "AHB_CFG")

    mon = ahb_monitor::type_id::create("mon", this);
    if (ahb_cfg.active == UVM_ACTIVE) begin
      drv = ahb_driver::type_id::create("drv", this);
      sqr = new("sqr", this);
      ahb_cfg.sqr = sqr;
    end
    dut_in_port = new("dut_in_port", this);
    dut_out_port = new("dut_out_port", this);
  endfunction

  virtual function void connect_phase(uvm_phase phase);
    mon.dut_in_tx_port.connect(dut_in_port);
    mon.dut_out_tx_port.connect(dut_out_port);
    if (ahb_cfg.active == UVM_ACTIVE)
      drv.seq_item_port.connect(sqr.seq_item_export);
  endfunction
endclass : ahb_agent
