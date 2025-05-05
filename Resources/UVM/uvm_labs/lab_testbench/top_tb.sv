/*******************************************************
 * Top level testbench module
 * This uses the emulation friendly "dual-top" approach
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

module top_tb;
  timeunit 1ns; timeprecision 1ns;

  import uvm_pkg::*;          // Import the UVM base class library
  import lab_package::*;      // Import the course UVM testbench classes

  // Setup and start the UVM test
  initial begin
    $timeformat(-9,0,"ns",6);

    // Start the test
    run_test();  // Test name passed in with 'vsim +UVM_TESTNAME=lab_test_foo ...'
  end

endmodule : top_tb
