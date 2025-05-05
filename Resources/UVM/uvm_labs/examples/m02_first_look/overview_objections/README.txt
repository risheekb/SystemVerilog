This example raises an objection for every sequence item to measure
the overhead. It is based on the example in:
uvm_labs/examples/m02_first_look/overview_dut_ifc/ which has a single
register and a tiny testbench, plus a little more code for
measurement.


Run the example for 1,000,000 sequence items, with and without an
objection for every sequence item:

	% compile.csh
	% compile.csh +objection

Change the number of sequence items (default in tx_sequence)
	% compile.csh +items=42

For 1M items, there was only a 10% difference. In a real design, this
overhead would be unnoticeable.
