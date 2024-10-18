class BaseTest extends Component;
  Driver drv_h;
  Generator gen_h;
  Monitor mon_h;
  Scoreboard scbd_h;
  virtual ram_interface vif;

  function new(virtual ram_interface vif);
    this.vif = vif;
  endfunction
  virtual task build;
    drv_h = new(vif);
    gen_h = new(drv_h);
    scbd_h = new();
    mon_h = new(vif,scbd_h);

    drv_h.build();
    gen_h.build();
    scbd_h.build();
    mon_h.build();
  endtask

  virtual task reset;
    drv_h.reset();
    gen_h.reset();
    scbd_h.reset();
    mon_h.reset();
  endtask

  virtual task run(int n);
    $display("Loading the memory ...");
    fork
      drv_h.run(n);
      gen_h.run(n);
      mon_h.run(n);
      scbd_h.run(n);
    join
  endtask
  virtual task check(int n);
    $display("Reading the memory ... ");
    fork
      drv_h.check(n);
      gen_h.check(n);
      mon_h.check(n);
      scbd_h.check(n);
    join
  endtask

endclass
