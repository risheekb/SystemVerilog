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


  virtual task pre_start();
    if (!uvm_config_db#(ahb_config)::get(get_sequencer(), "", "ahb_cfg", ahb_cfg))
      `uvm_fatal("NOAHBCFG", "Unable to find ahb_cfg in uvm_config_db")

    ahb_txn::addr_lo = ahb_cfg.addr_lo; // Set static variables in transaction
    ahb_txn::addr_hi = ahb_cfg.addr_hi;
  endtask


  virtual task body();
    ahb_txn rsp = ahb_txn::type_id::create("rsp");

    rsp.status = OK;  // rsp declared in uvm_sequence

    for (int i=0; i<10; i++) begin
      `uvm_info("LOOP", $sformatf("In write sequence loop #%0d.", i), UVM_FULL)

      // Create a new request every time (req declared in uvm_sequence)
      req = ahb_txn::type_id::create("req");
      start_item(req);

      // Pretend to generate a response based on the result from the previous request
      case (rsp.status)
      OK:  `uvm_info("SEQUENCE", "Generating next req, prev status is OK", UVM_LOW)
      BAD: `uvm_info("SEQUENCE", "Generating next req, prev status is BAD", UVM_LOW)
      endcase

      if (!req.randomize() with {opcode == AHB_WRITE;})
	`uvm_fatal(get_type_name, "ahb_txn::randomize() failed")

      `uvm_info("SEQ", $sformatf("req=%s", req.sprint()), UVM_MEDIUM);
      finish_item(req);
      get_response(rsp);
    end
  endtask : body

endclass : ahb_write_sequence
