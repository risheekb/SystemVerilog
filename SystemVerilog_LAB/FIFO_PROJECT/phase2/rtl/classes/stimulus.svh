class Stimulus extends Component;

  mailbox #(Transaction) stim2drv_h;

  Transaction blueprint_h;

  virtual task build;
    blueprint_h = new();
  endtask

  virtual task run(int n);
    for(int i = 0; i< n;i++) begin
      Transaction trans_h;
      trans_h = blueprint_h.clone();
      assert(trans_h.randomize())
      //$display(" %m :: Randomization Failed");
      trans_h.index = i;
      trans_h.print_transaction();
      stim2drv_h.put(trans_h);
    end
  endtask

  virtual task check(int n);
    for(int i =0;i<n;i++) begin
      Transaction trans_h;
      trans_h = new();
      trans_h.index = i;
      stim2drv_h.put(trans_h);
    end
  endtask
endclass
