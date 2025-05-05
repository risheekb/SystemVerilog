#!/bin/csh -f
#----------------------------------------------------------------------
# Unix script to compile, optimize, and run example
# Runs in batch, not with the GUI
# One optional argument - the UVM test name

# Check for a UVM test name
set default_test = "usb_test"
set uvm_test = $1
if ("x$1" == "x") then
#    echo
#    echo "***INFO: No UVM test name specified, using $default_test. Next time try:"
#    echo " $0 $default_test"
    set uvm_test = $default_test
    echo
endif

echo "Compiling and running batch with test name $uvm_test"

qrun -quiet \
	-timescale "1ns/1ns" \
	 +define+UVM_REPORT_DISABLE_FILE_LINE \
	usb_pkg.sv \
	usb_interface.sv \
	dut.sv \
	top_tb.sv \
	top_hdl.sv \
	$2 $3 $4 \
	+UVM_TESTNAME=$uvm_test \
        +uvm_set_config_int=uvm_test_top,addr,\'hF1FA \
        +UVM_NO_RELNOTES
