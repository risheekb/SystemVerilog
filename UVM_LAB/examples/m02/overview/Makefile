compile:
	vlog tx_ifc.sv dut.sv tx_pkg.sv top_tb.sv top_hdl.sv

opt: compile
	vopt top_tb top_hdl +acc -o top_opt

sim: opt
	vsim -c top_opt +UVM_TESTNAME=tx_test -do "run -all"

run: sim
