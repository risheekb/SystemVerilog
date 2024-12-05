class Predictor extends Component;

  mailbox #(Transaction) mon_in_h,pred2scbd_h;
  Transaction expected_a[int];
  
  virtual task run(int n);
    repeat(n) begin
      Transaction trans_h;
      mon_in_h.get(trans_h);
      expected_a[trans_h.index]=trans_h;
    end
  endtask

  virtual task check(int n);
    foreach(expected_a[i]) begin
      Transaction trans_h;
      trans_h = expected_a[i];
      $display("%m %p",trans_h);
      pred2scbd_h.put(trans_h);
    end
  endtask
endclass
