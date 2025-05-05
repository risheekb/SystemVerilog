/***********************************************************************
 * Driver for TX UVM example
 ***********************************************************************
 * Copyright 2016-2017 Siemens
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


  virtual task run_phase(uvm_phase phase);
    `uvm_info("RUN", $sformatf("In %m"), UVM_FULL);
    forever begin
      tx_item tr;

      seq_item_port.get_next_item(tr);
      send(tr);
      seq_item_port.item_done();
    end
  endtask


  virtual task send(tx_item tr);
    `uvm_info("SEND", $sformatf("Driving %h", tr.pay.data), UVM_LOW)
  endtask

endclass
