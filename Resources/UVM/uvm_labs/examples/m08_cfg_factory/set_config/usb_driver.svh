/***********************************************************************
 * Driver for UVM configuration flow example
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

class usb_driver extends uvm_driver #(usb_item);
  `uvm_component_utils(usb_driver);
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  usb_config usb_cfg;
  virtual usb_interface vif;


  virtual function void set_config(input usb_config usb_cfg);
    this.usb_cfg = usb_cfg;
  endfunction


  virtual function void build_phase(uvm_phase phase);
    vif = usb_cfg.vif;
    `uvm_info(get_type_name(), $sformatf("addr=%0x", usb_cfg.addr), UVM_LOW) // Should be UVM_FULL
  endfunction


  virtual task run_phase(uvm_phase phase);
    forever begin
      usb_item tr;

      seq_item_port.get_next_item(tr);
      send(tr);
      seq_item_port.item_done();
    end
  endtask : run_phase

  virtual task send(usb_item tr);
    `uvm_info("SEND", $sformatf("Driving %0x", tr.dst), UVM_LOW)
    vif.send(tr);
    `uvm_info("SEND", $sformatf("Drove %0x", tr.dst), UVM_LOW)
  endtask

endclass
