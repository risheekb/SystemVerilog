interface ram_interface
  import ram_pkg::*;
  (input logic clk);
  address_t addr;
  data_t data_in;
  logic cs;
  logic we;
  logic oe;
  data_t data_out;

endinterface
