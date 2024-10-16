class Generator;
  Driver drv_h;
  address_t addr_q[$];

  function new(Driver drv_h);
    this.drv_h = drv_h;
  endfunction

  task run(int n);
    Transaction trans;
    for(int i = 0; i < n ;i++)begin
      trans = new();
      trans.randomize_transaction();
      trans.print_transaction();
      trans.addr = i;
      send(trans);
      addr_q.push_back(trans.addr);

    end
  endtask

  task send(Transaction trans);
    drv_h.run(trans);
  endtask

  task check();
    foreach(addr_q[i])begin
      drv_h.send_check(addr_q[i]);
    end
  endtask
endclass
