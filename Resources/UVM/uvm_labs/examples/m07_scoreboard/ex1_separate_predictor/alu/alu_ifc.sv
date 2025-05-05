/***********************************************************************
 * Interface to connect to ALU DUT for scoreboard example
 * Provides send() and get*() methods for testbench
 * DBG code is commented out, but saved for future generations
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

interface alu_ifc();
  timeunit 1ns; timeprecision 1ns;

   import alu_test_pkg::*;
   import alu_pkg::*;

   logic clk, reset_n;
   RESULT_T result;
   OP_T     a, b, addr_in, addr_out;
   OPCODE_T opcode;


   initial begin
//DBG       $monitor("@%t MON reset_n=%b, clk=%b, opcode=%0d., a=0x%0x, b=0x%0x, result=0x%0x", $realtime, reset_n, clk, opcode, a, b, result);
      reset_n = 0;
      #10;
      clk = 1; // After reset, start with negedge to send()
      #10;
      reset_n = 1;
      #10;
      forever #10 clk = !clk;
   end


   task send(alu_test_pkg::alu_txn t);
      wait (reset_n===1);
      @(negedge clk);
//DBG      $display("@%t: %m after @(negedge clk), t=%s", $realtime, t.sprint());
      a = t.a;
      b = t.b;
      opcode = t.opcode;
      addr_in = t.addr;
   endtask

   task get_an_input(alu_test_pkg::alu_txn t);
      wait (reset_n===1);
      @(posedge clk);
      t.a = a;
      t.b = b;
      $cast(t.opcode, opcode);
      t.addr = addr_in;
//DBG      $display("@%t: %m t=%s", $realtime, t.sprint());
   endtask

   task get_an_output(alu_test_pkg::alu_txn t);
      wait (reset_n===1);
      @(posedge clk);
      #1ns;
      t.a = a;
      t.b = b;
      $cast(t.opcode, opcode);
      t.result = result;
      t.addr = addr_out;
//DBG      $display("@%t: %m t=%s", $realtime, t.sprint());
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

endinterface : alu_ifc
