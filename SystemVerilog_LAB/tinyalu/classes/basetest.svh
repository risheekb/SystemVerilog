class BaseTest extends Component;
  virtual alu_interface vif;
  Driver drv_h;
  Monitor mon_h;
  Generator gen_h;
  Scoreboard scbd_h;

  mailbox #(Transaction) gen2drv_h,mon_in_h,mon_out_h;

  function new(virtual alu_interface vif);
    this.vif = vif;
  endfunction
  
  virtual task build;
    drv_h = new(vif);
    gen_h = new();
    scbd_h = new();
    mon_h = new(vif);

    gen2drv_h = new(1);
    mon_in_h = new();
    mon_out_h = new();

    drv_h.build();
    gen_h.build();
    scbd_h.build();
    mon_h.build();

    drv_h.gen2drv_h = gen2drv_h;
    gen_h.gen2drv_h = gen2drv_h;
    mon_h.mon_in_h = mon_in_h;
    scbd_h.mon_in_h = mon_in_h;
    mon_h.mon_out_h = mon_out_h;
    scbd_h.mon_out_h = mon_out_h;
  endtask
  
  virtual task reset();
    drv_h.reset();
    gen_h.reset();
    mon_h.reset();
    scbd_h.reset();
  endtask

  virtual task run(int n);
    fork 
      drv_h.run(n);
      gen_h.run(n);
      mon_h.run(n);
      scbd_h.run(n);
    join
  endtask

  virtual task check(int n);
    fork
      drv_h.check(n);
      gen_h.check(n);
      mon_h.check(n);
      scbd_h.check(n);
    join
  endtask

endclass
