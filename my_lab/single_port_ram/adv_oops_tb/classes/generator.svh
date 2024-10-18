class Generator extends Component;
  Driver drv_h;
  address_t addr_q[$];

  Transaction blueprint_h;

  function new(Driver drv_h);
    this.drv_h = drv_h;
  endfunction

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
    drv_h.send(trans);
  endtask

  virtual task check(int n);
    foreach(addr_q[i])begin
      drv_h.send_check(addr_q[i]);
    end
  endtask
endclass
