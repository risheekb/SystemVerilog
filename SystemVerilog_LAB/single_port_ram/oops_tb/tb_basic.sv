module tb_basic
  import ram_pkg::*;
  (ram_interface inf);
  typedef class Transaction;
  `include "classes/transaction.svh"
  timeunit 1ns/1ns; 


  initial begin
    $display("Writing into ram");
    randomize_send();
    read();
    $finish();
  end

  task randomize_send();
    Transaction trans;
    for(int i = 0;i<DEPTH;i++)begin
      trans = new();
      trans.addr = i;
      trans.randomize_transaction();
      trans.print_transaction();
      write(trans);
    end
  endtask

  task write(Transaction trans);
    @(posedge inf.clk) #1ns
    inf.cs <= 1'b1;
    inf.we <= 1'b1;
    inf.addr <= trans.addr;
    inf.data_in <= trans.data_in;
      #5ns;
      @(posedge inf.clk) #1ns
      inf.cs <= 1'b0;
      inf.we <= 1'b0;
      $display("@ location %0d value = %0d",inf.addr,inf.data_in);
  endtask
  task read();
    $display("Reading from the ram");
    for(int i = 0;i<DEPTH;i++)begin
      @(posedge inf.clk) #1ns;
      inf.cs <= 1;
      inf.we <= 0;
      inf.oe <= 1;
      inf.addr <= i;
      #5ns
      @(posedge inf.clk) #1ns;
      inf.cs <= 0;
      $display("@ location %0d value = %0d",inf.addr,inf.data_out);
    end
  endtask

endmodule
