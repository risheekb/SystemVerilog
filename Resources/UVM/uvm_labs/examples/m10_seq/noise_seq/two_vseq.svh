class two_vseq extends uvm_sequence;
  `uvm_object_utils(two_vseq)
  function new(string name="two_vseq");
    super.new(name);
  endfunction

  agt_config agt_cfg;
  virtual task init_start(agt_config agt_cfg);
    this.agt_cfg = agt_cfg;
    this.start(agt_cfg.sqr);
  endtask
  
  virtual task body();
    main_sequence main_seq;
    noise_sequence noise_seq;
    main_seq  = main_sequence::type_id::create("main_seq");
    noise_seq = noise_sequence::type_id::create("noise_seq");

    `uvm_info("TWO", "Starting main_seq and noise_seq", UVM_MEDIUM)

    // Spawn two sequences, end when first finishes
    fork
      noise_seq.start(get_sequencer());
      main_seq.start(get_sequencer());
    join_any
    `uvm_info("TWO", "join_any, part 1\n", UVM_MEDIUM)

    // Does this mess up the state of the sequencer? YES!
    // # UVM_FATAL @ 35  20: uvm_test_top.env.agt.sqr@@noise_seq [SEQ_NOT_DONE] Sequence uvm_test_top.env.agt.sqr.noise_seq already started
    // disable fork;

    `uvm_info("TWO", "Ending noise sequence", UVM_MEDIUM)


    // Clean way to tell noise sequence to stop
//    noise_seq.end_sequence(); // Clean OOP style

    // Ugly slam-on-the-brakes style
    noise_seq.stop = 1;


    // The child sequences are done, so you could exit this parent sequence
//    return;

    // If you want to restart those child sequence, either call the above
    // user-defined method end_sequence() or use this wait() + #1ns
    wait (noise_seq.stop == 0);
    `uvm_info("TWO", "Ended noise sequence\n", UVM_MEDIUM)
    #1ns;    // Dummy delay so all sequences can finish, before restarting them
    `uvm_info("TWO", "Starting main_seq and noise_seq again, after #1 delay", UVM_MEDIUM)

    // Again, spawn two sequences, end when first finishes
    // See if the sequencer is still working
    fork
      noise_seq.start(get_sequencer());
      main_seq.start(get_sequencer());
    join_any
    `uvm_info("TWO", "join_any, part 2", UVM_MEDIUM)
  endtask


endclass
