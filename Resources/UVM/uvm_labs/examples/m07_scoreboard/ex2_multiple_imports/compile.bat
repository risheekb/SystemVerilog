@rem Windows DOS script to compile and run with Questa

vlog alu/alu_pkg.sv alu/alu_test_pkg.sv ^
     alu/alu_ifc.sv alu/alu.sv ^
     top_tb.sv top_hdl.sv

vopt +acc top_tb top_hdl -o opt

vsim opt ^
     +UVM_TESTNAME=alu_test ^
     +UVM_NO_RELNOTES ^
     -do "run -all"
exit


@rem Add this switch to vsim line to cause errors with ADD operations
@rem     +BAD_ADD ^
