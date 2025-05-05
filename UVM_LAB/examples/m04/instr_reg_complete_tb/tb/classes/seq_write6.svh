class seq_write6 extends uvm_sequence #(tx_in);
  `uvm_object_utils(seq_write6)
  
  function new(string name="seq_write6");
    super.new(name);
  endfunction

  virtual task body();
    tx_in tx;
    repeat(6) begin
      tx = tx_in::type_id::create();
      start_item(tx);
      if(!tx.randomize()) `uvm_fatal(get_type_name(),"Randomization Failed!!!")
      finish_item(tx);
    end
    tx = tx_in::type_id::create();
    start_item(tx);
    tx.reset_n = 1; 
    tx.load_en = 0;
    tx.read_pointer = tx.last_write_pointer;
    finish_item(tx);
  endtask
endclass
