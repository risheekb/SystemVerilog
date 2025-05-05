/***********************************************************************
 * Driver for TX UVM example
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

  virtual tx_ifc tx_if;

  virtual function void build_phase(uvm_phase phase);
    if (! uvm_config_db#(virtual tx_ifc)::get(this, "", "tx_if", tx_if))
      `uvm_fatal("IFC", "virtual tx_ifc tx_if not found in uvm_config_db")
  endfunction

  virtual task run_phase(uvm_phase phase);
    forever begin
      tx_item tx;

      seq_item_port.get_next_item(tx);
      send(tx);
      seq_item_port.item_done();
    end
  endtask


  // Reset the design under test
  virtual task reset();
    tx_if.reset();
  endtask


  // Send a transaction into the design under test
  virtual task send(tx_item tx);
    `uvm_info("SEND", $sformatf("tr.data=%3d", tx.data), UVM_HIGH);
    tx_if.send(tx.data);
  endtask

endclass
