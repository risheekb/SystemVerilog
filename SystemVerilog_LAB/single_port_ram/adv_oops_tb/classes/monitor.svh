class Monitor extends Component;
  virtual ram_interface vif;
  Scoreboard scbd_h;
  Transaction trans;

  mailbox #(Transaction) mon_in_h,mon_out_h;

  function new(virtual ram_interface vif,Scoreboard scbd_h);
    this.vif = vif;
    this.scbd_h =scbd_h;
  endfunction

  virtual task run(int n);
    repeat(n) begin
      trans = new();
      @(posedge vif.we) #1ns
      trans.addr = vif.addr;
      trans.data_in = vif.data_in;

      mon_in_h.put(trans);
      //scbd_h.add_input(trans);
    end
  endtask

  virtual task check(int n);
    for(int i = 0; i< n;i++) begin
      Transaction trans_h;
      trans_h = new();
      @(posedge vif.clk ) #1ns;
      wait(vif.data_out)begin
        trans_h.addr = vif.addr;
        trans_h.data_in = vif.data_out;
        mon_out_h.put(trans_h);
        //scbd_h.check_output(vif.data_out,vif.addr);
        //$display("%0t %m Entering Monitor::check data_out:%0d iteration =%0d",$realtime,vif.data_out,i);
        //scbd_h.check_output(vif.data_out,vif.addr);
      end
    end
  endtask
endclass
