/***********************************************************************
 * Dummy testbench interface for "dual-top" example
 * Compile with compile_dual.bat or compile_dual.do
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

interface tx_ifc (input logic clk);
  timeunit 1ns; timeprecision 1ns;

  logic load_en, reset_n;
  logic [7:0] d, q;

  task automatic reset();
    reset_n <= 0;
    #17ns;		// Arbitary delay
    @(negedge clk);
    reset_n <= 1;
  endtask


  task automatic send(input logic [7:0] d_arg);
    @(negedge clk);
    d <= d_arg;
  endtask


  task automatic get_an_input(output logic [7:0] d_arg);
    @(posedge clk or negedge reset_n);
    #1ns;
    d_arg = d;
  endtask

  task automatic get_an_output(output logic [7:0] q_arg);
    @(posedge clk or negedge reset_n);
    #1ns;
    q_arg = q;
  endtask

endinterface
