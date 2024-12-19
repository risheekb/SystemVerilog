`timescale 1ns/1ps 
module top;

  typedef class dma_common;
  typedef class dma_env;
  typedef class dma_ckr;
  typedef class dma_ref;
  typedef class apb_tx;
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
  `include "axi_mon.sv"
  `include "dma_env.sv"
  `include "dma_ref.sv"
  `include "dma_ckr.sv"
  reg clk,reset;

  dma_env env;
  initial begin
    clk = 0;
    forever #1.25 clk = ~clk; //2.5ns => 400 MHz
  end

  initial begin 
    reset = 1'b1;
    repeat(2) @(posedge clk);
    reset = 1'b0;
    env = new();
    env.run();
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

  
  //DUT INSTANTIATION
 dma_axi64 DUT (
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
   .AWID0(axi_pif.AWID0),
   .AWADDR0(axi_pif.AWADDR0),
   .AWLEN0(axi_pif.AWLEN0),
   .AWSIZE0(axi_pif.AWSIZE0),
   .AWVALID0(axi_pif.AWVALID0),
   .AWREADY0(axi_pif.AWREADY0),
   .WID0(axi_pif.WID0),
   .WDATA0(axi_pif.WDATA0),
   .WSTRB0(axi_pif.WSTRB0),
   .WLAST0(axi_pif.WLAST0),
   .WVALID0(axi_pif.WVALID0),
   .WREADY0(axi_pif.WREADY0),
   .BID0(axi_pif.BID0),
   .BRESP0(axi_pif.BRESP0),
   .BVALID0(axi_pif.BVALID0),
   .BREADY0(axi_pif.BREADY0),
   .ARID0(axi_pif.ARID0),
   .ARADDR0(axi_pif.ARADDR0),
   .ARLEN0(axi_pif.ARLEN0),
   .ARSIZE0(axi_pif.ARSIZE0),
   .ARVALID0(axi_pif.ARVALID0),
   .ARREADY0(axi_pif.ARREADY0),
   .RID0(axi_pif.RID0),
   .RDATA0(axi_pif.RDATA0),
   .RRESP0(axi_pif.RRESP0),
   .RLAST0(axi_pif.RLAST0),
   .RVALID0(axi_pif.RVALID0),
   .RREADY0(axi_pif.RREADY0));
  //CLOCK GENERTAION
  //RESET
  //ASSERTION MODULE INSTANTIATION
  //LOGIC TO END THE SIMULATION
  initial begin
    #1000; //TODO
    $finish;
  end
endmodule
