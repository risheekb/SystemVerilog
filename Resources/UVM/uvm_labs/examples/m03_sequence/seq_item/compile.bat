REM Windows script to compile an example of a UVM sequence item with do_*() methods.

vlog seq_item.sv ^
	+incdir+C:/questasim_10.6/uvm-1.1d/../verilog_src/uvm-1.1d/src ^
         +define+UVM_NO_DEPRECATED ^
         +UVM_NO_RELNOTES

vsim -batch +UVM_TESTNAME=seq_item_test -do "run -all; quit" seq_item