interface tx_ifc(input logic clk,reset_n);
  logic [7:0] d;
  logic [7:0] q;

  import uvm_pkg::*;
  import tx_pkg::*;

  always @(negedge reset_n) begin
    d = 0;
  end
  
  task send(input tx_item tx);
    wait(reset_n === 1'b1);
    @(negedge clk);
    d = tx.data;
  endtask

  task get_an_input(output tx_item tx);
    tx = tx_item::type_id::create();
    wait(reset_n === 1'b1);
    @(negedge clk);
    #1ns;
    tx.data = d;
  endtask

  task get_an_output(output tx_item tx);
    tx = tx_item::type_id::create();
    wait(reset_n === 1'b1);
    @(negedge clk);
    @(posedge clk);
    #1ns;
    tx.data = q;
  endtask

  task automatic wait_for_reset();
    @(posedge clk);
    wait(reset_n === 1'b1);
  endtask

  task automatic wait_num_clks(input int unsigned n);
    @(posedge clk);
    repeat(n-1)
    @(posedge clk);
  endtask
endinterface
