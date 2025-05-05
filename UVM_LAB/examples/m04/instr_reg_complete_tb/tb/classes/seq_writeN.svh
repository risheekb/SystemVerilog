class seq_writeN extends uvm_sequence #(tx_in);
  `uvm_object_utils(seq_writeN)

  function new(string name="seq_writeN");
    super.new(name);
  endfunction

  agent_config agt_cfg;

  virtual task init_start(input uvm_sequencer #(tx_in) seq,input agent_config agt_cfg);
    this.start(seq);
    this.agt_cfg = agt_cfg;
  endtask


  virtual task body();

    tx_in tx;
    tx = tx_in::type_id::create("tx");
    start_item(tx);
    tx.reset_n = 0;
    tx.load_en = 0;
    tx.read_pointer = tx.last_write_pointer;
    finish_item(tx);

    repeat(agt_cfg.nitems) begin
      tx = tx_in::type_id::create("tx");
      start_item(tx);
      if(!tx.randomize()) `uvm_fatal(get_type_name(),"Randomization Failed")
      finish_item(tx);
    end
  endtask
endclass
