/***********************************************************************
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

module top();
  timeunit 1ns/1ns;

  import uvm_pkg::*;
  import tx_pkg::*;

  logic clk;
  initial begin
    clk <= 0;
    forever #5 clk = !clk;
  end

  tx_ifc  tx_if(clk);
  top_tb  tb();
  top_hdl hdl(tx_if);
endmodule
