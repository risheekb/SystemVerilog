# Makefile for a simple example

run: *.sv *.svh
	./compile.csh

tar:	clean
	cd ..; tar cvf left_right.tar left_right

clean:
	rm -rf qrun.* work transcript *.log *~

check_rpt:
	@./compile.csh > /dev/null
	@../../../bin/check_rpt.csh
