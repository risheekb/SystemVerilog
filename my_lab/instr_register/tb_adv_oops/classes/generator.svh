class Generator extends Component;
  index_t index_q[$];
  Driver drv_h;
  Transaction blueprint_h;
  
  function new(Driver drv_h);
    this.drv_h = drv_h; 
  endfunction
  
  virtual task build();
    blueprint_h = new();
  endtask

  virtual task run(int n);
    Transaction trans_h;
    for(int i = 0; i< n; i++) begin
      trans_h=blueprint_h.clone();
      trans_h.randomize_transaction();
      trans_h.index = i;
      send(trans_h);
      trans_h.print_transaction();
      index_q.push_back(trans_h.index);
    end
    //$display("%m %p",index_q);
  endtask

  virtual task send(Transaction trans_h);
    drv_h.send(trans_h);
  endtask

  virtual task check(int n);
    //$display("%m %p",index_q);
    foreach(index_q[i])
      drv_h.send_check(index_q[i]);
  endtask

endclass
