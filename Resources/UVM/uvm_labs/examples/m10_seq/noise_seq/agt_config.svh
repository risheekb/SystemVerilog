class agt_config extends uvm_object;
  `uvm_object_utils(agt_config)
  function new(string name="agt_config");
    super.new(name);
  endfunction

  uvm_sequencer sqr;
endclass
  
