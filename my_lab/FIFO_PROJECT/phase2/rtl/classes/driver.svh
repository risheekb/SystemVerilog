class Driver extends Component;

  virtual fifo_inf vif;
  mailbox #(Transaction) stim2drv_h;

  function new(virtual fifo_inf vif);
    this.vif = vif;
  endfunction

  virtual task reset();
    $display("Applying reset to the FIFO...");
    vif.reset <= 1;    //async reset
    repeat(3) @(posedge vif.clk);
    vif.reset <= 0;

    vif.clear = 1'b0;
    vif.read = 1'b0;
    vif.write = 1'b0;
    vif.data_in = '0;
  endtask

  virtual task run(int n);
    repeat(n) begin
      Transaction trans_h;
      stim2drv_h.get(trans_h);
      send_transaction(trans_h);
    end
  endtask

  virtual task run_invalid(int n);
    repeat(n) begin
      Transaction trans_h;
      stim2drv_h.get(trans_h);
      send_invalid(trans_h);
    end
  endtask

  virtual task send_transaction(Transaction trans_h);
    @(posedge vif.clk);
    vif.data_in = trans_h.data;
    vif.write = 1'b1;
    vif.read = 1'b0;
    @(posedge vif.clk);
    vif.write = 1'b0;
  endtask

  virtual task send_invalid(Transaction trans_h);
    @(posedge vif.clk);
    vif.data_in = trans_h.data;
    vif.write = 1'b1;
    vif.read = 1'b1;
    @(posedge vif.clk);
    vif.write = 1'b0;
    vif.read = 1'b0;
  endtask

  virtual task check(int n);
    repeat(n) begin
      Transaction trans_h;
      stim2drv_h.get(trans_h);
      check_transaction(trans_h);
    end
  endtask
  
  virtual task check_invalid(int n);
    repeat(n) begin
      check_invalid_transaction();
    end
  endtask
  
  virtual task check_transaction(Transaction trans_h);
    @(posedge vif.clk);
    vif.read = 1'b1;
    vif.write = 1'b0;
    @(posedge vif.clk);
    vif.read = 1'b0;
    #5;
    //wait(vif.data_out);
    trans_h.data = vif.data_out;
  endtask

  virtual task check_invalid_transaction();
    @(posedge vif.clk);
    vif.read = 1'b1;
    vif.write = 1'b1;
    @(posedge vif.clk);
    vif.read = 1'b0;
    vif.write = 1'b0;

  endtask

  virtual task clear();
    @(posedge vif.clk);
    vif.clear = 1'b1;
    @(posedge vif.clk);
    vif.clear = 1'b0;
  endtask

endclass
