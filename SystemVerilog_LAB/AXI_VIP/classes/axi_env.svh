class axi_env;
  axi_bfm bfm;
  axi_gen gen;
  axi_mon mon;
  axi_cov cov;
  axi_scb scb;

  function new();
    bfm = new();
    gen = new();
    mon = new();
    cov = new();
    scb = new();
  endfunction

  virtual task run();
    $display("axi_env::run");
    fork 
      mon.run();
      scb.run();
      gen.run();
      bfm.run();
      cov.run();
    join
  endtask
endclass
