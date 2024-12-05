interface fifo_inf(input clk);
  import fifo_pkg::*;

  logic clear;
  logic write;
  logic read;
  logic reset;
  data_t data_in;
  logic full;
  logic almost_full;
  logic empty;
  logic almost_empty;
  counter_t cnt;
  data_t data_out;

endinterface
