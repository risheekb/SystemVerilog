class Driver extends Component;

  mailbox #(Transaction) gen2drv_h;


  virtual ram_interface vif;
  function new(virtual ram_interface vif);
    this.vif = vif;
  endfunction

  virtual task run(int n);
    repeat(n) begin
      Transaction trans_h;
      gen2drv_h.get(trans_h);
      send(trans_h);
    end
  endtask


  task send(Transaction trans); //write the data into memory
    @(posedge vif.clk) #1ns
    vif.cs <= 1'b1;
    vif.we <= 1'b1;
    vif.addr <= trans.addr;
    vif.data_in <= trans.data_in;
    #5ns;
    @(posedge vif.clk) #1ns
    vif.cs <= 1'b0;
    vif.we <= 1'b0;

  endtask

  virtual task check(int n);
    repeat(n) begin
      Transaction trans_h;
      gen2drv_h.get(trans_h);
      send_check(trans_h.addr);
    end
  endtask

  task send_check(address_t addr); //read the data

    @(posedge vif.clk) #1ns;
    vif.cs <= 1;
    vif.we <= 0;
    vif.oe <= 1;
    vif.addr <= addr;
    #5ns
    @(posedge vif.clk) #1ns;
    vif.cs <= 0;
    $display("%m :: @%h %h",vif.addr,vif.data_out);
  endtask
endclass

