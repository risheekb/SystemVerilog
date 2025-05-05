# Makefile for a simple example

run: *.sv *.svh
	./compile.csh

# Regression test
check_rpt:
	@./compile.csh > /dev/null
	@../../../bin/check_rpt.csh

clean:
	@rm -rf work transcript *.log *~ qrun.*
