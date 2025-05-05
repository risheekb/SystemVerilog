class MULTest extends BaseTest;
  
  function new(virtual alu_interface vif);
    super.new(vif);
  endfunction
  
  virtual task run(int n);
    gen_h.blueprint_h = MULTransaction::new();
    super.run(n);
  endtask

endclass
