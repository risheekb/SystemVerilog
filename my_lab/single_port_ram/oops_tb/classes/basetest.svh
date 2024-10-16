class BaseTest;
  Driver drv_h;
  Generator gen_h;
  Monitor mon_h;
  Scoreboard scbd_h;
  virtual ram_interface vif;

  function new(virtual ram_interface vif);
    this.vif = vif;
    drv_h = new(vif);
    gen_h = new(drv_h);
    scbd_h = new();
    mon_h = new(vif,scbd_h);
  endfunction

  task run(int n);
    $display("Loading the memory ...");
    fork
      gen_h.run(n);
      mon_h.run(n);
    join
  endtask
  task check(int n);
    $display("Reading the memory ... ");
    fork
      gen_h.check();
      mon_h.check(n);
    join
  endtask

endclass
