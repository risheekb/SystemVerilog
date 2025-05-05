/***********************************************************************
 * Scoreboard for ALU scoreboard example w/separate predictor
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

class alu_scoreboard extends uvm_scoreboard;
   `uvm_component_utils(alu_scoreboard)
   function new(string name, uvm_component parent);
      super.new(name, parent);
   endfunction

  alu_predictor predict;
  int match, mismatch;

  uvm_analysis_export   #(alu_txn) dut_in_export;
  uvm_tlm_analysis_fifo #(alu_txn) expect_fifo;
  uvm_analysis_export   #(alu_txn) dut_out_export;
  uvm_tlm_analysis_fifo #(alu_txn) actual_fifo;

  virtual function void build_phase(uvm_phase phase);
    dut_in_export  = new("dut_in_export", this);
    dut_out_export = new("dut_out_export", this);
    expect_fifo  = new("expect_fifo", this);
    actual_fifo    = new("actual_fifo", this);
    predict = alu_predictor::type_id::create("predict", this);
  endfunction

  virtual function void connect_phase(uvm_phase phase);
    dut_out_export.connect(actual_fifo.analysis_export);
    dut_in_export.connect(predict.analysis_export);
    predict.expect_port.connect(expect_fifo.analysis_export);
  endfunction: connect_phase


  virtual task run_phase(uvm_phase phase);
    forever begin
      alu_txn expect_txn, actual_txn;

      expect_fifo.get(expect_txn);
      actual_fifo.get(actual_txn);
      if (actual_txn.result !== expect_txn.result) begin
        `uvm_error("Scoreboard", $sformatf("%s does not match %s",
           expect_txn.sprint(), actual_txn.sprint()))
        mismatch++;
      end
      else begin
        match++;
      end
    end
  endtask: run_phase

endclass : alu_scoreboard
