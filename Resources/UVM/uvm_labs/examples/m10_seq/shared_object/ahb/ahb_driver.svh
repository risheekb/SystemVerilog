/***********************************************************************
 * UVM driver class
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

class ahb_driver extends uvm_driver #(ahb_txn);
  `uvm_component_utils(ahb_driver)
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  ahb_config ahb_cfg;
  virtual ahb_ifc vif;

  virtual function void build_phase(uvm_phase phase);
    if (!uvm_config_db#(ahb_config)::get(this, "", "ahb_cfg", ahb_cfg))
      `uvm_fatal("GET", "FAILED")
    vif = ahb_cfg.vif;
  endfunction

  virtual task run_phase(uvm_phase phase);
    forever begin
      seq_item_port.get_next_item(req);  // req declared in uvm_driver
      `uvm_info("DRIVER", req.sprint(), UVM_FULL)
      vif.send(req);
      $cast(req.status, $urandom_range(1));
      `uvm_info("SEND", $sformatf("Random req status = %s (0x%0x)", req.status.name(), req.status), UVM_LOW)
      seq_item_port.item_done();
    end
  endtask

endclass : ahb_driver
