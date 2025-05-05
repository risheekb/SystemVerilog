vlog -timescale "1ns/1ns" ^
	+define+UVM_REPORT_DISABLE_FILE_LINE ^
	spi_pkg.sv ^
	usb_pkg.sv ^
	usb_interface.sv ^
	dut.sv ^
	top_tb.sv ^
	top_hdl.sv


vopt +acc top_tb top_hdl -o top_opt

vsim top_opt ^
	+UVM_TESTNAME=usb_test ^
	+UVM_NO_RELNOTES ^
	+uvm_set_config_int=uvm_test_top,addr,'hF1FA ^
	-classdebug -uvmcontrol=all \
	 -do "run -all"
