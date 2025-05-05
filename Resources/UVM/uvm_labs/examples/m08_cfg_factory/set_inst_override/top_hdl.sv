/***********************************************************************
 * HDL top for UVM override example
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

module top_hdl();
  import uvm_pkg::*;
  logic clk, reset_n;

  tx_interface
    tx_if0(clk, reset_n),
    tx_if1(clk, reset_n),
    tx_if2(clk, reset_n),
    tx_if3(clk, reset_n);
  dut
    d0(.clk(clk), .reset_n(reset_n), .d(tx_if0.d), .q(tx_if0.q)),
    d1(.clk(clk), .reset_n(reset_n), .d(tx_if1.d), .q(tx_if1.q)),
    d2(.clk(clk), .reset_n(reset_n), .d(tx_if2.d), .q(tx_if2.q)),
    d3(.clk(clk), .reset_n(reset_n), .d(tx_if3.d), .q(tx_if3.q));

  initial begin
    // Write the interface into the config DB for use by the agent/driver/montor
    uvm_config_db #(virtual tx_interface)::set(null,  "uvm_test_top",  "vif[0]",  tx_if0);
    uvm_config_db #(virtual tx_interface)::set(null,  "uvm_test_top",  "vif[1]",  tx_if1);
    uvm_config_db #(virtual tx_interface)::set(null,  "uvm_test_top",  "vif[2]",  tx_if2);
    uvm_config_db #(virtual tx_interface)::set(null,  "uvm_test_top",  "vif[3]",  tx_if3);
  end

  initial begin
    #5 reset_n = 0;
    clk = 1;
    #15 reset_n = 1;

    forever
      #10 clk = !clk;
  end

endmodule : top_hdl
