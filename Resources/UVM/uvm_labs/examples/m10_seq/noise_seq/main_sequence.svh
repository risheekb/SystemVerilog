// This sequence just pumps out an item every 7ns, 5 items total

class main_sequence extends uvm_sequence;
  `uvm_object_utils(main_sequence)
  function new(string name="main_sequence");
    super.new(name);
  endfunction

  virtual task body();
    for (int i=0; i<5; i++) begin
      #7ns;
      `uvm_info("MAIN", $sformatf("Item #%0d", i), UVM_MEDIUM)
    end
    `uvm_info("MAIN", "Done", UVM_MEDIUM)
  endtask

endclass
