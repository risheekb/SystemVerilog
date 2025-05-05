/***********************************************************************
 * UVM Testbench to verify an Instruction Register array design.
 *
 * Class: lab_test_message
 *
 * Defines a UVM test component within the UVM testbench.
 * This is just for learning about UVM messaging
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

`ifndef lab_test_message_exists
`define lab_test_message_exists


class lab_test_message extends uvm_test;
  // Register this class name in the factory
  `uvm_component_utils(lab_test_message)
  function new(string name, uvm_component parent);
    super.new (name, parent);
  endfunction


  virtual task run_phase(uvm_phase phase);
    logic [31:0] data = 'hCAB;

    //
    // LAB 2 ASSIGNMENT:
    // 1) Create uvm_info messages with verbosity LOW, MEDIUM, HIGH,
    //    and DEBUG. You will simulate with different verbosity settings
    //    and see which print. Start with the uvm_info below.
    // 2) Check the value of data, declared above
    //    - If it is equal to the expected value 'hCAB, 
    //      print a success message and the data value
    //    - Else print an error message, including the data value
    //    - Do you need a semicolon on the end of the macros?
    // 3) Create a fatal message, followed by a uvm_info message
    //    - Does the info ever print?
    //

    `uvm_info("ID", "Sample message, verbosity = UVM_NONE", UVM_NONE)
//ADD YOUR CODE HERE...
    
    `uvm_info("ID","Printing Message With Verbosity = UVM_LOW",UVM_LOW)
    `uvm_info("ID","Printing Message With Verbosity = UVM_MEDIUM",UVM_MEDIUM)
    `uvm_info("ID","Printing Message With Verbosity = UVM_HIGH",UVM_HIGH)
    `uvm_info("ID","Printing Message With Verbosity = UVM_FULL",UVM_FULL)


    if(data === 'hCAB)
      `uvm_info("ID","Success, Verbosity = UVM_LOW",UVM_LOW)
    else
      `uvm_info("ID",$sformatf("Comparision Failed data = %0h",data),UVM_LOW)

    `uvm_fatal("FATAL","Exiting Simulation")

  endtask : run_phase

endclass: lab_test_message
`endif
