package fifo_pkg;
  parameter DEPTH = 8;
  parameter WIDTH = 32;
  
  typedef logic [WIDTH-1:0] data_t;
  typedef logic [$clog2(DEPTH):0] counter_t;
  typedef logic [$clog2(DEPTH)-1:0] index_t;
endpackage
