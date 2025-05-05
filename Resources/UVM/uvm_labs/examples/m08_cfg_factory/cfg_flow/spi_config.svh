/***********************************************************************
 * Agent configuration for SPI UVM example
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

class spi_config extends uvm_object;

   `uvm_object_utils(spi_config)
   function new(string name="spi_config");
      super.new(name);
   endfunction

/*******************************************************************
 ** Empty - just for illustration

   // Virtual interface
   virtual spi_interface vif;

   // Configure whether agent is active or passive
   uvm_active_passive_enum active = UVM_ACTIVE;

   // Address for transaction
   bit [31:0] addr = 16;
******************************************************************/

endclass
