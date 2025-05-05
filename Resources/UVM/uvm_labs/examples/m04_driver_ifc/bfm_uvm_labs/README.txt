This example shows the UVM course labs, with UVMF-style communication
with the DUT. Instead of having a single interface with signals and
methods, there are 3 interfaces:
- tx_ifc: just the DUT signals
- tx_driver_bfm: method to send a transaction to DUT
- tx_monitor_bfm: methods to monitor input and output transactions

These are in the lab_testbench directory.
