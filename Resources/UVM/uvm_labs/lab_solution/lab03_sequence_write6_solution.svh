 /***********************************************************************
 * UVM Testbench to verify an Instruction Register array design.
 *
 * Class: lab_sequence_write6
 *
 * Defines a sequence in the UVM testbench.
 * This sequence creates a series of 6 transactions that write values
 * into the instruction register.
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

`ifndef lab_sequence_write6_exists
 `define lab_sequence_write6_exists


class lab_sequence_write6 extends uvm_sequence #(lab_tx_in);

  // Register this class name in the factory
  `uvm_object_utils(lab_sequence_write6)
  function new(string name = "lab_sequence_write6");
    super.new(name);
  endfunction

  virtual task body();
    //
    // LAB 3 ASSIGNMENT:
    // 1) Define a lab_tx_in handle tx
    //
    // 2) Add `uvm_info("SEQ_WRITE6", "\n\n*** Generating 6 write transactions ***\n", UVM_MEDIUM)
    //
    // 3) Add loop to generate 6 write transactions. In the loop:
    //    a) Create a lab_tx_in object with handle tx
    //    b) Call start_item(tx) which blocks, waiting for the driver to get a transaction.
    //    c) Randomize the transaction properties.
    //    d) Call finish_item(tx) which tell the driver that the transaction is ready.
    //       The read_pointer is set in post_randomize() to save the last addr written.
    //
    // 4) After the loop, make a sequence item to read back the value you just wrote.
    //    a) Add `uvm_info("SEQ_WRITE6", "\n\n*** Generating a transaction to read the last value ***\n", UVM_MEDIUM)
    //    b) Create a lab_tx_in object
    //    c) Call start_item(tx);
    //    d) Don't randomize!
    //    e) Set tx.reset_n = 1;
    //    f) Set tx.load_en = 0;
    //    g) Set tx.read_pointer to lab_tx_base::last_write_pointer, a static variable
    //       This reads back the last address written to the DUT above.
    //    h) Call finish_item(tx);
    //
    //ADD YOUR CODE HERE...
    //BEGIN SOLUTION
    // Handle to a sequence_item to store transaction values
    lab_tx_in tx;

    `uvm_info("SEQ_WRITE6", "\n\n*** Generating 6 write transactions ***\n", UVM_MEDIUM)

    repeat(6) begin
      tx = lab_tx_in::type_id::create("tx");
      start_item(tx);
      if (!tx.randomize()) `uvm_fatal(get_type_name(), "lab_tx_in::randomize() failed")
      finish_item(tx);
    end

    `uvm_info("SEQ_WRITE6", "\n\n*** Generating a transaction to read the last value ***\n", UVM_MEDIUM)
    // Generate one last transaction to read last location written
    tx = lab_tx_in::type_id::create("tx");
    start_item(tx);
    tx.reset_n = 1;
    tx.load_en = 0;
    tx.read_pointer = lab_tx_in::last_write_pointer;
    finish_item(tx);
    //END SOLUTION

  endtask: body

endclass: lab_sequence_write6
`endif
