module tb_basic
  import ram_pkg::*;
  (output logic cs,we,oe,
    output logic [ADDR_WIDTH-1:0] addr,
    output logic [DATA_WIDTH-1:0] data_in,
    input logic [DATA_WIDTH-1:0] data_out,
    input logic clk);

  timeunit 1ns/1ns; 


  initial begin
      write();
      read();
    $finish();
  end

  task write();
    $display("Writing into ram");
    for(int i = 0;i<DEPTH;i++) begin
      @(posedge clk) #1ns
      cs <= 1'b1;
      we <= 1'b1;
      addr <= i;
      data_in <= $urandom_range(1,100);
      #5ns;
      @(posedge clk) #1ns
      cs <= 1'b0;
      we <= 1'b0;
      $display("@ location %0d value = %0d",addr,data_in);
    end
  endtask
  task read();
    $display("Reading from the ram");
    for(int i = 0;i<DEPTH;i++)begin
      @(posedge clk) #1ns;
      cs <= 1;
      we <= 0;
      oe <= 1;
      addr <= i;
      #5ns
      @(posedge clk) #1ns;
      cs <= 0;
      $display("@ location %0d value = %0d",addr,data_out);
    end
  endtask

endmodule
