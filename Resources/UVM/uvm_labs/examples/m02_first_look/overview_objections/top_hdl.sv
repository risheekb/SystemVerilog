/***********************************************************************
 * Testbench top for "dual-top" example
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

module top_hdl(tx_ifc tx_if);
  timeunit 1ns/1ns;
  import uvm_pkg::*;


  instr_reg dut(.clk(tx_if.clk),
                .load_en(tx_if.load_en),
                .reset_n(tx_if.reset_n),
		.d(tx_if.d),
		.q(tx_if.q));

  initial begin
    uvm_config_db#(virtual tx_ifc)::set(null, "", "tx_if", tx_if);
  end

endmodule
