/***********************************************************************
 * Read sequence for the example of configuring a virtual sequence
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

  int m_count = 1;
  bit m_check = 0;
  ahb_txn m_check_txn;

  virtual task body();
    for (int i=0; i<m_count; i++) begin
      `uvm_info("LOOP", $sformatf("In read sequence loop #%0d.", i), UVM_FULL)
      req = ahb_txn::type_id::create("req");
      start_item(req);

      // Do a read followed by a check?
      if (m_check) begin
        if (!req.randomize() with {opcode == AHB_READ;
                                   addr == m_check_txn.addr;})
	  `uvm_fatal(get_type_name, "ahb_txn::randomize() failed")
      end
      else begin
        if (!req.randomize() with {opcode == AHB_READ;})
	  `uvm_fatal(get_type_name, "ahb_txn::randomize() failed")
        end
      `uvm_info("SEQ", {"req=", req.sprint()}, UVM_MEDIUM);
      finish_item(req);

      if (m_check) begin
      end
    end
  endtask : body


  // Task to generate N transactions with random addresses
  virtual task init_start_check(input ahb_txn check_txn,
				input uvm_sequencer_base sqr);

    m_check_txn = check_txn;	// Configure the sequence
    m_count = 1;
    m_check = 1;
    this.start(sqr);		// Start the sequence
  endtask



endclass : ahb_read_sequence
