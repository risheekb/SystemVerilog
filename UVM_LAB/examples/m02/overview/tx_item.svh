class tx_item extends uvm_sequence_item;
  `uvm_object_utils(tx_item);
  rand bit [7:0] data;

  function new(string name="tx_item");
    super.new(name);
  endfunction
endclass
