/***********************************************************************
 * Predictor class
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

class ahb_predictor extends uvm_subscriber #(ahb_txn);
   `uvm_component_utils(ahb_predictor)
   function new(string name, uvm_component parent);
      super.new(name, parent);
   endfunction

  // Port to send out the predicted result
  uvm_analysis_port #(ahb_txn) expected_port;

  // Memory to predict results - associative for flexibility
  AHB_DATA4_T predict_memory[AHB_ADDR2_T];

  virtual function void build_phase(uvm_phase phase);
    expected_port = new("expected_port", this);
  endfunction

  virtual function void write(ahb_txn t);
    ahb_txn expected_txn;

    if (!$cast(expected_txn, t.clone()))
      `uvm_fatal(get_type_name(), "Clone returned incorrect type")

    if ($isunknown(t.addr)) begin
      `uvm_warning("XADDR", {"X/Z values in transaction address, using 0: ", t.sprint()})
      expected_txn.addr = 0;
    end

    case(t.opcode)
      AHB_WRITE: begin
	expected_txn.result = t.data;
	predict_memory[t.addr] = t.data;
      end

      AHB_READ: begin
	if (! predict_memory.exists(t.addr)) begin
	  `uvm_warning("NONADDR", {"Read from uninitalized address, using 0: ", t.sprint()})
	end
	expected_txn.result = predict_memory[expected_txn.addr];
      end

      default: `uvm_error("BADOPC", $sformatf("Unrecognized opcode=%s (0x%0x)", t.opcode.name(), t.opcode))
    endcase

     `uvm_info("PREDICTOR", expected_txn.sprint(), UVM_FULL)
    expected_port.write(expected_txn);
  endfunction: write
endclass : ahb_predictor
