This contains a complete UVM testbench from test, env, agent, driver,
sequencer, and sequence.

It matches the code in the Siemens UVM Basic course, module 2

There are two flavors:

Single top: Compile and simulate with compile_top.bat or in Questa
with compile_top.do

Dual top: Compile and simulate with compile_dual.bat or in Questa
with compile_dual.do

The specific sequence is manually set in tx_test with:
seq.start(env.agt.sqr);

It creates the TLM between the sequencer and driver.  The sequence
sends the the randomized data across the TLM and the driver receives
it and prints it out.

It does NOT have a DUT.

It does NOT use the configuration database.

It does NOT use the factory to override a class, such as a
transaction.

It does NOT use phase objections.

It does NOT have a virtual sequencer.

It does NOT have a monitor.

It does NOT have a scoreboard.

It does NOT have a DUT. So it does NOT use interfaces, virtual interfaces or
clocking blocks.

No coverage.

No register layer.
