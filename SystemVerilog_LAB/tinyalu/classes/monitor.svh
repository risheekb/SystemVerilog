class Monitor extends Component;
  virtual alu_interface vif;
  Scoreboard scbd_h;

  mailbox #(Transaction) mon_in_h,mon_out_h;

  function new(virtual alu_interface vif);
    this.vif = vif;
  endfunction

  virtual task run(int n);
    Transaction trans;
    repeat(n) begin
      trans = new();
      @(posedge vif.start)#1ns; //At the rise of the start signal grab the inputs
      trans.A = vif.A;
      trans.B = vif.B;
      trans.opcode = vif.opcode;
      @(posedge vif.done )#1ns; //At the rise of the done signal grab the output 
      trans.result = vif.result;
      mon_in_h.put(trans);
    end
  endtask

  virtual task check(int n);
    Transaction trans_h;
    trans_h = new();
    mon_out_h.put(trans_h);
  endtask

endclass
