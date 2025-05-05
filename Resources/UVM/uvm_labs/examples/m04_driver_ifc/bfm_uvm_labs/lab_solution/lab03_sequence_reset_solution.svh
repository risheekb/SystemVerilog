/***********************************************************************
 * Example UVM Testbench to verify an Instruction Register design.
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
 *
 * CBS 191212 - Switched to drv_bfm, mon_bfm
 **********************************************************************/

`ifndef lab_sequence_reset_exists
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

    `uvm_info("RESET TEST", "\n\n*** Generating 3 transactions with reset_n active and load_en inactive ***\n", UVM_LOW)

    // First sequence -- start with reset off, load_en off
    tx = lab_tx_in::type_id::create("tx");
    start_item(tx);
      // Initialize transaction to random values, then set explicit values for some properties
      if (!tx.randomize()) `uvm_fatal(get_type_name(), "lab_tx_in::randomize() failed")
      tx.reset_n = 1'b1;      // turn off reset (active low)
      tx.load_en = 1'b0;      // turn off load_en (active high)
      tx.read_pointer = 0;    // read from address 0
    finish_item(tx);

    // Sequence series -- 2 cycles with reset on, load_en off
    repeat (2) begin
      tx = lab_tx_in::type_id::create("tx");
      start_item(tx);
        tx.reset_n = 1'b0;    // turn on reset (active low)
        // all other inputs still have their previous values
      finish_item(tx);
    end

    //
    // LAB 3 ASSIGNMENT:
    // 1) Add a loop to generate 3 more transactions to test that the
    //    DUT does not load anything while reset is active. In the loop:
    //    a) Create a lab_tx_in sequence_item object with the tx handle defined above.
    //    b) Call start_item(tx) to wait for the driver
    //    c) Randomize the transaction values and check for failure
    //    d) Turn reset_n on (active low)
    //    e) Turn load_en on (active high)
    //       (The read pointer is set in post_randomize() to read the addr just written)
    //    f) Call finish_item(tx) to notify the driver
    //
    `uvm_info("RESET TEST", "\n\n*** Generating 3 transactions with reset_n active and load_en active ***\n", UVM_LOW)
//ADD YOUR CODE HERE...
//BEGIN SOLUTION
    // sequence series -- 3 cycles with reset on, load_en on (the
    // DUT register locations should remain reset)
    repeat (3) begin
      tx = lab_tx_in::type_id::create("tx");
      start_item(tx);
      // Initialize transaction to random values, then set explicit values for some properties
      if (!tx.randomize()) `uvm_fatal(get_type_name(), "lab_tx_in::randomize() failed")
      tx.reset_n = 1'b0;    // turn on reset (active low)
      tx.load_en = 1'b1;    // turn on load_en (active high)
      finish_item(tx);
    end
//END SOLUTION



  endtask: body

endclass: lab_sequence_reset
`endif
