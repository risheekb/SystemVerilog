This example has both a single top module hierarchy and dual top. It
is from chapter 2 of the Siemens UVM course.

This contains a complete UVM testbench from test, env, agent, driver,
sequencer, and sequence, plus a DUT and interface.

The specific sequence is manually set in tx_test with:
	seq.start(env.agt.sqr);

It does creates the TLM between the sequencer and driver.  The
sequence sends the the randomized data across the TLM and the driver
receives it and prints it out.

It has a DUT, an 8-bit FF.  Error injection is provided with
	+FORCE_ERROR=n
where n is the number of cycles to the error.

It has interfaces and virtual interfaces.

It uses the configuration database to send the virtual interface
to the driver and monitor.

It has phase objections in the test. 

Delays the end of test with:
	set_drain_time(this, 100);

It does NOT use the factory to override a component or transaction.

It does NOT have a virtual sequencer.

It has a monitor with a very simplistic scoreboard.

It does NOT have a real scoreboard.

No functional coverage.

No register layer.
