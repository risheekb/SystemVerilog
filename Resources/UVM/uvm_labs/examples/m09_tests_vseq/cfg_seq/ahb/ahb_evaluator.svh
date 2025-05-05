/***********************************************************************
 * Evaluator class for example of configuring a sequence
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

class ahb_evaluator extends uvm_component;
  `uvm_component_utils(ahb_evaluator)
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  uvm_analysis_export   #(ahb_txn) expected_export;
  uvm_tlm_analysis_fifo #(ahb_txn) expected_fifo;
  uvm_analysis_export   #(ahb_txn) actual_export;
  uvm_tlm_analysis_fifo #(ahb_txn) actual_fifo;
  int match, mismatch;

  virtual function void build_phase(uvm_phase phase);
    expected_fifo   = new("expected_fifo", this);
    expected_export = new("expected_export", this);
    actual_fifo     = new("actual_fifo", this);
    actual_export   = new("actual_export", this);
  endfunction: build_phase

  virtual function void connect_phase(uvm_phase phase);
    expected_export.connect(expected_fifo.analysis_export);
    actual_export.connect(actual_fifo.analysis_export);
  endfunction: connect_phase

  virtual task run_phase(uvm_phase phase);
    forever begin
      ahb_txn expected_txn, actual_txn;

      expected_fifo.get(expected_txn);
      actual_fifo.get(actual_txn);
      if (actual_txn.result !== expected_txn.result) begin
        `uvm_error("Evaluator", $sformatf("Expect %s does not match actual %s",
					  expected_txn.sprint(), actual_txn.sprint()))
        mismatch++;
      end
      else begin
        match++;
      end
    end
  endtask: run_phase

  virtual function void report_phase( uvm_phase phase );
    `uvm_info("SCB", $sformatf("Matches: %0d", match), UVM_NONE)
    `uvm_info("SCB", $sformatf("Mismatches: %0d", mismatch), UVM_NONE)
  endfunction: report_phase
endclass : ahb_evaluator
