/***********************************************************************
 * Write sequence for the example of configuring a virtual sequence
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

  int m_count = 1;

  virtual task body();
    for (int i=0; i<m_count; i++) begin
      `uvm_info("LOOP", $sformatf("In write sequence loop #%0d.", i), UVM_FULL)
      req = ahb_txn::type_id::create("req");
      start_item(req);
      if (!req.randomize() with {opcode == AHB_WRITE;})
	`uvm_fatal(get_type_name, "ahb_txn::randomize() failed")
      `uvm_info("SEQ", {"req=", req.sprint()}, UVM_MEDIUM);
      finish_item(req);
    end
  endtask : body


  // Task to run N count with random addresses
  virtual task init_start(output ahb_txn last, // Last transation written
			  input int count,
			  input uvm_sequencer_base sqr);

    m_count = count;	    // Configure the sequence
    this.start(sqr);	    // Start the sequence
    last = req; 	    // Return info from last request
  endtask

endclass : ahb_write_sequence
