/***********************************************************************
 * Read sequence - incomplete
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

  virtual task body();
    for (int i=0; i<10; i++) begin
      `uvm_info("LOOP", $sformatf("In read sequence loop #%0d.", i), UVM_FULL)
      req = ahb_txn::type_id::create("req");
      start_item(req);
      if (!req.randomize() with {opcode == AHB_READ;})
	`uvm_fatal(get_type_name, "ahb_txn::randomize() failed")
      `uvm_info("SEQ", {"req=", req.sprint()}, UVM_MEDIUM);
      finish_item(req);
    end
  endtask : body
endclass : ahb_read_sequence
