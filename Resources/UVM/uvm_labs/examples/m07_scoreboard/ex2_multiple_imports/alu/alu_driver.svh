/***********************************************************************
 * UVM driver class for the ALU scoreboard example
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

class alu_driver extends uvm_driver #(alu_txn);
   `uvm_component_utils(alu_driver)
   function new(string name, uvm_component parent);
      super.new(name, parent);
   endfunction

   alu_config alu_cfg;

   virtual function void build_phase(uvm_phase phase);
      if (!uvm_config_db#(alu_config)::get(this, "", "alu_cfg", alu_cfg))
	`uvm_fatal("GET", "FAILED")
   endfunction

   virtual task run_phase(uvm_phase phase);
      forever begin
	 seq_item_port.get_next_item(req);  // req declared in uvm_driver
	 send(req);
	 seq_item_port.item_done();
      end
   endtask

   virtual task send(alu_txn t);
      `uvm_info("DRIVER", t.sprint(), UVM_FULL)
      alu_cfg.vif.send(t);
   endtask

endclass : alu_driver
