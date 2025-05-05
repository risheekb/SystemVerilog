package ram_pkg;
  parameter DEPTH = 4;
  parameter ADDR_WIDTH = $clog2(DEPTH);
  parameter DATA_WIDTH = 32;

  typedef logic [ADDR_WIDTH-1:0] address_t;
  typedef logic [DATA_WIDTH-1:0] data_t;

endpackage
