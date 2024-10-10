module top;
  import ram_pkg::*;
  timeunit 1ns/1ns;
  logic clk,cs,we,oe;
  logic [ADDR_WIDTH-1:0] addr;
  logic [DATA_WIDTH-1:0] data_in;
  logic [DATA_WIDTH-1:0] data_out;

  tb_basic TEST(.*);
  DualPortRam DUT(.*);
  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end
  

endmodule
