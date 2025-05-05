run:
	./compile.csh

clean:
	@rm -rf work transcript *.log *~ qrun.* lab_test_write6.log.rpt

# Regression test
check_rpt:
	@./compile.csh > /dev/null
	@../../../bin/check_rpt.csh lab_test_write6.log
