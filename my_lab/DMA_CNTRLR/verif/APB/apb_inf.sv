interface apb_inf(input clk,reset);

  bit                               pclken;
  bit                               psel;
  bit                               penable;
  bit [12:0]                        paddr;
  bit                               pwrite;
  bit [31:0]                        pwdata;
  bit [31:0]                        prdata;
  bit                               pslverr;
  bit                               pready;
  bit                 scan_en;

  bit [1-1:0]                INT;
  bit                 idle;

  clocking master_cb @(posedge clk);
    default input #0;
    default output #1;
    input                          pclken;
    input                          psel;
    input                          penable;
    input                          paddr;
    input                          pwrite;
    input                          pwdata;
    output                         prdata;
    output                         pslverr;
    output                         pready;
    input                 scan_en;
    output                 idle;
    output                 INT;
  endclocking

  clocking monitor_cb @(posedge clk);
    default input #0;
    input                          pclken;
    input                          psel;
    input                          penable;
    input                          paddr;
    input                          pwrite;
    input                          pwdata;
    input                         prdata;
    input                         pslverr;
    input                         pready;
    input                 scan_en;
    input                 idle;
    input                 INT;
  endclocking

  modport master_mp(clocking master_cb);
    modport monitor_mp(clocking monitor_cb);


endinterface
