/***********************************************************************
 * Read sequence
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

class ahb_read_sequence extends uvm_sequence #(ahb_txn);
  `uvm_object_utils(ahb_read_sequence)
  function new(string name="ahb_read_sequence");
    super.new(name);
  endfunction

  rand int n_items = 1;
  ahb_txn check_tx = null; // Default: don't check

  virtual task body();
    for (int i=0; i<n_items; i++) begin
      `uvm_info("LOOP", $sformatf("In read sequence loop #%0d.", i), UVM_FULL)

      // Create, start, and randomize the read transaction
      req = ahb_txn::type_id::create("req");
      start_item(req);
      if (!req.randomize() with {opcode == AHB_READ;})
	`uvm_fatal(get_type_name, "ahb_txn::randomize() failed")

      // If this is a read check, change the address
      if (check_tx)
	req.addr = check_tx.addr;

      `uvm_info("SEQ", {"req=", req.sprint()}, UVM_MEDIUM);
      finish_item(req);

      // Get the response and optionally check it
      get_response(rsp);
      `uvm_info("WSEQ", {"Received response \n", rsp.sprint()}, UVM_HIGH);
      if (check_tx) begin
	if (check_tx.data === rsp.data)
	  `uvm_info("RSEQ", "Read response checked", UVM_HIGH)
	else
	  `uvm_error("RSEQ", $sformatf("Read: expected data=0x%0x, actual=0x%0x",
				       check_tx.data, rsp.data))
      end


    end
  endtask


  virtual task check(input ahb_config ahb_cfg,
		     input ahb_txn check_tx);
    n_items = 1;
    this.check_tx = check_tx;
    this.start(ahb_cfg.sqr);
  endtask

endclass : ahb_read_sequence
