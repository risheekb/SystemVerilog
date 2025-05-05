# Makefile for the simple Hello World example

# Default: just run with the default script
run: *.sv
	./compile.csh

# Run in GUI
debug gui: clean
	vlog hello_pkg.sv top.sv
	vopt +acc -o opt top
	vsim -gui +UVM_TESTNAME=hello_test +UVM_NO_RELNOTES -classdebug -uvmcontrol=all,-trlog opt

# Regression test
check_rpt:
	@./compile.csh > /dev/null
	@../../../bin/check_rpt.csh

clean:
	rm -rf work qrun* transcript *.log *~
