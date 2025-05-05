This example is the full code for the UVM course Module 8
Configuration and Factory, showing how to override a sequence item in
a single agent that is in an array of agents.

This contains a complete UVM testbench from test, env, agent, driver,
sequencer, and sequence, environment and agent configuration classes
plus a DUT and interface.

There are 4 agents and we only want to override the sequence item
tx_item in agt2 with tx_item_dst9, which has a soft constraint to
set dst==9.

Run the example with:
	% make

You can tell the override is working by looking for the UVM_INFO msg:

   In tx_pkg.tx_item_dst9.post_randomize()


Step 1: The test in tx_test.svh calls:

    tx_item::type_id::set_inst_override( tx_item_dst9::get_type(),
    					  "uvm_test_top.env.agt2*");

Note the wildcard at the end so that this affects any object created
with a reference to the sequencer.


Step 2:

The sequence in tx_sequence,svh needs to create items with an
instance reference. This can be done two ways. You can add a component
handle in the call to create:

      req = tx_item::type_id::create("req", get_sequencer());

The alternative is to use the macro `uvm_create() which does this
automatically, and also sets the parent sequence handle.

      `uvm_create(req)

If the sequence items are NOT created with a component instance
handle, req = ...::create("req"), set_inst_override() does not work.
