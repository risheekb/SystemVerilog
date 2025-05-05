/***********************************************************************
 * SystemVerilog interface for TX UVM example
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
 *
 * Methods are NOT reentrant and so are NOT declared automatic
 **********************************************************************/

interface tx_interface (input logic clk, reset_n);
  logic [7:0] d;
  logic [7:0] q;

  import uvm_pkg::*;
  import tx_pkg::*;

  always @(negedge reset_n) begin
    d = 0;
  end

  task send(input tx_pkg::tx_item tr);
    wait (reset_n===1'b1);
    @(negedge clk);
    d = tr.data;
  endtask


  task get_an_input(output tx_pkg::tx_item tr);
    tr = tx_pkg::tx_item::type_id::create("tr");
    wait (reset_n===1'b1);
    @(negedge clk);
    #1ns;
    tr.data = d;
  endtask


  task get_an_output(output tx_pkg::tx_item tr);
    tr = tx_pkg::tx_item::type_id::create("tr");
    wait (reset_n===1'b1);
    @(negedge clk);   // Get past first send after reset
    @(posedge clk);   // Now the output is ready
    #1;
    tr.data = q;
  endtask


  // Call from sequences so they don't access DUT signals
  task wait_clocks(input int n);
    repeat (n) @(posedge clk);
  endtask

endinterface : tx_interface
