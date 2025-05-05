/***********************************************************************
 * ALU design under test for ALU scoreboard example
 * Includes an "address" to help with prediction in the scoreboard
 *
 * Simulate with +BAD_ADD to force errors
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

module alu
  import alu_pkg::*;
   (output RESULT_T result,
    output OP_T     addr_out,
    input  OP_T     a, b,
    input  OPCODE_T opcode,
    input  OP_T     addr_in,
    input  logic    clk, reset_n);

   timeunit 1ns; timeprecision 1ns;

   assign addr_out = addr_in;

   bit good_add = 1;
   initial begin
      if ($test$plusargs("BAD_ADD")) begin
	 good_add = 0;
	 $display("\n*********************************************");
	 $display("In %m");
	 $display("+BAD_ADD detected: ADD instructions will fail");
	 $display("*********************************************\n");
      end
   end

   always @(posedge clk, negedge reset_n) begin
      if (reset_n !== 1)
	result <= '0;
      else begin
	 case (opcode)
	   ADD:   result <= good_add ? (a + b) : (a - b);
	   SUB:   result <= a - b;
	   PASSA: result <= a;
	   PASSB: result <= b;
	   NEGA:  result <= 0 - a;
	   default: $warning("@%t: %m Unrecognized opcode=%s (0x%0x)", $realtime, opcode.name(), opcode);
	 endcase
//DBG	 $display("@%t: alu opc=%s (0x%x) a=0x%0x, b=0x%0x, result=0x%0x", $realtime, opc.name(), opcode, a, b, result);
      end
   end
endmodule : alu
