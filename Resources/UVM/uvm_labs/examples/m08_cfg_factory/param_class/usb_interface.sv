/***********************************************************************
 * SystemVerilog interface for UVM configuration flow example
 ***********************************************************************
 * Copyright 2016-2019 Siemens
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

interface usb_interface (input logic clk, reset_n);
   logic [7:0] d;
   logic [7:0] q;

  import uvm_pkg::*;
  import usb_pkg::*;

  always @(negedge reset_n) begin
    d = 0;
  end

  task send(input usb_item tr);
    wait (reset_n===1'b1);
    @(negedge clk);
    d = tr.dst;
  endtask


  task get_an_input(output usb_item tr);
    tr = usb_item::type_id::create("tr");
    wait (reset_n===1'b1);
    @(negedge clk);
    #1ns;
    tr.dst = d;
  endtask


  task get_an_output(output usb_item tr);
    tr = usb_item::type_id::create("tr");
    wait (reset_n===1'b1);
    @(negedge clk);   // Get past first transfer after reset
    @(posedge clk);   // Now the output is ready
    #1;
    tr.dst = q;
  endtask

  // Wait for reset to deassert, synchronously
  task automatic wait_for_reset();
    @(posedge clk);
    wait (reset_n === 1'b1);
  endtask


  // Wait for N clock cycles, synchronously
  task automatic wait_for_num_clocks(input int unsigned n);
    @(posedge clk);
    repeat (n-1)
      @(posedge clk);
  endtask

endinterface : usb_interface
