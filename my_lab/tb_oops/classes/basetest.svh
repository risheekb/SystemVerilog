class BaseTest;
  virtual instr_register_inf v_io;
  Generator gen_h;
  Driver drv_h;
  Monitor mon_h;
  Scoreboard scbd_h;

  function new(virtual instr_register_inf v_io);
    this.v_io = v_io;
    scbd_h    = new();
    drv_h     = new(v_io);
    gen_h     = new(drv_h);
    mon_h     = new(v_io,scbd_h);
  endfunction
  
  task run(int n);
    $display("Calling Reset");
    drv_h.reset();
    $display("Writing Values into the Instruction Register");
    
    fork 
      gen_h.run(n);
      mon_h.run(n);
    join
    
    $display("Reading Values from the Instruction Register");
    fork 
      gen_h.check(n);
      mon_h.check(n);
    join
  endtask

endclass
