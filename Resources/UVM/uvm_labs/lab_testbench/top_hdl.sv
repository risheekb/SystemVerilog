/***********************************************************************
 * A SystemVerilog top-level netlist to connect testbench to DUT
 * This uses the "dual-top" approach that is emulation friendly
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
  timeunit 1ns; timeprecision 1ns;
  import instr_reg_pkg::*;
  import uvm_pkg::*;

  logic clk;

  // Instantiate the interface (instance name is tx_if)
  tx_ifc tx_if (clk);

  // Connect interface to design using discrete ports
  instr_reg dut (.clk,
                 .load_en(tx_if.load_en),
                 .reset_n(tx_if.reset_n),
                 .operand_a(tx_if.operand_a),
                 .operand_b(tx_if.operand_b),
                 .opcode(tx_if.opcode),
                 .write_pointer(tx_if.write_pointer),
                 .read_pointer(tx_if.read_pointer),
                 .instruction_word(tx_if.instruction_word),
		 .valid(tx_if.valid)
   );

  initial begin
    // In the UVM configuration DB, set the virtual interface at the test level
    uvm_config_db #(virtual tx_ifc)::set(null, "uvm_test_top", "vif", tx_if);
  end

  // Clock Oscillators
  initial begin
    clk <= 0;
    forever #5ns clk = ~clk;
  end

endmodule: top_hdl
