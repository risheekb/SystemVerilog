# Makefile for the example

run: *.sv
	./compile.csh

clean:
	@rm -rf work transcript *.log *~ qrun.*

check_rpt:
	@./compile.csh > /dev/null
	@../../../bin/check_rpt.csh
