/***********************************************************************
 * Definitions for the ALU model and blocks that connect to it
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

package alu_pkg;
   typedef enum logic [2:0] {ADD, SUB, PASSA, PASSB, NEGA} OPCODE_T;
   typedef bit   [15:0] OP_T;
   typedef logic [15:0] RESULT_T;
endpackage : alu_pkg
