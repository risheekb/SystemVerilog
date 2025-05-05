class Monitor extends Component;

  virtual fifo_inf vif;
  Scoreboard scbd_h;

  mailbox #(Transaction) mon_in_h,mon_out_h;

  function new(virtual fifo_inf vif);
    this.vif = vif;
  endfunction

  virtual task run(int n);
    Transaction trans_h;
    for(int i = 0; i<n;i++) begin
      trans_h = new();
      @(posedge vif.write) #1ns;
      trans_h.data = vif.data_in;
      trans_h.index = i;
      mon_in_h.put(trans_h);
    end
  endtask

  virtual task check(int n);
    Transaction trans_h;
    for(int i = 0; i < n;i++) begin
      trans_h = new();
      @(negedge vif.read) #1ns;
      wait(vif.data_out);
      trans_h.data = vif.data_out;
      trans_h.index = i;
      $display("OUTPUT::");
      trans_h.print_transaction();
      mon_out_h.put(trans_h);
    end
  endtask
endclass

