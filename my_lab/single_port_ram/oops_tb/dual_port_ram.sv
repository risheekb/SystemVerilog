module DualPortRam
  import ram_pkg::*;
  (ram_interface inf);
  logic [DATA_WIDTH-1:0] MEM [DEPTH];

  always_ff @(posedge inf.clk) begin
    if(inf.cs & inf.we)
      MEM[inf.addr] <= inf.data_in;
    if($test$plusargs("FORCE_LOAD_ERROR")) //NON RTL FEATURE TO CHECK TB
      MEM[inf.addr] <= $random;
  end

  always_ff @(posedge inf.clk) begin
    if(inf.cs & !inf.we & inf.oe)
      inf.data_out <= MEM[inf.addr];
    else
      inf.data_out <= 'hz;
  end

endmodule

