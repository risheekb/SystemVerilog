`timescale 1ns/1ps 
module top;

  typedef class dma_common;
  typedef class dma_ctrl_reg_block;
  typedef class dma_env;
  typedef class dma_ckr;
  typedef class dma_ref;
  typedef class apb_tx;
  typedef class axi_tx;
  typedef class apb_env;
  typedef class apb_bfm;
  typedef class apb_gen;
  typedef class apb_mon;
  typedef class apb_cov;
  typedef class axi_env;
  typedef class axi_responder;
  typedef class axi_mon;
  `include "dma.svh"
  `include "apb_tx.sv"
  `include "axi_tx.sv"
  `include "apb_inf.sv"
  `include "axi_inf.sv"
  `include "periph_inf.sv"
  `include "dma_common.sv"
  `include "apb_env.sv"
  `include "apb_bfm.sv"
  `include "apb_gen.sv"
  `include "apb_mon.sv"
  `include "apb_cov.sv"
  `include "axi_env.sv"
  `include "axi_responder.sv"
  `include "dma_ctrl_reg_block.sv"
  `include "axi_mon.sv"
  `include "dma_env.sv"
  `include "dma_ref.sv"
  `include "dma_ckr.sv"
  reg clk,reset;
  dma_common dma_common_h = new();
 dma_axi64 dut(
   .clk(apb_pif.clk),
   .reset(apb_pif.reset),
   .scan_en(apb_pif.scan_en),
   .idle(apb_pif.idle),
   .INT(apb_pif.INT),
   .periph_tx_req(periph_pif.periph_rx_req),
   .periph_tx_clr(periph_pif.periph_tx_clr),
   .periph_rx_req(periph_pif.periph_rx_req),
   .periph_rx_clr(periph_pif.periph_rx_clr),
   .pclken(apb_pif.pclken),
   .psel(apb_pif.psel),
   .penable(apb_pif.penable),
   .paddr(apb_pif.paddr),
   .pwrite(apb_pif.pwrite),
   .pwdata(apb_pif.pwdata),
   .prdata(apb_pif.prdata),
   .pslverr(apb_pif.pslverr),
   .pready(apb_pif.pready),
   .AWID0(axi_pif.awid),
   .AWADDR0(axi_pif.awaddr),
   .AWLEN0(axi_pif.awlen),
   .AWSIZE0(axi_pif.awsize),
   .AWVALID0(axi_pif.awvalid),
   .AWREADY0(axi_pif.awready),
   .WID0(axi_pif.wid),
   .WDATA0(axi_pif.wdata),
   .WSTRB0(axi_pif.wstrb),
   .WLAST0(axi_pif.wlast),
   .WVALID0(axi_pif.wvalid),
   .WREADY0(axi_pif.wready),
   .BID0(axi_pif.bid),
   .BRESP0(axi_pif.bresp),
   .BVALID0(axi_pif.bvalid),
   .BREADY0(axi_pif.bready),
   .ARID0(axi_pif.arid),
   .ARADDR0(axi_pif.araddr),
   .ARLEN0(axi_pif.arlen),
   .ARSIZE0(axi_pif.arsize),
   .ARVALID0(axi_pif.arvalid),
   .ARREADY0(axi_pif.arready),
   .RID0(axi_pif.rid),
   .RDATA0(axi_pif.rdata),
   .RRESP0(axi_pif.rresp),
   .RLAST0(axi_pif.rlast),
   .RVALID0(axi_pif.rvalid),
   .RREADY0(axi_pif.rready));
  dma_env env;
  initial begin
    clk = 0;
    forever #1.25 clk = ~clk; //2.5ns => 400 MHz
  end

  

  //INTERFACE INSTANTIATION
  axi_inf axi_pif(clk,reset);
  apb_inf apb_pif(clk,reset);
  periph_inf periph_pif(clk,reset);

  initial begin
    dma_common::axi_vif = axi_pif;
    dma_common::apb_vif = apb_pif;
    dma_common::periph_vif = periph_pif;
  end

   initial begin 
    reset = 1'b1;
     dma_common::dut_reset_applied = 1;
    repeat(2) @(posedge clk);
    reset = 1'b0;
     dma_common::dut_reset_applied = 0;
    $value$plusargs("test_name=%s",dma_common::test_name);

    env = new();
    env.run();
  end
  
  //DUT INSTANTIATION
  //CLOCK GENERTAION
  //RESET
  //ASSERTION MODULE INSTANTIATION
  //LOGIC TO END THE SIMULATION
  initial begin
    fork
     wait(dma_common::txn_driv == dma_common::txn_gen);
      #2000;
    join_any
    disable fork;
    #100;
     $display("Total Transactions Generated : %0d",dma_common::txn_gen);
    $display("Total Transactions Driven : %0d",dma_common::txn_driv);
    $display("ERROR Count: %0d",dma_common::error_count);

    $finish;
  end
endmodule
