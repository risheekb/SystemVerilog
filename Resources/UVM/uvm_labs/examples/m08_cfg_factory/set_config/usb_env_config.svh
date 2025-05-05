/***********************************************************************
 * Environment configuration for UVM configuration flow example
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

class env_config extends uvm_object;
   `uvm_object_utils(env_config)
   function new(string name="env_config");
      super.new(name);
   endfunction

   usb_config usb_cfg;
   spi_config spi_cfg;

   bit enable_coverage = 0;
endclass
