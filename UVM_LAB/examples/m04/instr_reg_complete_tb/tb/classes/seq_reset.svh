class seq_reset extends uvm_sequence #(tx_in);
  `uvm_object_utils(seq_reset)

  function new(string name ="seq_reset");
    super.new(name);
  endfunction

  virtual task body();

    tx_in tx; //handle to the input sequence

    `uvm_info("REST_TEST","\n\n*** Generating 3 sequences with reset_n active and load_en inactive ***\n",UVM_MEDIUM)
    tx = tx_in::type_id::create("tx_in");
    start_item(tx);
    if(!tx.randomize()) `uvm_fatal(get_type_name(),"Randomization Failed..")
    tx.reset_n = 1'b1; //turn off reset_n (active low)
    tx.load_en = 1'b0; //turn off load_en (active high)
    finish_item(tx);

    repeat(2) begin
      tx = tx_in::type_id::create("tx_in");
      start_item(tx);
      if(!tx.randomize()) `uvm_fatal(get_type_name(),"Randomization Failed..")
      tx.reset_n = 1'b0; // turn on reset_n
      finish_item(tx);
    end
    `uvm_info("REST_TEST","\n\n*** Generating 3 sequences with reset_n active and load_en active ***\n",UVM_MEDIUM)
    repeat(3) begin
      tx = tx_in::type_id::create("tx_in");
      start_item(tx);
      if(!tx.randomize()) `uvm_fatal(get_type_name(),"Randomization Failed..")
      tx.reset_n = 1'b0; // turn on reset_n
      tx.load_en = 1'b1; // turn on reset_n
      finish_item(tx);
    end
  endtask
endclass
