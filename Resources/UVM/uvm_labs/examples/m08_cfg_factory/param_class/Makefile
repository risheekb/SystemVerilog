# Makefile for a simple example
# Pass in a new test name with
# make test=usb_fixed_addr_test

test=usb_test

run: *.sv *.svh
	./compile.csh $(test)

clean:
	@rm -rf work transcript *.log *~ qrun.*

check_rpt:
	@./compile.csh > /dev/null
	@../../../bin/check_rpt.csh
