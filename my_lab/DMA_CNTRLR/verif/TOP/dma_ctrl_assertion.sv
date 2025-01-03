
module dma_ctrl_assertion(clk,reset,scan_en,idle,INT,periph_tx_req,periph_tx_clr,periph_rx_req,periph_rx_clr,pclken,psel,penable,paddr,pwrite,pwdata,prdata,pslverr,pready,AWID0,AWADDR0,AWLEN0,AWSIZE0,AWVALID0,AWREADY0,WID0,WDATA0,WSTRB0,WLAST0,WVALID0,WREADY0,BID0,BRESP0,BVALID0,BREADY0,ARID0,ARADDR0,ARLEN0,ARSIZE0,ARVALID0,ARREADY0,RID0,RDATA0,RRESP0,RLAST0,RVALID0,RREADY0);
  `include "dma_axi64_defines.v"

  input                                clk;
  input                 reset;
  input                 scan_en;

  input                 idle;
  input [1-1:0]                INT;

  input [31:1]             periph_tx_req;
  input [31:1]             periph_tx_clr;
  input [31:1]             periph_rx_req;
  input [31:1]             periph_rx_clr;

  input                                pclken;
  input                                psel;
  input                                penable;
  input [12:0]                         paddr;
  input                                pwrite;
  input [31:0]                         pwdata;
  input [31:0]                        prdata;
  input                               pslverr;
  input                               pready;

  input [`ID_BITS-1:0]               AWID0;
  input [32-1:0]             AWADDR0;
  input [`LEN_BITS-1:0]              AWLEN0;
  input [`SIZE_BITS-1:0]      AWSIZE0;
  input                              AWVALID0;
  input                               AWREADY0;
  input [`ID_BITS-1:0]               WID0;
  input [64-1:0]             WDATA0;
  input [64/8-1:0]           WSTRB0;
  input                              WLAST0;
  input                              WVALID0;
  input                               WREADY0;
  input [`ID_BITS-1:0]                BID0;
  input [1:0]                         BRESP0;
  input                               BVALID0;
  input                              BREADY0;
  input [`ID_BITS-1:0]               ARID0;
  input [32-1:0]             ARADDR0;
  input [`LEN_BITS-1:0]              ARLEN0;
  input [`SIZE_BITS-1:0]      ARSIZE0;
  input                              ARVALID0;
  input                               ARREADY0;
  input [`ID_BITS-1:0]                RID0;
  input [64-1:0]              RDATA0;
  input [1:0]                         RRESP0;
  input                               RLAST0;
  input                               RVALID0;
  input                              RREADY0;
  
  //DEVELOPING APB ASSERTIONS
  property pslverr_p;
    @(posedge clk) 1 |-> (pslverr == 0);
  endproperty
  //penable and pready handshaking
  property penable_pready_handshake_p;
    @(posedge clk) (penable == 0 && psel == 1) |=> ##[0:5](pready == 1);
  endproperty
  PSLVERR_P: assert property (pslverr_p);
  PENABLE_PREADY_HANDSHAKE_P: assert property (penable_pready_handshake_p);
endmodule
