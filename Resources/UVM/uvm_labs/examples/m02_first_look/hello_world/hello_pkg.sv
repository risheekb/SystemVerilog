/***********************************************************************
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
package hello_pkg;
  import uvm_pkg::*;
`include "uvm_macros.svh"

class hello_test extends uvm_test;
  `uvm_component_utils(hello_test);
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  virtual task run_phase(uvm_phase phase);
    `uvm_info("ID", "Hello World!", UVM_LOW);
  endtask
endclass

endpackage
