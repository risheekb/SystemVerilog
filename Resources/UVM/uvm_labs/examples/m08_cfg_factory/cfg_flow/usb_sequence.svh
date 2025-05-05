/***********************************************************************
 * Sequence for UVM configuration flow example
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

class usb_sequence extends uvm_sequence #(usb_item);
   `uvm_object_utils(usb_sequence)
   function new(string name="usb_sequence");
      super.new(name);
   endfunction

   virtual task body();
      repeat (10) begin
	 req = usb_item::type_id::create("req");
	 start_item(req);
	 if (!req.randomize()) `uvm_fatal(get_type_name, "usb_item::randomize() failed")
	 `uvm_info("DST", $sformatf("seq: req.dst=%0x", req.dst), UVM_LOW);
	 finish_item(req);
      end
   endtask // body
endclass : usb_sequence
