/***********************************************************************
 * Top of the testbench for the example of configuring a sequence
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

module top_tb();
  timeunit 1ns; timeprecision 1ns;

  import uvm_pkg::*;
  import ahb_test_pkg::*;

  initial begin
    // Pass interface into testbench
    uvm_config_db#(virtual ahb_ifc)::set(null, "uvm_test_top", "ahb_vif", top_hdl.ahb_if);

    // Housekeeping
    $timeformat(-9,0,"ns",3);

    // Start UVM infrastructure
    run_test();
  end
endmodule
