class tx_sequence extends uvm_sequence #(tx_item);

  `uvm_object_utils(tx_sequence)
  function new(string name="tx_sequence");
    super.new(name);
  endfunction

  virtual task body();
    repeat(5)begin
      req = tx_item::type_id::create("req");
      start_item(req);
      if(!req.randomize())
        `uvm_fatal(get_type_name,"tx_item Randomization Failed")
      `uvm_info("DATA",$sformatf("seq = req.data= %3d",req.data),UVM_FULL)

      finish_item(req);
    end
  endtask
endclass
