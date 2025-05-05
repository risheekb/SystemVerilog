class BothTest extends BaseTest;
  function new(virtual instr_register_inf io);
    super.new(io);
  endfunction

  virtual task run(int n);
    $display("Writing Normal Transactions");
    gen_h.blueprint_h = Transaction::new();
    super.run(n);
    super.check(n);
    $display("Writing DivideBy0 Transactions");
    gen_h.blueprint_h = DivideBy0::new();
    super.run(n);
    super.check(n);
  endtask
endclass
