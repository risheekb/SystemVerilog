# Makefile for a simple example
# Pass in a new test name with
# make test=tx_fixed_addr_test

test=tx_test

run: *.sv *.svh
	./compile.csh $(test)

clean:
	@rm -rf work transcript *.log *.wlf *.vstf certe_dump.xml *~ qrun.*

check_rpt:
	@./compile.csh > /dev/null
	@../../../bin/check_rpt.csh
