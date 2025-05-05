/***********************************************************************
 * UVM Testbench to verify an Instruction Register array design.
 *
 * Class: lab_virtual_sequence
 *
 * Defines a UVM sequence that runs other sequences in a specific order.
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

`ifndef lab_virtual_sequence_exists
`define lab_virtual_sequence_exists


class lab_virtual_sequence extends uvm_sequence;

  // Register this class name in the factory
  `uvm_object_utils(lab_virtual_sequence)
  function new(string name = "lab_virtual_sequence");
    super.new(name);
  endfunction

  lab_tx_agent_config tx_cfg;

  virtual task init_start(input lab_tx_agent_config tx_cfg);
    this.tx_cfg = tx_cfg;
    this.start(null);
  endtask
  
  //
  // LAB 9 ASSIGNMENT:
  // 1) Define a body() method that:
  //    a) Declares the lab_sequence_reset handle reset_seq
  //    b) Declares the lab_sequence_write6 handle write_seq
  //    c) Creates and starts lab_sequence_reset with the handle tx_cfg.sqr, 
  //       and "this" which points to the parent sequence.
  //    d) After reset sequence completes, creates and starts
  //       lab_sequence_write6 with (tx_cfg.sqr, this)
  //

  virtual task body();

//ADD YOUR CODE HERE...
//BEGIN SOLUTION
  // Handles to the sequences to be run by this virtual sequence
    lab_sequence_reset   reset_seq;
    lab_sequence_write6  write_seq;

    // Create and run the reset sequence
    `uvm_info("VSEQ", "\n\n\n****** VIRTUAL SEQUENCE: RESET ******\n\n", UVM_NONE)
    reset_seq = lab_sequence_reset::type_id::create("reset_seq");
    reset_seq.start(tx_cfg.sqr, this);

    // Create and run the write6 transactions sequence
    `uvm_info("VSEQ", "\n\n\n****** VIRTUAL SEQUENCE: WRITE 6 RANDOM REGISTERS ******\n\n", UVM_NONE)
    write_seq = lab_sequence_write6::type_id::create("write_seq");
    write_seq.start(tx_cfg.sqr, this);
//END SOLUTION


  endtask : body

endclass : lab_virtual_sequence

`endif
