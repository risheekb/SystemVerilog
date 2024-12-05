module top;
  import fifo_pkg::*;
  import fifo_tst_pkg::*;

    
  logic clk;

  fifo_inf inf(.clk(clk));
  
  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end


 fifo #(DEPTH,WIDTH) DUT (  //Instantiating the DUT
   .clk(clk),
   .clear(inf.clear),
   .write(inf.write),
   .read(inf.read),
   .reset(inf.reset),
   .data_in(inf.data_in),
   .full(inf.full),
   .almost_full(inf.almost_full),
   .empty(inf.empty),
   .almost_empty(inf.almost_empty),
   .cnt(inf.cnt),
   .data_out(inf.data_out)
);


initial run_test(inf);


endmodule: top
