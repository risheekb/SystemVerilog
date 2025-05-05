# Makefile for the overview example with two different compile scripts

both: single dual

# Single top
single: *.sv *.svh
	./compile_single.csh

# Dual top
dual: *.sv *.svh
	./compile_dual.csh

clean:
	@rm -rf work transcript *.log *~ qrun.*

# Regression test
check_rpt:
	@./compile.csh > /dev/null
	@../../../bin/check_rpt.csh
