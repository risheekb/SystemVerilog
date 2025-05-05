@rem Windows DOS script to run the AHB example with Questa GUI

vsim -gui -classdebug^
	+UVM_TESTNAME=ahb_test_wr_rd ^
	+UVM_NO_RELNOTES ^
	opt