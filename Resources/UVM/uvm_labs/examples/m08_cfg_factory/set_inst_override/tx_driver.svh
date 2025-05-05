/***********************************************************************
 * Driver for UVM override example
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

class tx_driver extends uvm_driver #(tx_item);
  `uvm_component_utils(tx_driver);
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  tx_config tx_cfg;
  virtual tx_interface vif;


  virtual function void build_phase(uvm_phase phase);
    if (!uvm_config_db #(tx_config)::get(this, "", "tx_cfg", tx_cfg))
      `uvm_fatal("NOCFG", "No tx_cfg in DB");
    vif = tx_cfg.vif;
  endfunction


  virtual task run_phase(uvm_phase phase);
    forever begin
      tx_item tr;

      seq_item_port.get_next_item(tr);
      send(tr);
      seq_item_port.item_done();
    end
  endtask : run_phase


  virtual task send(tx_item tr);
    `uvm_info("SEND", $sformatf("Driving %0x", tr.dst), UVM_HIGH)
    vif.send(tr);
    `uvm_info("SEND", $sformatf("Drove %0x", tr.dst), UVM_HIGH)
  endtask

endclass
