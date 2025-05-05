/***********************************************************************
 * Monitor for UVM configuration flow example
 ***********************************************************************
 * Copyright 2016-2019 Siemens
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

class usb_monitor extends uvm_monitor;
  `uvm_component_utils(usb_monitor);
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  usb_config usb_cfg;
  virtual usb_interface vif;

  usb_item tr_last;

  virtual function void build_phase(uvm_phase phase);
    if (!uvm_config_db #(usb_config)::get(this, "", "usb_cfg", usb_cfg))
      `uvm_fatal("NOCFG", "No usb_cfg in DB");
    vif = usb_cfg.vif;
  endfunction

  virtual task run_phase(uvm_phase phase);
    `uvm_info("RUN", $sformatf("In %m"), UVM_FULL);
    fork
      get_inputs();
      get_outputs();
    join
  endtask


  virtual task get_inputs();
    forever begin
      usb_item tr;

      vif.get_an_input(tr);
      `uvm_info("MON_IN", $sformatf("Drove %0x", tr.dst), UVM_LOW)
      tr_last = tr;
    end
  endtask

  virtual task get_outputs();
    forever begin
      usb_item tr;

      vif.get_an_output(tr);
      `uvm_info("MON_OUT", $sformatf("Sampled %0x", tr.dst), UVM_LOW);

      // Mini scoreboard
      if (tr_last == null) begin
        `uvm_error("NULL_LAST", "Tried to compare but last transacton handle is null")
      end
      else begin
	if (tr_last.dst !== tr.dst)
          `uvm_error("MISCOMP", $sformatf("Actual dst (%0x) != expected dst (%0x)",
	                                  tr.dst, tr_last.dst))
      end
    end
  endtask


endclass
