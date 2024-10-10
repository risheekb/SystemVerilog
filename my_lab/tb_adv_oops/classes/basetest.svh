class BaseTest;
  virtual instr_register_inf v_io;
  Generator gen_h;
  Driver drv_h;
  Monitor mon_h;
  Scoreboard scbd_h;

  function new(virtual instr_register_inf v_io);
    this.v_io = v_io;
  endfunction
  
  virtual task build();
    scbd_h    = new();
    drv_h     = new(v_io);
    gen_h     = new(drv_h);
    mon_h     = new(v_io,scbd_h);

    drv_h.build();
    gen_h.build();
    mon_h.build();
    scbd_h.build();
  endtask
  
  virtual task reset();
    drv_h.reset();
    gen_h.reset();
    mon_h.reset();
    scbd_h.reset();
  endtask

  virtual task run(int n);
    $display("Writing Values into the Instruction Register");
    
    fork 
      drv_h.run(n);
      gen_h.run(n);
      mon_h.run(n);
      scbd_h.run(n);
    join
  endtask
  virtual task check(int n);
    $display("Reading Values from the Instruction Register");
    fork
      drv_h.check(n);
      gen_h.check(n);
      mon_h.check(n);
      scbd_h.check(n);
    join
  endtask

  virtual task report();
    fork
      drv_h.report();
      gen_h.report();
      mon_h.report();
      scbd_h.report();
    join
  endtask

endclass
