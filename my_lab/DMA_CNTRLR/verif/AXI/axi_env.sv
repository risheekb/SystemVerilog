class axi_env;
  axi_responder axi_responder_h;
  axi_mon axi_mon_h;

  function new();
    axi_responder_h = new();
    axi_mon_h = new();
  endfunction

  task run;
    fork
      axi_responder_h.run();
      axi_mon_h.run();
    join
  endtask

endclass
