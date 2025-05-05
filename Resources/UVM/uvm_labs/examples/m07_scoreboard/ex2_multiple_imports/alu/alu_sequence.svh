/***********************************************************************
 * UVM sequence class for ALU scoreboard example
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

class alu_sequence extends uvm_sequence #(alu_txn);
   `uvm_object_utils(alu_sequence)
   function new(string name="alu_sequence");
      super.new(name);
   endfunction

   virtual task body();
      for (int i=0; i<10; i++) begin
	 `uvm_info("LOOP", $sformatf("In sequence loop #%0d.", i), UVM_FULL)
	 req = alu_txn::type_id::create("req");
	 start_item(req);
	 if (!req.randomize()) `uvm_fatal(get_type_name, "alu_txn::randomize() failed")
	 `uvm_info("SEQ", {"req=", req.sprint()}, UVM_MEDIUM);
	 finish_item(req);
      end
   endtask : body
endclass : alu_sequence
