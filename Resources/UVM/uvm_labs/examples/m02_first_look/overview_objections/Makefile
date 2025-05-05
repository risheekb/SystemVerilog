# Makefile for the overview example with two different compile scripts

# Default - single top
run: *.sv *.svh
	./compile.csh
	./compile.csh +objection

clean:
	@rm -rf work transcript *.log *~ qrun.*

# Regression test
check_rpt:
	@./compile.csh > /dev/null
	@../../../bin/check_rpt.csh
