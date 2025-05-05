/***********************************************************************
 * Sequence for UVM configuration flow example
 * Shows several alternative ways to get the usb_cfg from the
 * uvm_config_db
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

class usb_fixed_addr2_sequence extends uvm_sequence #(usb_item);
   `uvm_object_utils(usb_fixed_addr2_sequence)
   function new(string name="usb_fixed_addr2_sequence");
      super.new(name);
   endfunction

   virtual task body();
      usb_item item;
      usb_config usb_cfg;

// Fetch from the DB with the sequencer handle
//      if (!(uvm_config_db #(usb_config)::get(get_sequencer(), "", "usb_cfg", usb_cfg)))

// Fetch from the DB, assuming the usb_config is stored at the top of the DB
      if (!(uvm_config_db #(usb_config)::get(null, get_full_name(), "usb_cfg", usb_cfg)))
        `uvm_fatal("NOCFG", "No usb_cvf found in DB")

      item = usb_item::type_id::create("item");
      start_item(item);
      if (!item.randomize())
        `uvm_fatal(get_type_name, "randomize() failed")
      item.dst = usb_cfg.addr;

      `uvm_info("ADDR", $sformatf("seq: item.dst=%0x", item.dst), UVM_LOW);
      finish_item(item);
   endtask // body
endclass : usb_fixed_addr2_sequence
