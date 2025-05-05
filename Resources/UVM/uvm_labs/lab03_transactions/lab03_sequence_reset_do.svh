/***********************************************************************
 * UVM Testbench to verify an Instruction Register array design.
 *
 * Class: lab_sequence_reset
 *
 * Defines a sequence object within the UVM testbench.
 * This sequence creates a series of transactions to reset the DUT and
 * hold it in a reset state for several clock cycles while changing
 * other DUT inputs.
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

`ifdef lab_sequence_reset_exists
ERROR DO NOT INCLUDE BOTH lab03_sequence_reset.svh AND lab03_sequence_reset_do.svh
`else
`define lab_sequence_reset_exists

class lab_sequence_reset extends uvm_sequence #(lab_tx_in);

  // Register this class name in the factory
  `uvm_object_utils(lab_sequence_reset)
  function new(string name = "lab_sequence_reset");
    super.new(name);
  endfunction

  virtual task body();

    // Handle to a sequence_item to store transaction values
    lab_tx_in tx;

    `uvm_info("SEQ_RESET1", "\n\n*** Generating 3 transactions with reset_n active and load_en inactive ***\n", UVM_LOW)

    // First sequence -- start with reset off, load_en off
    `uvm_do_with(tx, {reset_n == 1'b1;      // turn off reset (active low)
		      load_en == 1'b0;      // turn off load_en (active high)
		      read_pointer == 0;})    // read from address 0

    // Sequence series -- 2 cycles with reset on, load_en off
    repeat (2) begin
      `uvm_do_with(tx, {reset_n == 1'b0; } )    // turn on reset (active low)
    end

    //
    // LAB 3 ASSIGNMENT:
    // 1) Add a loop to generate 3 more transactions to test that the
    //    DUT does not load anything while reset is active. In the loop:
    //    a) Start with the uvm_do_with() macro
    //    b) Use the tx handle
    //    c) Turn reset_n on (active low)
    //    d) Turn load_en on (active high)
    //       (The read pointer is set in post_randomize() to read the addr just written)
    //
    `uvm_info("SEQ_RESET2", "\n\n*** Generating 3 transactions with reset_n active and load_en active ***\n", UVM_LOW)
    //ADD YOUR CODE HERE...


  endtask: body

endclass: lab_sequence_reset
`endif
