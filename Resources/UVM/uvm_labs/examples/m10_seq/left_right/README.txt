This UVM example shows two sequences that alternate back and forth.
Left runs, then passes control to Right. It runs, then passes control
to Left, and so forth.

# UVM_INFO @ 0ns: uvm_test_top.env.agt.sqr@@vseq.left [LEFT] ONE
# UVM_INFO @ 5ns: uvm_test_top.env.agt.sqr@@vseq.right [RIGHT] TWO
# UVM_INFO @ 40ns: uvm_test_top.env.agt.sqr@@vseq.left [LEFT] THREE
# UVM_INFO @ 60ns: uvm_test_top.env.agt.sqr@@vseq.right [RIGHT] FOUR
# UVM_INFO @ 80ns: uvm_test_top.env.agt.sqr@@vseq.right [RIGHT] DONE
# UVM_INFO @ 80ns: uvm_test_top.env.agt.sqr@@vseq.left [LEFT] DONE

The two sequences are in tx_seq_left.svh and tx_seq_right.svh which
are started by the virtual sequence in tx_vseq.svh

The virtual sequence declares a SystemVerilog semaphore, key. The
child sequences alternate using the semaphore get() and put()
methods. The child sequences call get_parent_sequencer() to get a
handle to the virtual sequence and key.

The example has only a single interface. It could be easily extended
to have two asynchronous interfaces.

This contains a complete UVM testbench from test, env, agent, driver,
sequencer, and sequence, matching the code in the Siemens UVM Basic
course, module 2.
