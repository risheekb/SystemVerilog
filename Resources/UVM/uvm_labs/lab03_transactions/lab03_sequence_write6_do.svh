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
    //    a) Call the `uvm_do() macro and the handle tx
    //
    // 4) After the loop, make a sequence item to read back the value you just wrote.
    //    a) Add `uvm_info("SEQ_WRITE6", "\n\n*** Generating a transaction to read the last value ***\n", UVM_MEDIUM)
    //    b) Call the `uvm_do_with() macro and the handle tx
    //    c) Constrain reset_n == 1;
    //    d) Constrain load_en == 0;
    //       The read_pointer is set in post_randomize() to save the last address written.
    //
    //ADD YOUR CODE HERE...

  endtask: body

endclass: lab_sequence_write6
`endif
