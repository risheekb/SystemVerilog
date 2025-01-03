interface axi_inf(input clk,reset);

  bit [`ID_BITS-1:0]               awid;
  bit [32-1:0]                     awaddr;
  bit [`LEN_BITS-1:0]              awlen;
  bit [`SIZE_BITS-1:0]             awsize;
  bit                              awvalid;
  bit                              awready;
  bit [`ID_BITS-1:0]               wid;
  bit [64-1:0]                     wdata;
  bit [64/8-1:0]                   wstrb;
  bit                              wlast;
  bit                              wvalid;
  bit                              wready;
  bit [`ID_BITS-1:0]               bid;
  bit [1:0]                        bresp;
  bit                              bvalid;
  bit                              bready;
  bit [`ID_BITS-1:0]               arid;
  bit [32-1:0]                     araddr;
  bit [`LEN_BITS-1:0]              arlen;
  bit [`SIZE_BITS-1:0]             arsize;
  bit                              arvalid;
  bit                              arready;
  bit [`ID_BITS-1:0]               rid;
  bit [64-1:0]                     rdata;
  bit [1:0]                        rresp;
  bit                              rlast;
  bit                              rvalid;
  bit                              rready;

  clocking slave_cb @(posedge clk);
    default input #0;
    default output #1;
    input                         reset;
    input                         awid;
    input                         awaddr;
    input                         awlen;
    input                         awsize;
    input                         awvalid;
    output                        awready;
    input                         wid;
    input                         wdata;
    input                         wstrb;
    input                         wlast;
    input                         wvalid;
    output                        wready;
    output                        bid;
    output                        bresp;
    output                        bvalid;
    input                         bready;
    input                         arid;
    input                         araddr;
    input                         arlen;
    input                         arsize;
    input                         arvalid;
    output                        arready;
    output                        rid;
    output                        rdata;
    output                        rresp;
    output                        rlast;
    output                        rvalid;
    input                         rready;
  endclocking

  clocking monitor_cb @(posedge clk);
    default input #0;
    input                         reset;
    input                         awid;
    input                         awaddr;
    input                         awlen;
    input                         awsize;
    input                         awvalid;
    input                        awready;
    input                         wid;
    input                         wdata;
    input                         wstrb;
    input                         wlast;
    input                         wvalid;
    input                        wready;
    input                        bid;
    input                        bresp;
    input                        bvalid;
    input                         bready;
    input                         arid;
    input                         araddr;
    input                         arlen;
    input                         arsize;
    input                         arvalid;
    input                        arready;
    input                        rid;
    input                        rdata;
    input                        rresp;
    input                        rlast;
    input                        rvalid;
    input                         rready;
  endclocking

  modport slave_mp(clocking slave_cb);
  modport monitor_mp(clocking monitor_cb);
endinterface
