class Generator extends Component;
  Driver drv_h;
  address_t addr_q[$];

  Transaction blueprint_h;

  mailbox #(Transaction) gen2drv_h;


  virtual task build;
    blueprint_h = new();
  endtask

  virtual task run(int n);
    Transaction trans;
    for(int i = 0; i < n ;i++)begin
      trans = blueprint_h.clone();
      trans.randomize_transaction();
      trans.print_transaction();
      trans.addr = i;
      send(trans);
      addr_q.push_back(trans.addr);

    end
  endtask

  task send(Transaction trans);
    gen2drv_h.put(trans);
    //drv_h.send(trans);
  endtask

  virtual task check(int n);
    foreach(addr_q[i])begin
      Transaction trans_h;
      trans_h = new();
      trans_h.addr = addr_q[i];
      gen2drv_h.put(trans_h);
      //drv_h.send_check(addr_q[i]);
    end
  endtask
endclass
