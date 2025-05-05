This example is the full code for the UVM course, Module 8
Configuration and Factory, with the example from the slides, showing
the configuration flow. This version substitutes set_config()
functions for the uvm_config_db calls inside the testbench. The DB is
still used to transfer the virtual interfaces from top_hdl to top_tb.

Run the example with:
% make test=usb_fixed_addr_test

It should finish with:
# UVM_INFO :   34
# UVM_WARNING :    0
# UVM_ERROR :    0
# UVM_FATAL :    0
# ** Report counts by id
# [ADDR]     5
# [MON_IN]     5
# [MON_OUT]     5
# [Questa UVM]     2
# [RNTST]     1
# [TEST_DONE]     1
# [TEST_TOPO]     1
# [SEND]    10
# [UVMTOP]     1
# [UVM_CMDLINE_PROC]     1
# [usb_driver]     1
# [usb_fixed_addr_test]     1

Run other tests with:
% make test=usb_fixed_addr2_test
% make test=usb_test


This contains a complete UVM testbench from test, env, agent, driver,
sequencer, and sequence, environment and agent configuration classes
plus a DUT and interface.

The specific sequence is manually set in usb_test with:
	seq.start(env.agt.sqr, usb_cfg);

Since this example is from Chapter 8, it does not yet show base
classes. As a result, there is a lot of repetative code in the test
classes.

It creates the TLM between the sequencer and driver.  The
sequence sends the the randomized addr across the TLM and the driver
receives it and prints it out.

It has a DUT, an 8-bit FF.  Error injection is provided with
	+FORCE_ERROR=n
where n is the number of cycles to the error.

It has interfaces and virtual interfaces.

It uses the configuration database to send the virtual interface to
the driver and monitor.

It has objections in the test.

Delays the end of test with:
	set_drain_time(this, 20);

Run the example with:
% make test=usb_fixed_addr_test

It does NOT use the factory to override a component or transaction.

It does NOT have a virtual sequencer.

It has a monitor with a very simplistic scoreboard.

It does NOT have a real scoreboard.

No functional coverage.

No register layer.

------------------------------------------------------------------
Part 2 - Configure sequence

The test usb_fixed_addr_test configures and runs the
usb_fixed_addr_sequence by calling it's init_start() task
with the sequencer handle and configuration object. This task then
starts the sequence, which sets the destination address to the addr
field in the usb_config object.

Run the example with:
% make test=usb_fixed_addr_test

------------------------------------------------------------------
Part 3 - Shows how to fetch the configuration object from the DB
These are less recommended than previous approaches.

See usb_fixed_addr2_sequence and usb_fixed_addr2_test
