class Monitor extends Component;
  virtual ram_interface vif;
  Scoreboard scbd_h;
  Transaction trans;

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
      scbd_h.add_input(trans);
    end
  endtask

  virtual task check(int n);
    for(int i = 0; i< n;i++) begin
      @(posedge vif.clk ) #1ns;
      wait(vif.data_out)begin
        scbd_h.check_output(vif.data_out,vif.addr);
        //$display("%0t %m Entering Monitor::check data_out:%0d iteration =%0d",$realtime,vif.data_out,i);
      end
    end
  endtask
endclass
