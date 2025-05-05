/***********************************************************************
 * HVL Top of the testbench
 ***********************************************************************
 * Copyright 2016-2017 Siemens
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
  import alu_test_pkg::*;

  initial begin
    uvm_config_db#(virtual alu_ifc)::set(null, "uvm_test_top", "vif", top_hdl.alu_if);
    $timeformat(-9,0,"ns",3);
    run_test();
  end
endmodule
