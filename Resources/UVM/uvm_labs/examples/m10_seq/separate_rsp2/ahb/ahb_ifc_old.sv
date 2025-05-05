/***********************************************************************
 * Interface to connect to AHB DUT
 * Very simple AHB with a single master and single slave
 *
 * Provides send() and get*() methods for testbench
 * Methods are NOT reentrant and so are NOT declared automatic
 * Methods have semaphore to check if called concurrently, then $fatal
 *
 * Future improvements:
 * - Transfer struct instead of handle, for emulation
 * - Create BFM style, for emulation
 *
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

interface ahb_ifc();
  timeunit 1ns; timeprecision 1ns;

  import ahb_test_pkg::*;

  tri0 hready;
  logic ready; // Driven by BFM
  assign hready = ready;

  logic hwrite, hresp, hmastlock, hclk, hresetn;

  logic [1:0] htrans;
  logic [2:0] hsize, hburst;
  logic [3:0] hprot;

  AHB_ADDR4_T addr;
  logic [AHB_ADDR_WIDTH-1:0] haddr = addr;

  logic [AHB_DATA_WIDTH-1:0] hrdata;
  logic [AHB_DATA_WIDTH-1:0] hwdata;


  initial begin
    $monitor("@%t MON: hresetn=%b, hclk=%b, haddr=%0x, hwrite=%b, hrdata=%0x, hwdata=%0x, hready=%b, ready=%b", $realtime, hresetn, hclk, haddr, hwrite, hrdata, hwdata, hready, ready);
    #10ns;		// 10ns
    hresetn <= 0;	// negedge hresetn
    ready  <= 'z;	// Assume a single master and single slave
    hwrite <= '0;
    haddr  <= '0;
    hrdata <= 'z;
    hwdata <= '0;

    #10ns;		// 20ns
    hclk <= 0;		// After reset, start with posedge to send()

    #10ns;		// 30ns
    hresetn <= '1;

    #10ns;		// 40ns
    forever		// 50ns First posedge hclk
      #10ns hclk = !hclk;
  end


  // Drive a transaction out on negedge hclk. Assume no wait states, no overlap
  task automatic send(ahb_txn t);

    wait (hresetn===1);
//DBG    $display("@%t %m after @(negedge hclk): t=%s", $realtime, t.sprint());

    // Simple code can not have overlapping requests
    case (t.opcode)
      AHB_WRITE: begin
	@(posedge hclk);	// Address phase
	haddr  <= t.addr;
	htrans <= ahb_pkg::NONSEQ_HTRANS;
	hburst <= ahb_pkg::SINGLE_BURST;
	hsize  <= ahb_pkg::H32_SIZE;
	hwrite <= 1;
	ready <= 1;

	@(posedge hclk);	// Data phase start
	// Turn off control signals
	haddr  <= '0;
	hwrite <= '0;
	ready  <= '1;

	@(negedge hclk);	// Data phase drive
	hwdata <= t.data;

	@(negedge hclk);	// Data phase sample
	#1ns;
	hwdata <= 'z;
	ready <= 'z;
      end

      AHB_READ:	begin
	haddr  <= t.addr;
	hwrite <= 0;
	ready <= 1;

	@(negedge hclk);
	haddr  <= 'z;
	hwrite <= 'z;
	ready <= 'z;

	while (hready !== 1)
	  @(negedge hclk);
	t.data = hrdata;
      end

      default:
	$fatal(0, "Unrecognized AHB opcode %s (0x%0x)", t.opcode.name(), t.opcode);
    endcase

//DBG    $display("@%t %m final:, t=%s", $realtime, t.sprint());
  endtask


  // Block and get the next input transaction
  task automatic get_an_input(ahb_txn t);
    logic hwrite_sample;

    wait (hresetn===1);

    // Address phase
    do
      @(negedge hclk) #1ns;
    while (hready !== 1);
//DBG    $display("@%t %m: address phase", $realtime);
    hwrite_sample = hwrite;
    t.addr = haddr;
    t.opcode = (hwrite === 1) ? AHB_WRITE : AHB_READ;

    // Data phase
    do
      @(negedge hclk) #1ns;
    while (hready !== 1);

/*DBG*/    $display("@%t %m: data phase", $realtime);
    t.data = (hwrite_sample===1) ? hwdata : hrdata;
/*DBG*/    $display("@%t %m: t=%s", $realtime, t.sprint());

  endtask : get_an_input


  task automatic get_an_output(ahb_txn t);
    logic hwrite_sample;

    wait (hresetn===1);

    // Address phase
    do
      @(negedge hclk);
    while (hready !== 1);
    hwrite_sample = hwrite;
    t.addr = haddr;
    t.opcode = (hwrite_sample === 1) ? AHB_WRITE : AHB_READ;

    // Data phase
    do
      @(negedge hclk) #1ns;
    while (hready !== 1);
    t.data = (hwrite_sample===1) ? hwdata : hrdata;
    t.result = (hwrite_sample===1) ? hwdata : hrdata;
/*DBG*/    $display("@%t %m: t=%s", $realtime, t.sprint());

  endtask

endinterface : ahb_ifc
