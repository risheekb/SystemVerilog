/***********************************************************************
 * Example UVM Testbench to verify an Instruction Register design.
 *
 * Class: lab_sequence_writeN
 *
 * Defines a sequence object within the UVM testbench.
 * This sequence creates a series of N number transactions that write
 * values into the instruction register.  The number of transactions is
 * set by the test that starts this sequence, and is stored in the
 * configuration data base.
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

`ifndef lab_sequence_writeN_exists
`define lab_sequence_writeN_exists


class lab_sequence_writeN extends uvm_sequence #(lab_tx_in);

  // Register this class name in the factory
  `uvm_object_utils(lab_sequence_writeN)
  function new(string name = "lab_sequence_writeN");
    super.new(name);
  endfunction

  lab_tx_agent_config tx_cfg;

  //
  // LAB 8 ASSIGNMENT:
  // Define a virtual task init_start that is passed sqr, a uvm_sequencer handle
  // specialized for lab_tx_in items, and the agent configuration object handle.
  // The task needs to save the configuration handle, and start this sequence.
  //
  //ADD YOUR CODE HERE...
//BEGIN SOLUTION
  virtual task init_start(input uvm_sequencer #(lab_tx_in) sqr,
			  input lab_tx_agent_config tx_cfg);
    this.tx_cfg = tx_cfg;
    this.start(sqr);
  endtask
//END SOLUTION



  virtual task body();
    lab_tx_in tx;

    tx = lab_tx_in::type_id::create("tx");
    start_item(tx);
    tx.reset_n = 0;
    tx.load_en = 0;
    tx.read_pointer = tx.last_write_pointer;
    finish_item(tx);

    repeat (tx_cfg.nitems) begin
      tx = lab_tx_in::type_id::create("tx");
      start_item(tx);
      if (!tx.randomize()) `uvm_fatal(get_type_name(), "lab_tx_in::randomize() failed")
      finish_item(tx);
    end

    // Do one more sequence with final read pointer value
    tx = lab_tx_in::type_id::create("tx");
    start_item(tx);
    tx.reset_n = 1;
    tx.load_en = 0;
    tx.read_pointer = tx.last_write_pointer;
    finish_item(tx);
  endtask: body

endclass: lab_sequence_writeN
`endif
