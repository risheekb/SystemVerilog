class Div0Test extends BaseTest;
  
  function new(virtual instr_register_inf io);
    super.new(io);
  endfunction
  
  virtual task run(int n);
    $display("Writing DivideBy0 Transactions");
    gen_h.blueprint_h = DivideBy0::new();
    super.run(n);
  endtask


  
endclass
