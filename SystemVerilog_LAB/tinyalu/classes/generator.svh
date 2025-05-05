class Generator extends Component;

  Driver drv_h;
  Transaction expect_q[$];
  Transaction blueprint_h;

  mailbox #(Transaction) gen2drv_h;
  
  virtual task build;
    blueprint_h = new();
  endtask


  virtual task run(int n);
    Transaction trans_h;
    for(int i = 0; i<n;i++) begin
      trans_h = blueprint_h.clone();
      //trans_h.randomize_transaction();
      if(!trans_h.randomize())
        $fatal(0,"Randomization Failed!!");
      trans_h.print_transaction();
      gen2drv_h.put(trans_h);
      expect_q.push_back(trans_h);
    end
  endtask

  virtual task check(int n);
    foreach(expect_q[i]) begin
      Transaction trans_h;
      trans_h = new();
      trans_h = expect_q[i];
      gen2drv_h.put(trans_h);
    end
  endtask

endclass
