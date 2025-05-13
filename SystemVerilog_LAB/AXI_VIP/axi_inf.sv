interface axi_inf(input logic aclk,arst);

  //WRITE ADDRESS CHANNEL
  logic [31:0] awaddr;
  logic [3:0] awid;
  logic [3:0] awlen;
  logic [2:0] awsize;
  logic [1:0] awburst;
  logic [1:0] awlock;
  logic [3:0] awcache;
  logic [2:0] awprot;
  logic awvalid;
  logic awready;
  
  //WRITE DATA CHANNEL
  logic [3:0] wid;
  logic [63:0] wdata;
  logic [3:0] wstrb;
  logic wlast;
  logic wvalid;
  logic wready;

  //WRITE RESP CHANNEL
  logic [3:0] bid;
  logic [1:0] bresp;
  logic bready;
  logic bvalid;

  //READ ADDRESS CHANNEL
  logic [31:0] araddr;
  logic [3:0] arid;
  logic [3:0] arlen;
  logic [2:0] arsize;
  logic [1:0] arburst;
  logic [1:0] arlock;
  logic [3:0] arcache;
  logic [2:0] arprot;
  logic arvalid;
  logic arready;
  
  //READ DATA CHANNEL
  logic [3:0] rid;
  logic [63:0] rdata;
  logic rlast;
  logic rvalid;
  logic rready;
  logic [1:0] rresp;


  //clocking master_cb @(posedge aclk);
  //  default input #1 output #0;
  //  input aclk;
  //  input arst;
  //  output awaddr;
  //  output awid;
  //  output awlen;
  //  output awsize;
  //  output awburst;
  //  output awlock;
  //  output awcache;
  //  output awprot;
  //  output awvalid;
  //  input awready;

  //  output wid;
  //  output wdata;
  //  output wstrb;
  //  output wlast;
  //  output wvalid;
  //  input wready;
  //
  //  input bid;
  //  input bresp;
  //  output bready;
  //  input bvalid;
  //
  //  output araddr;
  //  output arid;
  //  output arlen;
  //  output arsize;
  //  output arburst;
  //  output arlock;
  //  output arcache;
  //  output arprot;
  //  output arvalid;
  //  input arready;

  //  input  rid;
  //  input rdata;
  //  input rlast;
  //  input rvalid;
  //  output rready;
  //  input rresp;
  //endclocking

  //clocking  monitor_cb @(posedge aclk);
  //  default input #1;
  //  input aclk;
  //  input arst;
  //  input awaddr;
  //  input awid;
  //  input awlen;
  //  input awsize;
  //  input awburst;
  //  input awlock;
  //  input awcache;
  //  input awprot;
  //  input awvalid;
  //  input awready;

  //  input wid;
  //  input wdata;
  //  input wstrb;
  //  input wlast;
  //  input wvalid;
  //  input wready;
  //
  //  input bid;
  //  input bresp;
  //  input bready;
  //  input bvalid;
  //
  //  input araddr;
  //  input arid;
  //  input arlen;
  //  input arsize;
  //  input arburst;
  //  input arlock;
  //  input arcache;
  //  input arprot;
  //  input arvalid;
  //  input arready;

  //  input  rid;
  //  input rdata;
  //  input rlast;
  //  input rvalid;
  //  input rready;
  //  input rresp;
  //endclocking

  //modport master_mp(clocking master_cb);
  //modport monitor_mp(clocking monitor_cb);
endinterface
