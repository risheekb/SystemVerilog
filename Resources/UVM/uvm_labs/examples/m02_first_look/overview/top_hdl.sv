/***********************************************************************
 * HDL top for TX UVM example
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

module top_hdl;
  import uvm_pkg::*;

  logic clk, reset_n;

  tx_ifc ifc(clk, reset_n);
  dut d1(.clk(ifc.clk), .reset_n(ifc.reset_n), .d(ifc.d), .q(ifc.q));

  initial
    uvm_config_db #(virtual tx_ifc)::set(null,  "uvm_test_top",  "vif",  ifc );

  initial begin
    #5 reset_n = 0;
    clk = 1;
    #15 reset_n = 1;

    forever
      #10 clk = !clk;
  end

endmodule : top_hdl
