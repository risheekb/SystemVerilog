/***********************************************************************
 * Sequence for UVM configuration flow example
 * Shows init_start() to get the usb_cfg
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

class usb_fixed_addr2_sequence extends uvm_sequence #(usb_item);
  `uvm_object_utils(usb_fixed_addr2_sequence)
  function new(string name="usb_fixed_addr2_sequence");
    super.new(name);
  endfunction

  usb_config usb_cfg;

  virtual task init_start(input uvm_sequencer #(usb_item) sqr,
			  input usb_config usb_cfg);
    this.usb_cfg = usb_cfg;
    this.start(sqr);
  endtask

  virtual task body();
    usb_item item;

    item = usb_item::type_id::create("item");
    start_item(item);
    if (!item.randomize())
      `uvm_fatal(get_type_name, "randomize() failed")
    item.dst = usb_cfg.addr;

    `uvm_info("ADDR", $sformatf("seq: item.dst=%0x", item.dst), UVM_LOW);
    finish_item(item);
  endtask // body
endclass : usb_fixed_addr2_sequence
