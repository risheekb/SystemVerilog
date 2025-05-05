/***********************************************************************
 * Write sequence
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

class ahb_write_sequence extends uvm_sequence #(ahb_txn);
  `uvm_object_utils(ahb_write_sequence)
  function new(string name="ahb_write_sequence");
    super.new(name);
  endfunction

  ahb_config ahb_cfg;
  rand int n_items = 1;
  AHB_ADDR2_T m_addr; // Class-level variables
  AHB_DATA2_T m_data;


  virtual task body();
    for (int i=0; i<n_items; i++) begin
      `uvm_info("WSEQ", $sformatf("In write sequence loop #%0d.", i), UVM_FULL)

      // Create a new request every time (req declared in uvm_sequence)
      req = ahb_txn::type_id::create("req");
      start_item(req);

      if (!req.randomize() with {opcode == AHB_WRITE;
				 addr == m_addr;
				 data == m_data;})
	`uvm_fatal(get_type_name, "ahb_txn::randomize() failed")

      `uvm_info("WSEQ", $sformatf("req=%s", req.sprint()), UVM_MEDIUM);
      finish_item(req);
      `uvm_info("WSEQ", "Waiting for response", UVM_HIGH);
      get_response(rsp);
      `uvm_info("WSEQ", {"Received response \n", rsp.sprint()}, UVM_HIGH);
    end
  endtask : body


  // Single directed write
  task write1(input ahb_config ahb_cfg,
	      input ahb_txn    tx);
    this.ahb_cfg = ahb_cfg;
    m_addr = tx.addr;
    m_data = tx.data;
    this.start(ahb_cfg.sqr);
  endtask

endclass : ahb_write_sequence
