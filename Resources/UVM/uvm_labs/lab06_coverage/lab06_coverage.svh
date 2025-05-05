/***********************************************************************
 * UVM Testbench to verify an Instruction Register array design.
 *
 * Class: lab_coverage_collector
 *
 * Defines a coverage collector component within the UVM testbench.
 * Tracks value changes on the same DUT inputs that are watched by the
 * monitor and broadcast on a TLM analysis port.
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

`ifndef lab_coverage_collector_exists
`define lab_coverage_collector_exists


class lab_coverage_collector extends uvm_subscriber #(lab_tx_in);

  lab_tx_in tx;  // Handle to the transaction object on which value changes will be covered

  covergroup cg_dut_inputs;
    ADDR: coverpoint tx.write_pointer {
            bins quad1 = { [0:7] };
            bins quad2 = { [8:15] };
            bins quad3 = { [16:23] };
            bins quad4 = { [24:31] };
          }
    OPCODE: coverpoint tx.opcode {
          bins div_op    = { DIV };
          bins other_ops = default;
    }
    OPA: coverpoint tx.operand_a {
          bins zero = { 0 };
          bins low  = { [1:9] };
          bins high  = { [10:$] };
    }
    OPB: coverpoint tx.operand_b {
          bins zero = { 0 };
          bins low  = { [1:9] };
          bins high  = { [10:$] };
    }
    DIV_ZERO: cross OPCODE, OPB {
          bins        d0 =  binsof(OPCODE.div_op) &&  binsof(OPB.zero);
          ignore_bins d1 = !binsof(OPCODE.div_op) || !binsof(OPB.zero);
    }
  endgroup : cg_dut_inputs

  //
  // LAB 6 ASSIGNMENT, PART 1:
  // Register this class in the factory,
  // Define its new() method and construct the cg_dut_inputs covergroup inside
  //
  //ADD YOUR CODE HERE...

  `uvm_component_utils(lab_coverage_collector)
  function new(string name,uvm_component parent);
    super.new(name,parent);
    cg_dut_inputs = new();
  endfunction

  //
  // LAB 6 ASSIGNMENT, PART 2:
  // Implement the analysis imp export write() method and call
  // the covergroup's sample() method each time the write
  // method is called.
  //
  // NOTE: Be sure to copy the transaction handle from the analysis port
  // to the class tx property (because coverage is specified on tx).
  //
  //ADD YOUR CODE HERE...
  virtual function void write(input lab_tx_in t);
    tx = t;
    cg_dut_inputs.sample();
  endfunction
  virtual function void report_phase(uvm_phase phase);
    `uvm_info("COVERAGE", $sformatf("\n\n\t Functional coverage = %5.2f%%\n",
                                         cg_dut_inputs.get_coverage()), UVM_NONE)
  endfunction

endclass: lab_coverage_collector
`endif
