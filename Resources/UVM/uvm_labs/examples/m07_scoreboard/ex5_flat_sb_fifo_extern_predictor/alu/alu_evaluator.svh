/***********************************************************************
 * Evaluator class in ALU scoreboard example
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

class alu_evaluator extends uvm_component;
   `uvm_component_utils(alu_evaluator)
   function new(string name, uvm_component parent);
      super.new(name, parent);
   endfunction

  // expect_export feeds into expect_fifo
  uvm_analysis_export   #(alu_txn) expect_export;
  uvm_tlm_analysis_fifo #(alu_txn) expect_fifo;

  // actual_export feeds into actual_fifo
  uvm_analysis_export   #(alu_txn) actual_export;
  uvm_tlm_analysis_fifo #(alu_txn) actual_fifo;

  int match, mismatch; // Number of matches and mismatches

  virtual function void build_phase(uvm_phase phase);
    expect_fifo   = new("expect_fifo", this);
    expect_export = new("expect_export", this);
    actual_fifo     = new("actual_fifo", this);
    actual_export   = new("actual_export", this);
  endfunction: build_phase

  virtual function void connect_phase(uvm_phase phase);
    expect_export.connect(expect_fifo.analysis_export);
    actual_export.connect(actual_fifo.analysis_export);
  endfunction: connect_phase

  virtual task run_phase(uvm_phase phase);
    forever begin
      alu_txn expect_txn, actual_txn;

      expect_fifo.get(expect_txn);
      actual_fifo.get(actual_txn);
      if (actual_txn.result !== expect_txn.result) begin
        `uvm_error("Evaluator", $sformatf("%s does not match %s",
           expect_txn.sprint(), actual_txn.sprint()))
        mismatch++;
      end
      else begin
        match++;
      end
    end
  endtask: run_phase

  virtual function void report_phase( uvm_phase phase );
    `uvm_info("SCB", $sformatf("Passed=%0d, failed=%0d", match, mismatch), UVM_LOW)
  endfunction: report_phase
endclass : alu_evaluator
