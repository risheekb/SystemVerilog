/***********************************************************************
 * AHB Slave: Design Under Test for the example of configuring a virtual sequence
 * Simple memory, variable address range
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

module ahb_slave_mem
  import ahb_pkg::*;
  #(parameter bit [31:0] ADDR_LO = 0, ADDR_HI = 32'hFFFF, ID=0)
  (ahb_ifc ifc);

  timeunit 1ns; timeprecision 1ns;

  localparam AHB_ADDR2_T ADDR_SIZE = ADDR_HI - ADDR_LO;

  AHB_DATA4_T memory[ADDR_SIZE];
  AHB_ADDR4_T addr_in = 0;
  logic hready0 = 'z;	// Start on the correct value
  assign ifc.hready = hready0;

  // Print configuration
  initial $display("@%t %m configuration: ADDR_LO=0x%0x, ADDR_HI=0x%0x, ID=%0x", $realtime, ADDR_LO, ADDR_HI, ID);

  // Decode transactions
  always @(posedge ifc.hclk, negedge ifc.hresetn) begin
    if (ifc.hresetn === 1) begin : HCLK
      if (ifc.hready === 1) begin : READY
	if (ifc.haddr inside {[ADDR_LO : ADDR_HI]}) begin : ADDR
	  addr_in = ifc.haddr;     // Sample address
	  if (ifc.hwrite) begin : WRITE
	    do
	      @(posedge ifc.hclk); // Sample point in data cycle
	    while (ifc.hready !== 1);
	    memory[addr_in - ADDR_LO] = ifc.hwdata;
	    $display("@%t AHB_MEM%0d WR: mem[%0x] = %x (ADDR_LO=%0x)",
		     $realtime, ID, addr_in, memory[addr_in - ADDR_LO], ADDR_LO);
	  end : WRITE

	  else begin : READ
	    @(negedge ifc.hclk);
	    ifc.hrdata <= memory[addr_in - ADDR_LO];
	    hready0 = 1;
	    $display("@%t AHB_MEM%0d RD: %x = mem[%0x] (ADDR_LO=%0x)",
		     $realtime, ID, addr_in, memory[addr_in - ADDR_LO], ADDR_LO);
	    @(negedge ifc.hclk);
	    ifc.hrdata <= 'z;
	    hready0 = 'z;
	  end : READ
	end : ADDR
      end : READY
    end : HCLK

    else begin : RST
      ifc.hrdata <= 'z;
      hready0 = 'z;
    end : RST
  end // always

endmodule : ahb_slave_mem
