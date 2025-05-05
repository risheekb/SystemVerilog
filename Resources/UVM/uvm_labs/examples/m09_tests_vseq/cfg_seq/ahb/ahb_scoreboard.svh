/***********************************************************************
 * UVM Scoreboard for AHB with separate predictor and evaluator
 * For the example of configuring a sequence
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

class ahb_scoreboard extends uvm_scoreboard;
   `uvm_component_utils(ahb_scoreboard)
   function new(string name, uvm_component parent);
      super.new(name, parent);
   endfunction

  ahb_evaluator  evaluator;
  uvm_analysis_export #(ahb_txn) dut_in_export;    // Export to imp export in the predictor
  uvm_analysis_export #(ahb_txn) dut_out_export;   // Export to imp export in the evaluator

  virtual function void build_phase(uvm_phase phase);
    dut_in_export  = new("dut_in_export", this);
    dut_out_export = new("dut_out_export", this);
    evaluator      = ahb_evaluator::type_id::create("evaluator", this);
  endfunction

  virtual function void connect_phase(uvm_phase phase);
    dut_in_export.connect(evaluator.expected_export);
    dut_out_export.connect(evaluator.actual_export);
  endfunction: connect_phase
endclass : ahb_scoreboard
