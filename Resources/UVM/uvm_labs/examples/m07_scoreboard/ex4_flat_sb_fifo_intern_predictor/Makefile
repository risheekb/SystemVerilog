# Makefile for the example

run: *.sv
	./compile.csh

# Test the scoreboard with errors in the ALU
# Must compile first
bad:
	vsim opt \
		+BAD_ADD \
		+UVM_TESTNAME=alu_test \
		+UVM_NO_RELNOTES \
		-batch -do "run -all; quit"

clean:
	@rm -rf work transcript *.log *~ qrun*

check_rpt:
	@./compile.csh > /dev/null
	@../../../bin/check_rpt.csh
